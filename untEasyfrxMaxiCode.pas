{------------------------------------------------------------------------------
//                       HhfComponents For Delphi 7
//                         һ�����е�����������
//                         @Copyright 2013 hehf
//                   ------------------------------------
//
//            ���������ǹ�˾�ڲ�ʹ�ò���Դ������WWW,��Ϊ��������ʹ���κ�
//       �˲�����й,�������Ը�.
//
//            ʹ��Ȩ���Լ���ؽ�������ϵ�κ���
//
//            ��֪ʶת���ɲƸ��Ƹ�,�ñ��Ӽ���ȥ
//
//            ��վ��ַ��http://www.YiXuan-SoftWare.com
//            �����ʼ���hehaifeng1984@126.com
//                      YiXuan-SoftWare@hotmail.com
//            QQ      ��383530895
//            MSN     ��YiXuan-SoftWare@hotmail.com
//
------------------------------------------------------------------------------}
unit untEasyfrxMaxiCode;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, frxClass, Vcl.StdCtrls
{$IFDEF Delphi6}
, Variants
{$ENDIF};

type
  TEasyfrxMaxiBarcodeObject = class(TComponent);  // fake component

  TEasyfrxMaxiBarcodeView = class(TfrxView)
  private
    FEccLevel: SmallInt;
    FModule: SmallInt;
    FVersion: SmallInt;
    FText: String;
    FExpression: String;
    FLineColor: TColor;
    FBackgroundColor: TColor;
    FXmag: SmallInt;
    FCaption: String;
    FCaptionLayout: TTextLayout;
    procedure SetCaptionLayout(const Value: TTextLayout);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    class function GetDescription: String; override;
    procedure GetData; override;
  published
    property Version: SmallInt read FVersion write FVersion default 0;
    property DataField;
    property DataSet;
    property DataSetName;
    property Expression: String read FExpression write FExpression;
    property Frame;
    property Text: String read FText write FText;
    property BackgroundColor: TColor read FBackgroundColor write FBackgroundColor default clWhite;
    property LineColor: TColor read FLineColor write FLineColor default clBlack;
//    property Caption: String read FCaption write FCaption;
//    property CaptionLayout : TTextLayout read FCaptionLayout write SetCaptionLayout
//             default tlBottom;
  end;

implementation

uses untEasyfrxQRCodeRTTI, frxDsgnIntf, frxRes, frxUtils, untEasyBarCode2;

constructor TEasyfrxMaxiBarcodeView.Create(AOwner: TComponent);
begin
  inherited;
  FBackgroundColor := clWhite;
  FLineColor := clBlack;
//  FCaption := '';
//  FCaptionLayout := tlBottom;
end;

class function TEasyfrxMaxiBarcodeView.GetDescription: String;
begin
  Result := 'EasyPlate MaxiBarcode';
end;

procedure TEasyfrxMaxiBarcodeView.SetCaptionLayout(const Value: TTextLayout);
begin
  FCaptionLayout := Value;
end;

procedure TEasyfrxMaxiBarcodeView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
const
  sFileName = 'MaxiCode.bmp';
var
  oBmp: TBitmap;
  AMaxi: TEasyMaxiCodeBarcode;
begin
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);

  AMaxi := TEasyMaxiCodeBarcode.Create(nil);
  try
    AMaxi.BackgroundColor := FBackgroundColor;
    AMaxi.Color := FLineColor;
    AMaxi.Caption := FCaption;
    if Width < 121 then
      AMaxi.Width := 121
    else
      AMaxi.Width := Round(Width);
    if Height < 129 then
      AMaxi.Height := 129
    else
      AMaxi.Height := Round(Height);
    AMaxi.Code := FText;
    AMaxi.SaveToFile(sFileName);
  finally
    AMaxi.Free;
  end;

  if FileExists(sFileName) then
  begin
    oBmp := TBitmap.Create;
    try
      oBmp.LoadFromFile(sFileName);
      frxDrawGraphic(Canvas, Rect(FX, FY, FX1, FY1), oBmp, IsPrinting, False, False, 0);
    finally
      FreeAndNil(oBmp);
      DeleteFile(sFileName);
    end;
  end;

  DrawFrame;
end;

procedure TEasyfrxMaxiBarcodeView.GetData;
begin
  inherited;

  if IsDataField then
    FText := VarToStr(DataSet.Value[DataField])
  else if FExpression <> '' then
    FText := VarToStr(Report.Calc(FExpression));
end;

initialization
  frxObjects.RegisterObject1(TEasyfrxMaxiBarcodeView, nil, '', '', 0, 23);

finalization
  frxObjects.UnRegister(TEasyfrxMaxiBarcodeView);

end.
