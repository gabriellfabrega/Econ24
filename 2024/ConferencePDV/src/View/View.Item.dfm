object ViewItem: TViewItem
  AlignWithMargins = True
  Left = 0
  Top = 0
  Width = 171
  Height = 252
  Color = 15790320
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -20
  Font.Name = 'Segoe UI'
  Font.Style = []
  ParentBackground = False
  ParentColor = False
  ParentFont = False
  TabOrder = 0
  object imgItem: TImage
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 165
    Height = 129
    Align = alClient
    Center = True
    Stretch = True
    ExplicitWidth = 245
    ExplicitHeight = 206
  end
  object lblDescItem: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 138
    Width = 102
    Height = 28
    Align = alBottom
    Caption = 'lblDescItem'
  end
  object lblPreco: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 172
    Width = 37
    Height = 28
    Align = alBottom
    Caption = '0,00'
  end
  object btnAdicionar: TButton
    AlignWithMargins = True
    Left = 3
    Top = 206
    Width = 165
    Height = 43
    Align = alBottom
    Caption = 'Adicionar'
    TabOrder = 0
    ExplicitWidth = 206
  end
end
