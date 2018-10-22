unit pipe;

interface

uses Winapi.Windows;

type
    TPipeClient = class
    private
        { Private declarations }
        hPipe: THANDLE; // дескриптор
        buf: array [0 .. 1000] of byte;

        procedure thisWriteFile(var Buffer;
          numberOfbytesToWrite: DWORD);
        procedure thisReadFile(var Buffer; numberOfbytesToRead: DWORD);
    public
        { Public declarations }
        Constructor Create(pipe_server: string);
        procedure WriteInt(v: LONGWORD);
        function ReadInt: LONGWORD;

        procedure WriteString(s: string);
        function ReadString: string;
    end;

implementation

uses sysutils,  System.WideStrUtils;

type
    _LONGWORD_BYTES = record

        case Integer of
            0:
                (bytes: array [0 .. 3] of byte);
            1:
                (value: LONGWORD);
    end;

procedure terminate_error(error_text: string);
var
    f: TextFile;
begin
    AssignFile(f, ExtractFileDir(paramstr(0)) + '\pipe_fail.txt');
    ReWrite(f);
    WriteLn(f, error_text);
    CloseFile(f);
    ExitProcess(1);
end;

Constructor TPipeClient.Create(pipe_server: string);
begin
    hPipe := CreateFileW(PWideChar('\\.\pipe\$' + pipe_server + '$'),
      GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
      OPEN_EXISTING, 0, 0);
    if hPipe = INVALID_HANDLE_VALUE then
        terminate_error('hPipe = INVALID_HANDLE_VALUE');

end;

procedure TPipeClient.thisReadFile(var Buffer; numberOfbytesToRead: DWORD);
var
    readed_count: DWORD;
begin
    if not ReadFile(hPipe, Buffer, numberOfbytesToRead, readed_count, nil) then
    begin
        terminate_error('ReadFile');
    end;

    if readed_count <> numberOfbytesToRead then
    begin
        terminate_error(Format('ReadFile: readed_count=%d, must be %d',
          [readed_count, numberOfbytesToRead]));
    end;
end;

function TPipeClient.ReadInt: LONGWORD;
var
    x: _LONGWORD_BYTES;
    readed_count: DWORD;
begin
    if not ReadFile(hPipe, x.bytes, 4, readed_count, nil) then
    begin
        terminate_error('ReadInt: ReadFile error');
    end;
    if readed_count <> 4 then
    begin
        terminate_error('ReadInt: readed_count <> 4');
    end;
    result := x.value;
end;

procedure TPipeClient.WriteInt(v: LONGWORD);
var
    writen_count: DWORD;
    x: _LONGWORD_BYTES;

begin
    x.value := v;
    if not(WriteFile(hPipe, x.bytes, 4, writen_count, nil)) then
    begin
        terminate_error('WriteInt: WriteFile error');
    end;
    if writen_count <> 4 then
    begin
        terminate_error('WriteInt: writen_count <> 4');
    end;
end;

procedure TPipeClient.thisWriteFile(var Buffer; numberOfbytesToWrite: DWORD);
var
    writen_count: DWORD;
begin
    
    if not(WriteFile(hPipe, Buffer, numberOfbytesToWrite, writen_count, nil))
    then
    begin
        terminate_error('WriteFile');
    end;
    if writen_count <> numberOfbytesToWrite then
    begin
        terminate_error(Format('WriteFile: writen_count=%d, must be %d',
          [writen_count, numberOfbytesToWrite]));
    end;
end;



procedure TPipeClient.WriteString(s: string);
var
    len: Integer;
    ptr_bytes: TBytes;

begin
    ptr_bytes := WideBytesOf(s);
    len := Length(ptr_bytes);
    WriteInt(len);
    thisWriteFile(ptr_bytes[0], len);
end;

function TPipeClient.ReadString: string;
var
    readed_count: DWORD;
    len: LONGWORD;
    i: Integer;
    Buffer: TBytes;
    Str: string;
begin
    len := ReadInt;
    if len = 0 then
        exit('');
    SetLength(Buffer, len);
    thisReadFile(Buffer[0], len);
    result := WideStringOf(Buffer);
end;

end.
