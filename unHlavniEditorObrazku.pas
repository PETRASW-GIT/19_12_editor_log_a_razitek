unit unHlavniEditorObrazku;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, JPEG,
  Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Data.Win.ADODB, unGlobals, unObsluhaCmp,
  unDbControlsPetra, Vcl.ExtDlgs, unPetraRadioGroup, System.UITypes;

type
  TfoHlavniEditorObrazku = class(TForm)
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Button4: TButton;
    ImageLogoLow: TImage;
    Button5: TButton;
    Button6: TButton;
    StatusBar1: TStatusBar;
    Panel1: TPanel;
    Label2: TLabel;
    adocon_local: TADOConnection;
    adocon_server: TADOConnection;
    query_server_pomoc: TADOQuery;
    qyObrazky: TADOQuery;
    dsObrazky: TDataSource;
    Button7: TButton;
    PetraDBGridSaver1: TPetraDBGridSaver;
    OpenPictureDialog1: TOpenPictureDialog;
    PetraCheckBox1: TPetraCheckBox;
    Label3: TLabel;
    Panel2: TPanel;
    ImageLogoHigh: TImage;
    Label4: TLabel;
    Button8: TButton;
    Button9: TButton;
    Label5: TLabel;
    Label6: TLabel;
    Panel3: TPanel;
    ImageRazitkoLow: TImage;
    Button10: TButton;
    Button11: TButton;
    Panel4: TPanel;
    ImageRazitkoHigh: TImage;
    Button12: TButton;
    Button13: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure provedSQL(idZaznamu: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1Change(Sender: TObject);
    procedure dsObrazkyDataChange(Sender: TObject; Field: TField);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button13Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
  private
    { Private declarations }
    prvniZobrazeni : Boolean;
    stavEditace: Integer; //0-nic, 1-editace, 2-nový
    procedure zmenStavPrvku;
    procedure natahniObrazek;
    procedure natahniObrazekHiRes;
    procedure natahniRazitko;
    procedure natahniRazitkoHiRes;
  public
    { Public declarations }
  end;

var
  foHlavniEditorObrazku: TfoHlavniEditorObrazku;

implementation

{$R *.dfm}

procedure TfoHlavniEditorObrazku.Button10Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    stavEditace := 1;
    zmenStavPrvku;
    if OpenPictureDialog1.Execute
      then ImageRazitkoLow.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end else if (stavEditace <> 0) then
  begin
    if OpenPictureDialog1.Execute
      then ImageRazitkoLow.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TfoHlavniEditorObrazku.Button11Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    stavEditace := 1;
    zmenStavPrvku;
    ImageRazitkoLow.Picture := nil;
  end else if (stavEditace <> 0) then
  begin
    ImageRazitkoLow.Picture := nil;
  end;
end;

procedure TfoHlavniEditorObrazku.Button12Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    stavEditace := 1;
    zmenStavPrvku;
    if OpenPictureDialog1.Execute
      then ImageRazitkoHigh.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end else if (stavEditace <> 0) then
  begin
    if OpenPictureDialog1.Execute
      then ImageRazitkoHigh.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TfoHlavniEditorObrazku.Button13Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    stavEditace := 1;
    zmenStavPrvku;
    ImageRazitkoHigh.Picture := nil;
  end else if (stavEditace <> 0) then
  begin
    ImageRazitkoHigh.Picture := nil;
  end;
end;

procedure TfoHlavniEditorObrazku.Button1Click(Sender: TObject);
begin
  //novy
  stavEditace := 2;
  zmenStavPrvku;
  Edit1.Text := '';
  PetraCheckBox1.Checked := True;
  Edit1.SetFocus;
end;

procedure TfoHlavniEditorObrazku.Button2Click(Sender: TObject);
var Str, Str2, Str3, Str4: TMemoryStream;
    L, L2, L3, L4: Word;
    S, S2, S3, S4: AnsiString;
    navrat: Integer;
begin
  if Length(Trim(Edit1.Text)) = 0 then
  begin
    Varovani('Název je povinný údaj');
    Edit1.SetFocus;
    Exit;
  end;

  with TADOQuery.Create(Application) do
  begin
    Connection := adocon_server;
    case stavEditace of
    1:begin  //edit
        SQL.Text := 'UPDATE t_t_obrazek SET Nazev = :Nazev, Obrazek = :Obrazek, Plati = :Plati, Obrazek_hi_res = :Obrazek_hi_res, ' +
                    '  Razitko = :Razitko, Razitko_hi_res = :Razitko_hi_res ' +
                    'WHERE Id_obrazek = :Id_obrazek';
        Parameters.ParamByName('Id_obrazek').Value := qyObrazky.FieldByName('Id_obrazek').Value;
      end;
    2:begin  //novy
        SQL.Text := 'INSERT INTO t_t_obrazek (Nazev, Obrazek, Plati, Obrazek_hi_res, Razitko, Razitko_hi_res) ' +
                    '  VALUES (:Nazev, :Obrazek, :Plati, :Obrazek_hi_res, :Razitko, :Razitko_hi_res)';
      end;
    end;
    Parameters.ParamByName('Nazev').DataType := ftString;
    Parameters.ParamByName('Nazev').Value := Edit1.Text;
    Parameters.ParamByName('Plati').Value := PetraCheckBox1.Checked;

    Str := TMemoryStream.Create;
    try
      if ImageLogoLow.Picture.Graphic <> nil then
      begin
        S := AnsiString(ImageLogoLow.Picture.Graphic.ClassName);
        L := Length(S);
        Str.Write(L, SizeOf(L));
        Str.Write(S[1], Length(S));
        ImageLogoLow.Picture.Graphic.SaveToStream(Str);
      end;
      Str.Position := 0;
      Parameters.ParamByName('Obrazek').LoadFromStream(Str, ftBlob);
    finally
      Str.Free;
    end;

    Str2 := TMemoryStream.Create;
    try
      if ImageLogoHigh.Picture.Graphic <> nil then
      begin
        S2 := AnsiString(ImageLogoHigh.Picture.Graphic.ClassName);
        L2 := Length(S2);
        Str2.Write(L2, SizeOf(L2));
        Str2.Write(S2[1], Length(S2));
        ImageLogoHigh.Picture.Graphic.SaveToStream(Str2);
      end;
      Str2.Position := 0;
      Parameters.ParamByName('Obrazek_hi_res').LoadFromStream(Str2, ftBlob);
    finally
      Str2.Free;
    end;

    Str3 := TMemoryStream.Create;
    try
      if ImageRazitkoLow.Picture.Graphic <> nil then
      begin
        S3 := AnsiString(ImageRazitkoLow.Picture.Graphic.ClassName);
        L3 := Length(S3);
        Str3.Write(L3, SizeOf(L3));
        Str3.Write(S3[1], Length(S3));
        ImageRazitkoLow.Picture.Graphic.SaveToStream(Str3);
      end;
      Str3.Position := 0;
      Parameters.ParamByName('Razitko').LoadFromStream(Str3, ftBlob);
    finally
      Str3.Free;
    end;

    Str4 := TMemoryStream.Create;
    try
      if ImageRazitkoHigh.Picture.Graphic <> nil then
      begin
        S4 := AnsiString(ImageRazitkoHigh.Picture.Graphic.ClassName);
        L4 := Length(S4);
        Str4.Write(L4, SizeOf(L4));
        Str4.Write(S4[1], Length(S4));
        ImageRazitkoHigh.Picture.Graphic.SaveToStream(Str4);
      end;
      Str4.Position := 0;
      Parameters.ParamByName('Razitko_hi_res').LoadFromStream(Str4, ftBlob);
    finally
      Str3.Free;
    end;

    try
      ExecSQL;
      if stavEditace = 2
        then navrat := DejIdentitu(adocon_server, 't_t_obrazek')
        else navrat := qyObrazky.FieldByName('Id_obrazek').Value;
    finally
      Free;
    end;
  end;
  stavEditace := 0;
  zmenStavPrvku;
  ProvedSQL(navrat);
end;

procedure TfoHlavniEditorObrazku.Button3Click(Sender: TObject);
begin
  Close;
end;

procedure TfoHlavniEditorObrazku.Button4Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    if Dotaz('Opravdu smazat logo "' + qyObrazky.FieldByName('Nazev').AsString + '" ze systému ?') = mrYes then
    begin
      with TADOQuery.Create(Application) do
      begin
        Connection := adocon_server;
        SQL.Text := 'UPDATE t_t_obrazek SET Smazano = 1 ' +
                    'WHERE Id_obrazek = :Id_obrazek';
        Parameters.ParamByName('Id_obrazek').Value := qyObrazky.FieldByName('Id_obrazek').Value;
        try
          ExecSQL;
        finally
          Free;
        end;
      end;
      provedSQL(-1);
    end;
  end;
end;

procedure TfoHlavniEditorObrazku.Button5Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    stavEditace := 1;
    zmenStavPrvku;
    if OpenPictureDialog1.Execute
      then ImageLogoLow.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end else if (stavEditace <> 0) then
  begin
    if OpenPictureDialog1.Execute
      then ImageLogoLow.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TfoHlavniEditorObrazku.Button6Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    stavEditace := 1;
    zmenStavPrvku;
    ImageLogoLow.Picture := nil;
  end else if (stavEditace <> 0) then
  begin
    ImageLogoLow.Picture := nil;
  end;
end;

procedure TfoHlavniEditorObrazku.Button7Click(Sender: TObject);
begin
  //storno
  stavEditace := 0;
  zmenStavPrvku;
  dsObrazkyDataChange(dsObrazky, qyObrazky.FieldByName('id_obrazek'));
end;

procedure TfoHlavniEditorObrazku.Button8Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    stavEditace := 1;
    zmenStavPrvku;
    if OpenPictureDialog1.Execute
      then ImageLogoHigh.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end else if (stavEditace <> 0) then
  begin
    if OpenPictureDialog1.Execute
      then ImageLogoHigh.Picture.LoadFromFile(OpenPictureDialog1.FileName);
  end;
end;

procedure TfoHlavniEditorObrazku.Button9Click(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Bof and qyObrazky.Eof)) then
  begin
    stavEditace := 1;
    zmenStavPrvku;
    ImageLogoHigh.Picture := nil;
  end else if (stavEditace <> 0) then
  begin
    ImageLogoHigh.Picture := nil;
  end;
