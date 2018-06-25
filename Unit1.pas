unit Unit1;

interface
(*
std::ofstream outFile("data.txt");
    cds1->First();
    while(!cds1->Eof )
    {
        outFile << AnsiString().sprintf("%d,%d,%s,%s\n",
            cds1CodeNum->Value,
            cds1Quantity->Value,
            cds1RouteSheet->Value,
            DateToStr(cds1TheDate->Value) ).c_str();
        cds1->Next();
    }
    outFile.close();
*)

uses
    pipe,
    Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
    System.Classes, Vcl.Graphics, System.DateUtils,
    Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ExtCtrls,
    Vcl.ComCtrls, System.Generics.Collections, Vcl.Menus;

type
    TForm1 = class(TForm)
        Panel3: TPanel;
        Panel5: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label7: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    ComboBox3: TComboBox;
    ComboBox4: TComboBox;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit7: TEdit;
    ComboBox2: TComboBox;
    Edit6: TEdit;
    Button2: TButton;
    Panel1: TPanel;
    Panel4: TPanel;
    Panel7: TPanel;
    StringGrid1: TStringGrid;
    TabSheet3: TTabSheet;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
        procedure FormCreate(Sender: TObject);
        procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
          const Value: string);
        procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
          var CanSelect: Boolean);
    procedure Edit1Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    private
        { Private declarations }
        
        // To remember the last cell edited
        Last_Edited_Col, Last_Edited_Row: Integer;

        procedure fetch_filter_and_records_from_pipe2;


    public
        { Public declarations }

    end;

var
    Form1: TForm1;

implementation


type

    TReadPipeThread = class(TThread)
    private
        procedure Execute; override;
    end;

const
    ACTION_CELL_EDITED = 0;
    ACTION_CELL_REQUEST = 1;
    action_Year = 2;
    action_Month = 3;
	action_RouteSheetMask = 4;
	action_DocCode = 5;

    action_OrderFrom = 6;
    action_Orderto = 7;

    action_acts = 8;
    action_new_record = 9;
    action_delete = 10;
var
    exe_dir: string;
    pipe_write: TPipeClient;
    pipe_read: TPipeClient;
    readPipeThread: TReadPipeThread;

procedure TReadPipeThread.Execute;
var
    cmd_code: byte;

    readed_count: DWORD;
    buf: array [0 .. 2000] of byte;
    data: array of byte;
    data_bytes_count: longword;
    i: Integer;

begin
    while not Terminated do
    begin
        case pipe_read.ReadInt of
            0:
                Synchronize(Form1.fetch_filter_and_records_from_pipe2);

        end;
    end;

end;

procedure terminate_error(error_text: string);
var
    f: TextFile;
    col, row: Integer;
begin
    AssignFile(f, exe_dir + '\dedtgo.txt');
    ReWrite(f);
    WriteLn(f, error_text);
    CloseFile(f);
    ExitProcess(1);
end;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
    try
        StringGrid1.TopRow := 1;
        StringGrid1.Row := 1;

    finally

    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
    var doc_code,count:integer;
begin
    pipe_write.WriteInt(action_new_record);
    pipe_write.WriteString( Edit4.Text + '/'+ Edit5.Text + '-' + Edit7.Text);
    pipe_write.WriteString(comboBox2.Text);
    pipe_write.WriteString(Edit6.Text);

    Edit4.SetFocus;


end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    try
        StringGrid1.TopRow := StringGrid1.RowCount - StringGrid1.VisibleRowCount;
        StringGrid1.Row := StringGrid1.RowCount - 1;
    finally

    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
    pipe_write.WriteInt(action_acts);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
    pipe_write.WriteInt(action_delete);
    pipe_write.WriteInt( StringGrid1.Row - 1);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
    pipe_write.WriteInt(action_DocCode);
    pipe_write.WriteString( ComboBox1.Text );
end;

procedure TForm1.ComboBox3Change(Sender: TObject);
var n:integer;
begin
    pipe_write.WriteInt(action_Year);
    pipe_write.WriteString( combobox3.Text );
end;

procedure TForm1.ComboBox4Change(Sender: TObject);
begin
    pipe_write.WriteInt(action_Month);
    pipe_write.WriteString( IntToStr(combobox4.ItemIndex) );
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
    pipe_write.WriteInt(action_RouteSheetMask);
    pipe_write.WriteString( Edit1.Text );
end;

procedure TForm1.Edit2Change(Sender: TObject);
begin
    pipe_write.WriteInt(action_OrderFrom);
    pipe_write.WriteString( Edit2.Text );
end;

procedure TForm1.Edit3Change(Sender: TObject);
begin
    pipe_write.WriteInt(action_orderto);
    pipe_write.WriteString( Edit3.Text );
end;


procedure TForm1.fetch_filter_and_records_from_pipe2;
var
    i, c, r: Integer;
    fmt: system.SysUtils.TFormatSettings;
    str,s:string;
