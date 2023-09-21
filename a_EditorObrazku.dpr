program a_EditorObrazku;

uses
  Vcl.Forms,
  WinApi.Windows,
  System.SysUtils,
  unHlavniEditorObrazku in 'unHlavniEditorObrazku.pas' {foHlavniEditorObrazku},
  unGlobals in 'X:\00_spolecne_UNIT\u_globalni\unGlobals.pas',
  unVars in 'X:\00_spolecne_UNIT\u_globalni\unVars.pas',
  prace_s_domenou in 'X:\00_spolecne_UNIT\u_domena\prace_s_domenou.pas',
  unDatabaze in 'X:\00_spolecne_UNIT\u_globalni\unDatabaze.pas',
  unRunElevatedSupport in 'X:\00_spolecne_UNIT\u_globalni\unRunElevatedSupport.pas',
  unSeznamMutexu in 'X:\00_spolecne_UNIT\u_globalni\unSeznamMutexu.pas',
  Unit_cekej in 'X:\00_spolecne_UNIT\u_cekej\Unit_cekej.pas' {frc};

{$R *.res}

var MX_obrazek: THandle;
    hwd: LongWord;
begin
  MX_obrazek := CreateMutex(nil, False, PWideChar(jmenoMutexu(ExtractFileName(Application.ExeName))));
  if MX_obrazek <> 0 then
  try //0
    if WaitForSingleObject(MX_obrazek, 0) = WAIT_OBJECT_0 then
    begin //1
      try
        if (ParamStr(1) = 'administrace_editor_obrazku') and
           (ParamStr(2) <> '') and  //user_id
           (ParamStr(3) <> '') then //aktualni db?
        begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Editor firemních log a razítek';
  Application.CreateForm(TfoHlavniEditorObrazku, foHlavniEditorObrazku);
  Application.CreateForm(Tfrc, frc);
  Application.Run;
        end else begin
          Chyba('Program nelze spustit samostatnì');
        end;
      finally
        ReleaseMutex(MX_obrazek);
      end;
    end else begin
      hwd := FindWindow(PWideChar('TfoHlavniEditorObrazku'), nil);
      if hwd <> 0 then SetForegroundWindow(hwd);
    end;
  finally   //0
    CloseHandle(MX_obrazek);
  end;
end.
