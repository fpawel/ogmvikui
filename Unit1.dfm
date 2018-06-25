object Form1: TForm1
  Left = 0
  Top = 0
  Caption = #1046#1091#1088#1085#1072#1083' '#1042#1080#1050
  ClientHeight = 673
  ClientWidth = 1132
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel3: TPanel
    Left = 0
    Top = 10
    Width = 10
    Height = 653
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel5: TPanel
    Left = 1122
    Top = 10
    Width = 10
    Height = 653
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
  end
  object PageControl1: TPageControl
    Left = 872
    Top = 10
    Width = 250
    Height = 653
    ActivePage = TabSheet3
    Align = alRight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = #1060#1080#1083#1100#1090#1088
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 567
      object Label7: TLabel
        Left = 6
        Top = 50
        Width = 55
        Height = 23
        Caption = #1052#1077#1089#1103#1094
      end
      object Label1: TLabel
        Left = 6
        Top = 11
        Width = 31
        Height = 23
        Caption = #1043#1086#1076
      end
      object Label3: TLabel
        Left = 6
        Top = 94
        Width = 33
        Height = 23
        Caption = #1052'/'#1083
      end
      object Label4: TLabel
        Left = 6
        Top = 166
        Width = 107
        Height = 23
        Caption = #1048#1089#1087#1086#1083#1085#1077#1085#1080#1077
      end
      object Label2: TLabel
        Left = 6
        Top = 238
        Width = 56
        Height = 23
        Caption = #1053#1086#1084#1077#1088
      end
      object ComboBox3: TComboBox
        Left = 72
        Top = 8
        Width = 119
        Height = 31
        Style = csDropDownList
        TabOrder = 0
        OnChange = ComboBox3Change
      end
      object ComboBox4: TComboBox
        Left = 72
        Top = 47
        Width = 119
        Height = 31
        Style = csDropDownList
        TabOrder = 1
        OnChange = ComboBox4Change
      end
      object Edit1: TEdit
        Left = 6
        Top = 125
        Width = 187
        Height = 31
        TabOrder = 2
        Text = 'Edit1'
        OnChange = Edit1Change
      end
      object ComboBox1: TComboBox
        Left = 6
        Top = 197
        Width = 187
        Height = 31
        Style = csDropDownList
        TabOrder = 3
        OnChange = ComboBox1Change
        Items.Strings = (
          '2'
          '4'
          '6'
          ' ')
      end
      object Edit2: TEdit
        Left = 6
        Top = 269
        Width = 91
        Height = 31
        TabOrder = 4
        Text = 'Edit1'
        OnChange = Edit2Change
      end
      object Edit3: TEdit
        Left = 103
        Top = 269
        Width = 91
        Height = 31
        TabOrder = 5
        Text = 'Edit1'
        OnChange = Edit3Change
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 567
      object Label5: TLabel
        Left = 6
        Top = 8
        Width = 33
        Height = 23
        Caption = #1052'/'#1083
      end
      object Label6: TLabel
        Left = 6
        Top = 90
        Width = 39
        Height = 23
        Caption = #1048#1089#1087'.'
      end
      object Label8: TLabel
        Left = 6
        Top = 144
        Width = 59
        Height = 23
        Caption = #1050#1086#1083'-'#1074#1086
      end
      object Label9: TLabel
        Left = 67
        Top = 40
        Width = 7
        Height = 23
        Caption = '-'
      end
      object Label10: TLabel
        Left = 142
        Top = 40
        Width = 7
        Height = 23
        Caption = '/'
      end
      object Edit4: TEdit
        Left = 6
        Top = 37
        Width = 55
        Height = 31
        TabOrder = 0
      end
      object Edit5: TEdit
        Left = 81
        Top = 37
        Width = 55
        Height = 31
        TabOrder = 1
      end
      object Edit7: TEdit
        Left = 156
        Top = 37
        Width = 55
        Height = 31
        TabOrder = 2
      end
      object ComboBox2: TComboBox
        Left = 86
        Top = 87
        Width = 66
        Height = 31
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 3
        Text = '2'
        Items.Strings = (
          '2'
          '4'
          '6')
      end
      object Edit6: TEdit
        Left = 86
        Top = 141
        Width = 66
        Height = 31
        TabOrder = 4
      end
      object Button2: TButton
        Left = 6
        Top = 197
        Width = 211
        Height = 69
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 5
        OnClick = Button2Click
      end
    end
    object TabSheet3: TTabSheet
      Caption = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090#1099
      ImageIndex = 2
      object Button1: TButton
        Left = 3
        Top = 16
        Width = 222
        Height = 65
        Caption = #1042' '#1085#1072#1095#1072#1083#1086
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button3: TButton
        Left = 3
        Top = 87
        Width = 222
        Height = 65
        Caption = #1042' '#1082#1086#1085#1077#1094
        TabOrder = 1
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 3
        Top = 158
        Width = 222
        Height = 65
        Caption = 'PDF'
        TabOrder = 2
        OnClick = Button4Click
      end
      object Button5: TButton
        Left = 3
        Top = 229
        Width = 222
        Height = 65
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 3
        OnClick = Button5Click
      end
    end
  end
  object Panel1: TPanel
    Left = 862
    Top = 10
    Width = 10
    Height = 653
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 1132
    Height = 10
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
  end
  object Panel7: TPanel
    Left = 0
    Top = 663
    Width = 1132
    Height = 10
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
  end
  object StringGrid1: TStringGrid
    Left = 10
    Top = 10
    Width = 852
    Height = 653
    Align = alClient
    BevelOuter = bvNone
    DrawingStyle = gdsClassic
    FixedColor = clWindow
    FixedCols = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goTabs, goThumbTracking]
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 6
    OnSelectCell = StringGrid1SelectCell
    OnSetEditText = StringGrid1SetEditText
    ColWidths = (
      54
      110
      84
      90
      92)
    RowHeights = (
      24
      24
      24
      24
      24)
  end
end
