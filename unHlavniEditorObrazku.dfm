object foHlavniEditorObrazku: TfoHlavniEditorObrazku
  Left = 0
  Top = 0
  Caption = 'Editor firemn'#237'ch log a raz'#237'tek'
  ClientHeight = 671
  ClientWidth = 1198
  Color = 3294992
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    1198
    671)
  TextHeight = 13
  object Label1: TLabel
    Left = 198
    Top = 32
    Width = 30
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'N'#225'zev'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 1120
    Top = 8
    Width = 66
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Nov'#253' obr'#225'zek'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
    ExplicitLeft = 537
  end
  object Label3: TLabel
    Left = 198
    Top = 74
    Width = 176
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Obr'#225'zek firmy (200x100 px 200 DPI)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 198
    Top = 250
    Width = 254
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Obr'#225'zek firmy vysok'#233' rozli'#353'en'#237' (400x200 px 200 DPI)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 710
    Top = 74
    Width = 144
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Raz'#237'tko (200x100 px 200 DPI)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 710
    Top = 250
    Width = 222
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Raz'#237'tko vysok'#233' rozli'#353'en'#237' (400x200 px 200 DPI)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 198
    Top = 93
    Width = 236
    Height = 118
    Anchors = [akTop, akRight]
    TabOrder = 11
    ExplicitLeft = 194
    object ImageLogoLow: TImage
      Left = 0
      Top = 0
      Width = 236
      Height = 118
      Stretch = True
    end
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 177
    Height = 634
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsObrazky
    DrawingStyle = gdsGradient
    GradientEndColor = clMedGray
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'Nazev'
        Title.Caption = 'N'#225'zev'
        Width = 108
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Plati'
        Title.Caption = 'Plat'#237
        Width = 31
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 947
    Top = 578
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Nov'#253
    TabOrder = 5
    OnClick = Button1Click
    ExplicitLeft = 943
    ExplicitTop = 577
  end
  object Button2: TButton
    Left = 947
    Top = 617
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Ulo'#382'it'
    Enabled = False
    TabOrder = 7
    OnClick = Button2Click
    ExplicitLeft = 943
    ExplicitTop = 616
  end
  object Button3: TButton
    Left = 1108
    Top = 617
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Konec'
    TabOrder = 9
    OnClick = Button3Click
    ExplicitLeft = 1104
    ExplicitTop = 616
  end
  object Edit1: TEdit
    Left = 198
    Top = 51
    Width = 155
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 1
    OnChange = Edit1Change
    ExplicitLeft = 194
  end
  object Button4: TButton
    Left = 1028
    Top = 578
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Smazat'
    TabOrder = 6
    OnClick = Button4Click
    ExplicitLeft = 1024
    ExplicitTop = 577
  end
  object Button5: TButton
    Left = 279
    Top = 217
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Vyber'
    TabOrder = 3
    OnClick = Button5Click
    ExplicitLeft = 275
  end
  object Button6: TButton
    Left = 359
    Top = 217
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Odstra'#328
    TabOrder = 4
    OnClick = Button6Click
    ExplicitLeft = 355
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 652
    Width = 1198
    Height = 19
    Panels = <>
    ExplicitTop = 651
    ExplicitWidth = 1194
  end
  object Button7: TButton
    Left = 1028
    Top = 617
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Storno'
    Enabled = False
    TabOrder = 8
    OnClick = Button7Click
    ExplicitLeft = 1024
    ExplicitTop = 616
  end
  object PetraCheckBox1: TPetraCheckBox
    Left = 359
    Top = 53
    Width = 60
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Plat'#237
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = Edit1Change
    ExplicitLeft = 355
  end
  object Panel2: TPanel
    Left = 198
    Top = 269
    Width = 472
    Height = 236
    Anchors = [akTop, akRight]
    TabOrder = 12
    ExplicitLeft = 194
    object ImageLogoHigh: TImage
      Left = 0
      Top = 0
      Width = 472
      Height = 236
      Stretch = True
    end
  end
  object Button8: TButton
    Left = 515
    Top = 511
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Vyber'
    TabOrder = 13
    OnClick = Button8Click
    ExplicitLeft = 511
  end
  object Button9: TButton
    Left = 595
    Top = 511
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Odstra'#328
    TabOrder = 14
    OnClick = Button9Click
    ExplicitLeft = 591
  end
  object Panel3: TPanel
    Left = 710
    Top = 93
    Width = 236
    Height = 118
    Anchors = [akTop, akRight]
    TabOrder = 15
    ExplicitLeft = 706
    object ImageRazitkoLow: TImage
      Left = 0
      Top = 0
      Width = 236
      Height = 118
      Stretch = True
    end
  end
  object Button10: TButton
    Left = 791
    Top = 217
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Vyber'
    TabOrder = 16
    OnClick = Button10Click
    ExplicitLeft = 787
  end
  object Button11: TButton
    Left = 871
    Top = 217
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Odstra'#328
    TabOrder = 17
    OnClick = Button11Click
    ExplicitLeft = 867
  end
  object Panel4: TPanel
    Left = 710
    Top = 269
    Width = 472
    Height = 236
    Anchors = [akTop, akRight]
    TabOrder = 18
    ExplicitLeft = 706
    object ImageRazitkoHigh: TImage
      Left = 0
      Top = 0
      Width = 472
      Height = 236
      Stretch = True
    end
  end
  object Button12: TButton
    Left = 1027
    Top = 511
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Vyber'
    TabOrder = 19
    OnClick = Button12Click
    ExplicitLeft = 1023
  end
  object Button13: TButton
    Left = 1107
    Top = 511
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Odstra'#328
    TabOrder = 20
    OnClick = Button13Click
    ExplicitLeft = 1103
  end
  object adocon_local: TADOConnection
    LoginPrompt = False
    Provider = 'SQLNCLI11.1'
    Left = 31
    Top = 104
  end
  object adocon_server: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 36
    Top = 440
  end
  object query_server_pomoc: TADOQuery
    LockType = ltReadOnly
    Parameters = <>
    Left = 26
    Top = 296
  end
  object qyObrazky: TADOQuery
    Connection = adocon_server
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'Id_pracovnik'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT x.*, vy.Id_celek_vykonal, zu.Jmeno, vy.Cena, vy.Mnozstvi,' +
        ' vy.Poznamka AS vykonal_pozn,'
      
        '  SUM(vy.Mnozstvi) OVER (PARTITION BY x.Id_celek) AS Suma_celku,' +
        ' SUM(vy.Mnozstvi) OVER () AS Suma_global'
      'FROM p_s_celek_vykonal as vy'
      
        'INNER JOIN (SELECT s.Id_celek, s.Porost, s.Porost_index, s.Ploch' +
        'a, zk.Firma AS Zakaznik,'
      
        '  zl.Nazev AS [Nazev_ls], zc.Cislo AS [Cislo_zakazka], zu.Nazev ' +
        'AS [Nazev_uj], zr.Nazev AS [Nazev_revir],'
      ''
      '  v.Cislo + pvc.Cislo + '#39' - '#39' + pvt.Nazev AS vykon,'
      ''
      '  ms.kod AS Material, s.Poznamka, s.Navedeno, s.Id_pracovnik'
      'FROM p_s_celek as s'
      
        'INNER JOIN t_t_zakaznik AS zk ON zk.Id_zakaznik = s.Id_zakaznik ' +
        'AND ISNULL(zk.Plati, 0) = 1'
      
        'INNER JOIN t_t_zakazka AS zz ON zz.Id_zakazka = s.Id_zakazka AND' +
        ' ISNULL(zz.Plati, 0) = 1'
      
        'INNER JOIN t_t_zakazka_ls AS zl ON zl.Id_zakazka_ls = zz.Id_zaka' +
        'zka_ls AND ISNULL(zl.Plati, 0) = 1'
      
        'INNER JOIN t_t_zakazka_cislo AS zc ON zc.Id_zakazka_cislo = zz.I' +
        'd_zakazka_cislo AND ISNULL(zc.Plati, 0) = 1'
      
        'INNER JOIN t_t_zakazka_uj AS zu ON zu.Id_zakazka_uj = zz.Id_zaka' +
        'zka_uj AND ISNULL(zu.Plati, 0) = 1'
      
        'INNER JOIN t_t_zakazka_revir AS zr ON zr.Id_zakazka_revir = zz.I' +
        'd_zakazka_revir AND ISNULL(zr.Plati, 0) = 1'
      
        'INNER JOIN p_t_vykon_spoj AS vs ON vs.Id_vykon_spoj = s.id_vykon' +
        '_spoj AND ISNULL(vs.Plati, 0) = 1 AND ISNULL(vs.Smazano, 0) = 0'
      ''
      
        'INNER JOIN p_t_vykon AS v ON v.Id_vykon = vs.id_vykon AND ISNULL' +
        '(v.Plati, 0) = 1 AND ISNULL(v.Smazano, 0) = 0'
      
        'INNER JOIN p_t_podvykon_cislo AS pvc ON pvc.Id_podvykon_cislo = ' +
        'vs.Id_podvykon_cislo AND ISNULL(v.Plati, 0) = 1 AND ISNULL(v.Sma' +
        'zano, 0) = 0'
      
        'INNER JOIN p_t_podvykon_text AS pvt ON pvt.Id_podvykon_text = vs' +
        '.Id_podvykon_text AND ISNULL(v.Plati, 0) = 1 AND ISNULL(v.Smazan' +
        'o, 0) = 0'
      ''
      
        'LEFT OUTER JOIN p_t_material_spoj AS ms ON ms.id_material_spoj =' +
        ' s.id_material_spoj AND ISNULL(ms.Plati, 0) = 1 AND ISNULL(ms.Sm' +
        'azano, 0) = 0'
      'WHERE ISNULL(s.Smazano, 0) = 0) AS x ON x.Id_celek = vy.Id_celek'
      
        'INNER JOIN t_t_zamestnanec AS za ON za.Id_zamestnanec = vy.Id_za' +
        'mestnanec'
      
        'INNER JOIN t_t_zamestnanec_udaje AS zu ON zu.Id_zamestnanec_udaj' +
        'e = za.Id_zamestnanec_udaje'
      'WHERE x.Id_pracovnik = :Id_pracovnik'
      'ORDER BY x.Navedeno DESC')
    Left = 34
    Top = 368
  end
  object dsObrazky: TDataSource
    DataSet = qyObrazky
    OnDataChange = dsObrazkyDataChange
    Left = 32
    Top = 232
  end
  object PetraDBGridSaver1: TPetraDBGridSaver
    UkladanyDBGrid = DBGrid1
    ZakazanePole.Strings = (
      'Id_obrazek')
    PouzivatMaxSirkuSloupce = True
    Left = 36
    Top = 168
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'JPEG Image File (*.jpg)|*.jpg|JPEG Image File (*.jpeg)|*.jpeg'
    Left = 32
    Top = 40
  end
end