begin
    fmt := TFormatSettings.Create;
    fmt.DateSeparator := '/';

    s := pipe_read.ReadString;
    Combobox3.OnChange := nil;
    Combobox3.Items.Clear;
    Combobox3.Items.Add('');
    Combobox3.ItemIndex := 0;
    for I := 1 to 20 do
        begin
            str := inttostr(2008 + i);
            Combobox3.Items.Add(str);
            if str = s then
            begin
              Combobox3.ItemIndex := i;
            end;
        end;
    Combobox3.OnChange := ComboBox3Change;

    s := pipe_read.ReadString;
    Combobox4.OnChange := nil;
    Combobox4.Items.Clear;
    Combobox4.Items.Add('');
    Combobox4.ItemIndex := 0;
    for I := 1 to 12 do
        begin
            Combobox4.Items.Add(System.SysUtils.FormatSettings.LongMonthNames[i]);
            if s = IntToStr(i) then
            begin
              Combobox4.ItemIndex := i;
            end;
        end;
    Combobox4.OnChange := ComboBox4Change;

    Edit1.OnChange := nil;
    Edit1.Text := pipe_read.ReadString;
    Edit1.OnChange := self.Edit1Change;

    ComboBox1.OnChange := nil;
    ComboBox1.Text := pipe_read.ReadString;
    ComboBox1.OnChange := ComboBox1Change;

    Edit2.OnChange := nil;
    Edit2.Text := pipe_read.ReadString;
    Edit2.OnChange := self.Edit2Change;

    Edit3.OnChange := nil;
    Edit3.Text := pipe_read.ReadString;
    Edit3.OnChange := self.Edit3Change;

    StringGrid1.OnSetEditText := nil;
    // кол-во строк таблицы
    StringGrid1.RowCount := pipe_read.ReadInt + 1;
    if StringGrid1.RowCount > 1 then
        StringGrid1.FixedRows := 1;
    for r := 1 to StringGrid1.RowCount - 1 do
    begin
        StringGrid1.Cells[0, r] := inttostr(pipe_read.ReadInt);
        StringGrid1.Cells[1, r] := pipe_read.ReadString;
        StringGrid1.Cells[2, r] := inttostr(pipe_read.ReadInt);
        StringGrid1.Cells[3, r] := pipe_read.ReadString;
        StringGrid1.Cells[4, r] := inttostr(pipe_read.ReadInt);
    end;
    StringGrid1.OnSetEditText := StringGrid1SetEditText;
    try
        StringGrid1.TopRow := StringGrid1.RowCount - StringGrid1.VisibleRowCount;
    finally

    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
    col, row: Integer;
begin

    StringGrid1.Cells[0, 0] := '№';
    StringGrid1.Cells[1, 0] := 'Дата';
    StringGrid1.Cells[2, 0] := 'Код';
    StringGrid1.Cells[3, 0] := 'М/л';
    StringGrid1.Cells[4, 0] := 'Кол-во';

    Last_Edited_Col := -1;
    Last_Edited_Row := -1;

    pipe_write := TPipeClient.Create('OGMVIKTABLE');
    pipe_read := TPipeClient.Create('OGMVIKTABLE2');
    readPipeThread := TReadPipeThread.Create;



end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
    // When selecting a cell
    if StringGrid1.EditorMode then
    begin // It was a cell being edited
        StringGrid1.EditorMode := false; // Deactivate the editor
        // Do an extra check if the LastEdited_ACol and LastEdited_ARow are not -1 already.
        // This is to be able to use also the arrow-keys up and down in the Grid.
        if (Last_Edited_Col <> -1) and (Last_Edited_Row <> -1) then
            StringGrid1SetEditText(Sender, Last_Edited_Col, Last_Edited_Row,
              StringGrid1.Cells[Last_Edited_Col, Last_Edited_Row]);
        // Just make the call
    end;
    // Do whatever else wanted
    if (acol=1) or (arow=0) then
        StringGrid1.Options := StringGrid1.Options - [goEditing]
    else
        StringGrid1.Options := StringGrid1.Options + [goEditing];
end;

procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
    pt: TPoint;
    s: string;
begin

    
    // Fired on every change
    if Not StringGrid1.EditorMode // goEditing must be 'True' in Options
    then
    begin // Only after user ends editing the cell
        Last_Edited_Col := -1; // Indicate no cell is edited
        Last_Edited_Row := -1; // Indicate no cell is edited
        // Do whatever wanted after user has finish editing a cell

        pipe_write.WriteInt(ACTION_CELL_REQUEST);
        pipe_write.WriteInt(ACol);
        pipe_write.WriteInt(ARow);
        s := pipe_write.ReadString;
        if s<>value then
        begin
            StringGrid1.OnSetEditText := nil;
            StringGrid1.Cells[acol,arow] := s;
            StringGrid1.OnSetEditText := self.StringGrid1SetEditText;
        end;


    end
    else
    begin // The cell is being editted
        Last_Edited_Col := ACol; // Remember column of cell being edited
        Last_Edited_Row := ARow; // Remember row of cell being edited
    end;



    pipe_write.WriteInt(ACTION_CELL_EDITED);
    pipe_write.WriteInt(ACol);
    pipe_write.WriteInt(ARow);
    pipe_write.WriteString(Value);

end;

end.
