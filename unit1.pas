unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, ComCtrls, Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Image1: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  Filename: String;
  i, j: Integer;
  Image_var: TBitmap;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.MenuItem8Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
var clr: TColor;
  r: Byte;
begin
 For i:=0 to Form1.Image1.Picture.Width do
 Begin
   For j:=0 to Form1.Image1.Picture.Height do
   Begin
    clr:=Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
    r:=Red(clr);
    Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j]:=RGBToColor(r,0,0);
   end;
   Application.ProcessMessages;
 end;

end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
begin
FileName := OpenDialog1.Filename; //Caminho completo para o ficheiro selecionado
Form1.Image1.Picture.LoadFromFile(FileName);
end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 Form1.Image1.Picture.Clear;
end;

end.