end;

procedure TfoHlavniEditorObrazku.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdSelected in State) and (Sender is TDBGrid) then
  begin
    TDBGrid(Sender).Canvas.Brush.Color := $00344811;
    TDBGrid(Sender).Canvas.Font.Color:= clWhite;
    TDBGrid(Sender).Canvas.Font.Style:= Font.Style + [fsBold];
    TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State) ;
  end;
end;

procedure TfoHlavniEditorObrazku.dsObrazkyDataChange(Sender: TObject;
  Field: TField);
begin
  if not (qyObrazky.Bof and qyObrazky.Eof) and (stavEditace = 0) then
  begin
    Edit1.OnChange := nil;
    PetraCheckBox1.OnClick := nil;
    try
      Edit1.Text := qyObrazky.FieldByName('Nazev').AsString;
      PetraCheckBox1.Checked := qyObrazky.FieldByName('Plati').AsString = 'Ano';
      natahniObrazek;
      natahniObrazekHiRes;
      natahniRazitko;
      natahniRazitkoHiRes;
    finally
      Edit1.OnChange := Edit1Change;
      PetraCheckBox1.OnClick := Edit1Change;
    end;
  end;
end;

procedure TfoHlavniEditorObrazku.Edit1Change(Sender: TObject);
begin
  if (stavEditace = 0) and (not (qyObrazky.Eof and qyObrazky.Bof)) then //editace
  begin
    stavEditace := 1;
    zmenStavPrvku;
  end else if (stavEditace = 0) and (qyObrazky.Eof and qyObrazky.Bof) then  //prázdné - pak nový záznam
  begin
    stavEditace := 2;
    zmenStavPrvku;
  end;
