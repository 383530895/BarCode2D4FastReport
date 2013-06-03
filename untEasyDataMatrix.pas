{------------------------------------------------------------------------------
//                       HhfComponents For Delphi 7                          
//                         һ�����е�����������                         
//                         @Copyright 2009 hehf                      
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
unit untEasyDataMatrix;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, StdCtrls, Math,
  untEasyECC200, untEasyReedSolomon;

type
  TEasyDataMatrixBarCode = class(TGraphicControl)
  private
    FBitMap: TBitmap;
    FText  : string;
    FGridSize: Integer;
    procedure SetGridSize(const Value: Integer);
    procedure SetText(const Value: string);
  public
    constructor Create (AOwner : TComponent); override;
    destructor Destroy; override;
    procedure DrawDataMatrixCode(ACanvas: TCanvas; ARect: TRect);
  protected
    procedure Paint; override;
    procedure GenerateDataMatrixCode(AStr: string; ASize: Integer; ABmp: TBitmap);
  published
    property Text: string read FText write SetText;
    property GridSize: Integer read FGridSize write SetGridSize default 2;
  end;

implementation

{ TEasyDataMatrixBarCode }

constructor TEasyDataMatrixBarCode.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBitMap := TBitmap.Create;
  FText := '1234567890abcABC';
  GridSize := 2;
end;

destructor TEasyDataMatrixBarCode.Destroy;
begin
  FBitMap.Free;
  inherited Destroy;
end;

procedure TEasyDataMatrixBarCode.DrawDataMatrixCode(ACanvas: TCanvas; ARect: TRect);
begin
  GenerateDataMatrixCode(FText, FGridSize, FBitMap);
  ACanvas.CopyRect(ARect, FBitMap.Canvas, Rect(0, 0, FBitMap.Width, FBitMap.Height));
end;

procedure TEasyDataMatrixBarCode.GenerateDataMatrixCode(AStr: string; ASize: Integer;
  ABmp: TBitmap);
var
  s : TByteArray;
  m : TByteArray;
  i, j: Integer;
  w, h : integer;
  cc: Integer;
begin
  if not Assigned(ABmp) then Exit;
  SetLength(s, Length(AStr));
  for i := 1 to Length(AStr) do
  begin
    s[i-1] := Ord(AStr[i]);
  end;
   CalcECC200(s, ecc200_Autosize, ecc200_Square, m, w, h); 
  ABmp.Width := w * ASize;
  ABmp.Height := h * ASize;
  for i := 0 to h - 1 do
  begin
    for j := 0 to w - 1 do
    begin
      cc := m[i * w + j];
      if cc = 1 then
      begin
        ABmp.Canvas.Brush.Color := clBlack;
        ABmp.Canvas.Rectangle(Rect(
                                  j*ASize,
                                  i*ASize,
                                  j*ASize+ASize,
                                  i*ASize+ASize));
      end;
    end;
  end;
end;

procedure TEasyDataMatrixBarCode.Paint;
begin
  inherited;
  GenerateDataMatrixCode(FText, FGridSize, FBitMap);
end;

procedure TEasyDataMatrixBarCode.SetGridSize(const Value: Integer);
begin
  if FGridSize <> Value then
  begin
    FGridSize := Value;
    Invalidate;
  end;
end;

procedure TEasyDataMatrixBarCode.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Invalidate;
  end;
end;

end.
