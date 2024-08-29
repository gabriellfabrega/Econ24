object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  Caption = 'Producer'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
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
  object edtMsg: TLabeledEdit
    Left = 8
    Top = 96
    Width = 393
    Height = 29
    EditLabel.Width = 77
    EditLabel.Height = 21
    EditLabel.Caption = 'Mensagem'
    TabOrder = 1
    Text = ''
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
  object btnAtivar: TButton
    Left = 83
    Top = 152
    Width = 145
    Height = 41
    Caption = 'Ativar'
    TabOrder = 3
    OnClick = btnAtivarClick
  end
  object mLog: TMemo
    Left = 8
    Top = 216
    Width = 612
    Height = 218
    ScrollBars = ssBoth
    TabOrder = 4
  end
  object btnDesativar: TButton
    Left = 243
    Top = 152
    Width = 145
    Height = 41
    Caption = 'Desativar'
    TabOrder = 5
    OnClick = btnDesativarClick
  end
  object btnPublicar: TButton
    Left = 401
    Top = 152
    Width = 145
    Height = 41
    Caption = 'Publicar'
    TabOrder = 6
    OnClick = btnPublicarClick
  end
  object IcsMQTTClient1: TIcsMQTTClient
    KeepAlive = 10
    MaxRetries = 8
    RetryTime = 60
    Clean = False
    Broker = False
    AutoSubscribe = False
    Host = 'ec2-54-198-90-92.compute-1.amazonaws.com'
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