end;

procedure TfoHlavniEditorObrazku.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PetraDBGridSaver1.UlozPole;
  UnRegisterClass(TJPEGImage);
end;

procedure TfoHlavniEditorObrazku.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if stavEditace > 0 then
  begin
    if Dotaz('Máte rozpracovaný obrázek, pøesto skonèit ?') <> mrYes
      then CanClose := False;
  end else
    CanClose := Dotaz('Opravdu zavøít program "' + Application.Title + '"?') = mrYes;
end;

procedure TfoHlavniEditorObrazku.FormCreate(Sender: TObject);
begin
  RegisterClass(TJPEGImage);
  startovaci_procedura_programu(adocon_local, adocon_server,
                                StrToIntDef(dekodujString(ParamStr(2)), 0), False);
  naplnStatusBar(StatusBar1, adocon_local);
  prvniZobrazeni := True;
  stavEditace := 0;
end;

procedure TfoHlavniEditorObrazku.FormShow(Sender: TObject);
begin
  if prvniZobrazeni then
  begin
    provedSQL(-1);
    PetraDBGridSaver1.NactiPole;
    prvniZobrazeni := False;
  end;
end;

procedure TfoHlavniEditorObrazku.natahniObrazek;
var Str: TMemoryStream;
    NewGraphic: TGraphic;
    GraphicClass: TGraphicClass;
    L: Word;
    S: AnsiString;
    qyVyber: TADOQuery;
