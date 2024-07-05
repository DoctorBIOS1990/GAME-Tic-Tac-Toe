unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, cxClasses,
  cxGraphics, Vcl.ExtCtrls, dxGDIPlusClasses, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinBasic, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkroom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinOffice2016Colorful, dxSkinOffice2016Dark,
  dxSkinOffice2019Black, dxSkinOffice2019Colorful, dxSkinOffice2019DarkGray,
  dxSkinOffice2019White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringtime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinTheBezier,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVisualStudio2013Blue,
  dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxImageSlider, cxContainer, cxEdit,
  cxImage;

type
  TMessageModal = class(TForm)
    BitBtn1: TBitBtn;
    Label1: TLabel;
    ImageCollection: TcxImageCollection;
    cxImageCollection1Item1: TcxImageCollectionItem;
    cxImageCollection1Item2: TcxImageCollectionItem;
    cxImageCollection1Item3: TcxImageCollectionItem;
    Image: TdxImageSlider;
    ImageCollectionItem1: TcxImageCollectionItem;
    Label2: TLabel;
    Image1: TImage;
    cxImage1: TcxImage;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MessageModal: TMessageModal;

implementation

{$R *.dfm}

procedure TMessageModal.BitBtn1Click(Sender: TObject);
begin
  MessageModal.Close;
end;

procedure TMessageModal.FormClose(Sender: TObject; var Action: TCloseAction);
Var
  I:  Integer;
begin
      AlphaBlend := True;
      UpdateWindow(Handle);
      for I := 50 downto 10 do
        Begin
           AlphaBlendValue :=  5 * I;
           Sleep(20);
        End;

      Image.ItemIndex := 0;
end;

procedure TMessageModal.FormShow(Sender: TObject);
Var
  I:  Integer;
begin
      AlphaBlend := True;
      UpdateWindow(Handle);
      AlphaBlendValue :=  255 ;
End;

end.
