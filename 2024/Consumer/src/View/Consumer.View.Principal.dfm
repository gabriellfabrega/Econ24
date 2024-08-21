object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  Caption = 'Consumer'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 21
  object edtTopico: TLabeledEdit
    Left = 8
    Top = 32
    Width = 612
    Height = 29
    EditLabel.Width = 44
    EditLabel.Height = 21
    EditLabel.Caption = 'T'#243'pico'
    TabOrder = 0
    Text = ''
  end
  object edtClientId: TLabeledEdit
    Left = 8
    Top = 96
    Width = 393
    Height = 29
    EditLabel.Width = 59
    EditLabel.Height = 21
    EditLabel.Caption = 'Client ID'
    TabOrder = 1
    Text = 'ED123'
  end
  object ComboBox1: TComboBox
    Left = 407
    Top = 96
    Width = 213
    Height = 29
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'QoS 0'
    Items.Strings = (
      'QoS 0'
      'QoS 1'
      'QoS 2')
  end
  object mLog: TMemo
    Left = 8
    Top = 216
    Width = 612
    Height = 218
    ScrollBars = ssBoth
    TabOrder = 3
  end
  object btnDesativar: TButton
    Left = 243
    Top = 152
    Width = 145
    Height = 41
    Caption = 'Desativar'
    TabOrder = 4
    OnClick = btnDesativarClick
  end
  object btnInscrever: TButton
    Left = 401
    Top = 152
    Width = 145
    Height = 41
    Caption = 'Inscrever'
    TabOrder = 5
    OnClick = btnInscreverClick
  end
  object btnAtivar: TButton
    Left = 84
    Top = 152
    Width = 145
    Height = 41
    Caption = 'Ativar'
    TabOrder = 6
    OnClick = btnAtivarClick
  end
  object IcsMQTTClient1: TIcsMQTTClient
    KeepAlive = 10
    MaxRetries = 8
    RetryTime = 60
    Clean = False
    Broker = False
    AutoSubscribe = False
    Host = '172.20.10.5'
    Port = 1883
    LocalBounce = False
    SslVerifyCerts = False
    SslReportChain = False
    SslRevocation = False
    SslCliSecurity = sslCliSecIgnore
    OnClientID = IcsMQTTClient1ClientID
    OnMon = IcsMQTTClient1Mon
    OnOnline = IcsMQTTClient1Online
    OnOffline = IcsMQTTClient1Offline
    OnEnableChange = IcsMQTTClient1EnableChange
    OnFailure = IcsMQTTClient1Failure
    OnMsg = IcsMQTTClient1Msg
    Left = 304
    Top = 248
  end
end
