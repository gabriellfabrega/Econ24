object ViewPrincipal: TViewPrincipal
  Left = 0
  Top = 0
  Caption = 'ViewPrincipal'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 21
  object mLog: TMemo
    Left = 8
    Top = 24
    Width = 612
    Height = 401
    ScrollBars = ssBoth
    TabOrder = 0
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
    Left = 128
    Top = 160
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\SAMSUNG\Desktop\Embarcadero-Conference\2024\Db' +
        '\CONFERENCE.db'
      'OpenMode=ReadWrite'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 128
    Top = 96
  end
end