begin
  Str := TMemoryStream.Create;
  qyVyber := TADOQuery.Create(nil);
  try
    with qyVyber do
    begin
      Connection := adocon_server;
      SQL.Text := 'SELECT Obrazek FROM t_t_obrazek WHERE id_obrazek = :id_obrazek AND ISNULL(Smazano, 0) = 0';
      Parameters.ParamByName('id_obrazek').Value := qyObrazky.FieldByName('id_obrazek').Value;
      Open;
    end;
    if (not qyVyber.Eof) and (qyVyber.FieldByName('Obrazek').Value <> null) then
    begin
      TBlobField(qyVyber.FieldByName('Obrazek')).SaveToStream(Str);
      Str.Position := 0;
      Str.Read(L, SizeOf(L));
      SetLength(S, L);
      Str.Read(S[1], Length(S));
      if Length(S) > 0 then
      begin
        GraphicClass := TGraphicClass(FindClass(String(S)));
        NewGraphic := GraphicClass.Create;
        NewGraphic.LoadFromStream(Str);
        ImageLogoLow.Picture.Graphic := NewGraphic;
        NewGraphic.Free;
      end;
    end else begin
      ImageLogoLow.Picture := nil;
    end;
  finally
    Str.Free;
    qyVyber.Free;
  end;
end;

procedure TfoHlavniEditorObrazku.natahniObrazekHiRes;
var Str: TMemoryStream;
    NewGraphic: TGraphic;
    GraphicClass: TGraphicClass;
    L: Word;
    S: AnsiString;
    qyVyber: TADOQuery;
begin
  Str := TMemoryStream.Create;
  qyVyber := TADOQuery.Create(nil);
  try
    with qyVyber do
    begin
      Connection := adocon_server;
      SQL.Text := 'SELECT Obrazek_hi_res FROM t_t_obrazek WHERE id_obrazek = :id_obrazek AND ISNULL(Smazano, 0) = 0';
      Parameters.ParamByName('id_obrazek').Value := qyObrazky.FieldByName('id_obrazek').Value;
      Open;
    end;
    if (not qyVyber.Eof) and (qyVyber.FieldByName('Obrazek_hi_res').Value <> null) then
    begin
      TBlobField(qyVyber.FieldByName('Obrazek_hi_res')).SaveToStream(Str);
      Str.Position := 0;
      Str.Read(L, SizeOf(L));
      SetLength(S, L);
      Str.Read(S[1], Length(S));
      if Length(S) > 0 then
      begin
        GraphicClass := TGraphicClass(FindClass(String(S)));
        NewGraphic := GraphicClass.Create;
        NewGraphic.LoadFromStream(Str);
        ImageLogoHigh.Picture.Graphic := NewGraphic;
        NewGraphic.Free;
      end;
    end else begin
      ImageLogoHigh.Picture := nil;
    end;
  finally
    Str.Free;
    qyVyber.Free;
  end;
end;

procedure TfoHlavniEditorObrazku.natahniRazitkoHiRes;
var Str: TMemoryStream;
    NewGraphic: TGraphic;
    GraphicClass: TGraphicClass;
    L: Word;
    S: AnsiString;
    qyVyber: TADOQuery;
