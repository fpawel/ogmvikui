unit pipe;

interface



type
    TPipeClient = class
    private
        { Private declarations }
        hPipe: THANDLE; // дескриптор
        buf : array [0..1000] of byte;
    public
        { Public declarations }
        Constructor Create(pipe_server : string);
        procedure WriteInt(v:LONGWORD);
        function ReadInt:LONGWORD;

        procedure WriteString(s:string);
        function ReadString:string;
    end;

implementation

uses sysutils, Winapi.Windows, System.WideStrUtils;


type _LONGWORD_BYTES = record

    case Integer of
      0: (bytes: array [0..3] of BYTE );
      1: (value: longword);
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

Constructor TPipeClient.Create(pipe_server : string);
begin
    hPipe := CreateFileW(PWideChar('\\.\pipe\$'+ pipe_server + '$'), GENERIC_READ or
      GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil,
      OPEN_EXISTING, 0, 0);
    if hPipe = INVALID_HANDLE_VALUE then
        terminate_error('hPipe = INVALID_HANDLE_VALUE');

end;

function TPipeClient.ReadInt:LONGWORD;
var x : _LONGWORD_BYTES;
    readed_count: DWORD;
begin
    if not ReadFile(hPipe, x.bytes, 4, readed_count, nil) then begin
        terminate_error('ReadInt: ReadFile error');
    end;
    if readed_count <> 4 then begin
        terminate_error('ReadInt: readed_count <> 4');
    end;
    result := x.value;
end;

procedure TPipeClient.WriteInt(v:LongWord);
var
    writen_count: DWORD;
    x : _LONGWORD_BYTES;

begin
    x.value := v;
    if not(WriteFile(hPipe, x.bytes, 4, writen_count, nil)) then begin
        terminate_error('WriteInt: WriteFile error');
    end;
    if writen_count <> 4 then begin
        terminate_error('WriteInt: writen_count <> 4');
    end;
end;


procedure TPipeClient.WriteString(s:string);
var writen_count: DWORD;
    i,len : Cardinal;

begin
    len := Length(s) * sizeof(char);
    if len >= Length(self.buf) + 1 then begin
        raise Exception.Create('Превышен размер буфера');
    end;
    self.WriteInt(len);
    if len=0 then
        exit;

    Move(s[1], self.buf, len);

    if not(WriteFile(hPipe,  self.buf, len, writen_count, nil)) then begin
        terminate_error('WriteString: WriteFile error');
    end;
    if writen_count <> len then begin
        terminate_error('WriteString: writen_count <> 1');
    end;
end;

function TPipeClient.ReadString:string;
var readed_count: DWORD; len : LongWord;
    b:array [0..1000] of byte;
begin
    len := ReadInt;
    if not ReadFile(hPipe, b, len, readed_count, nil) then begin
        terminate_error('ReadString: ReadFile error');
    end;
    if readed_count <> len then begin
        terminate_error(Format('ReadString: readed_count = %d <> str len = %d', [readed_count, len]));
    end;
    SetString(Result, PAnsiChar(@b[0]), len);
    Finalize(b);

end;






end.
