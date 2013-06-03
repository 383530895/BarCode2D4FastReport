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
unit untEasyfrxQRCodeRTTI;

interface

{$I frx.inc}

implementation

uses
  Windows, Classes, SysUtils, Forms, fs_iinterpreter, untEasyfrxQRCode, frxClassRTTI
{$IFDEF Delphi6}
, Variants
{$ENDIF};

type
  TEasyQRFunctions = class(TfsRTTIModule)
  public
    constructor Create(AScript: TfsScript); override;
  end;

{ TFunctions }

constructor TEasyQRFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);
  with AScript do
  begin
    AddClass(TEasyfrxQRBarcodeView, 'TfrxView');
  end;
end;

initialization
  fsRTTIModules.Add(TEasyQRFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TEasyQRFunctions);

end.