begin
  Str := TMemoryStream.Create;
  qyVyber := TADOQuery.Create(nil);
  try
    with qyVyber do
    begin
      Connection := adocon_server;
      SQL.Text := 'SELECT Razitko_hi_res FROM t_t_obrazek WHERE id_obrazek = :id_obrazek AND ISNULL(Smazano, 0) = 0';
      Parameters.ParamByName('id_obrazek').Value := qyObrazky.FieldByName('id_obrazek').Value;
      Open;
    end;
    if (not qyVyber.Eof) and (qyVyber.FieldByName('Razitko_hi_res').Value <> null) then
    begin
      TBlobField(qyVyber.FieldByName('Razitko_hi_res')).SaveToStream(Str);
      Str.Position := 0;
      Str.Read(L, SizeOf(L));
      SetLength(S, L);
      Str.Read(S[1], Length(S));
      if Length(S) > 0 then
      begin
        GraphicClass := TGraphicClass(FindClass(String(S)));
        NewGraphic := GraphicClass.Create;
        NewGraphic.LoadFromStream(Str);
        ImageRazitkoHigh.Picture.Graphic := NewGraphic;
        NewGraphic.Free;
      end;
    end else begin
      ImageRazitkoHigh.Picture := nil;
    end;
  finally
    Str.Free;
    qyVyber.Free;
  end;
end;

procedure TfoHlavniEditorObrazku.natahniRazitko;
var Str: TMemoryStream;
    NewGraphic: TGraphic;
    GraphicClass: TGraphicClass;
    L: Word;
    S: AnsiString;
    qyVyber: TADOQuery;
begin
  Str := TMemoryStream.Create;
  qyVyber := TADOQuery.Create(nil);
  try
    with qyVyber do
    begin
      Connection := adocon_server;
      SQL.Text := 'SELECT Razitko FROM t_t_obrazek WHERE id_obrazek = :id_obrazek AND ISNULL(Smazano, 0) = 0';
      Parameters.ParamByName('id_obrazek').Value := qyObrazky.FieldByName('id_obrazek').Value;
      Open;
    end;
    if (not qyVyber.Eof) and (qyVyber.FieldByName('Razitko').Value <> null) then
    begin
      TBlobField(qyVyber.FieldByName('Razitko')).SaveToStream(Str);
      Str.Position := 0;
      Str.Read(L, SizeOf(L));
      SetLength(S, L);
      Str.Read(S[1], Length(S));
      if Length(S) > 0 then
      begin
        GraphicClass := TGraphicClass(FindClass(String(S)));
        NewGraphic := GraphicClass.Create;
        NewGraphic.LoadFromStream(Str);
        ImageRazitkoLow.Picture.Graphic := NewGraphic;
        NewGraphic.Free;
      end;
    end else begin
      ImageRazitkoLow.Picture := nil;
    end;
  finally
    Str.Free;
    qyVyber.Free;
  end;
end;

procedure TfoHlavniEditorObrazku.provedSQL(idZaznamu: Integer);
begin
  with qyObrazky do
  begin
    if Active then Close;
    SQL.Text := 'SELECT Id_obrazek, Nazev, CASE WHEN ISNULL(Plati, 0) = 1 THEN ''Ano'' ELSE '' '' END AS Plati ' +
                'FROM t_t_obrazek WHERE ISNULL(Smazano, 0) = 0 ORDER BY Nazev';
    Open;

    if idZaznamu > 0 then
    begin
      Locate('Id_obrazek', idZaznamu, [loCaseInsensitive, loPartialKey])
    end else begin
      First;
    end;
  end;
end;

procedure TfoHlavniEditorObrazku.zmenStavPrvku;
begin
  case stavEditace of
    0:begin
        DBGrid1.Enabled := True;
        Button1.Enabled := True;
        if not (qyObrazky.Eof and qyObrazky.Bof)
          then Button4.Enabled := True
          else Button4.Enabled := False;
        Button2.Enabled := False;
        Button7.Enabled := False;

        Label2.Visible := False;
    end;
    1:begin //editace
        DBGrid1.Enabled := False;

        Button1.Enabled := False;
        Button4.Enabled := False;
        Button2.Enabled := True;
        Button7.Enabled := True;
    end;
    2:begin  //novy
        DBGrid1.Enabled := False;

        ImageLogoLow.Picture := nil;
        ImageLogoHigh.Picture := nil;

        ImageRazitkoLow.Picture := nil;
        ImageRazitkoHigh.Picture := nil;

        Edit1.Enabled := True;

        Button1.Enabled := False;
        Button4.Enabled := False;
        Button2.Enabled := True;
        Button7.Enabled := True;

        Label2.Visible := True;
    end;
  end;
end;

end.
