Unit Unit1;

{$mode objfpc}{$H+}

Interface

Uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, ComCtrls, Unit2;

Type

  { TForm1 }

  TForm1 = Class(TForm)
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
    Procedure Button1Click(Sender: TObject);
    Procedure FormCreate(Sender: TObject);
    Procedure MenuItem10Click(Sender: TObject);
    Procedure MenuItem11Click(Sender: TObject);
    Procedure MenuItem12Click(Sender: TObject);
    Procedure MenuItem13Click(Sender: TObject);
    Procedure MenuItem2Click(Sender: TObject);
    Procedure MenuItem4Click(Sender: TObject);
    Procedure MenuItem8Click(Sender: TObject);
    Procedure MenuItem9Click(Sender: TObject);
  Private
    { private declarations }
  Public
    { public declarations }
  End;

Var
  Form1: TForm1;
  Filename, image, temp: String;
  i, j: Integer;

Implementation

{$R *.lfm}

{ TForm1 }

Procedure TForm1.MenuItem4Click(Sender: TObject);
Begin
  Application.Terminate;
End;

Procedure TForm1.MenuItem8Click(Sender: TObject);
Begin
  Form2.ShowModal;
End;

Procedure TForm1.MenuItem9Click(Sender: TObject);
Var
  clr: TColor;
  r: Byte;
Begin
  For i := 0 To Form1.Image1.Picture.Width Do
  Begin
    For j := 0 To Form1.Image1.Picture.Height Do
    Begin
      clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
      r := Red(clr);
      Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(r, 0, 0);
    End;
    Application.ProcessMessages;
  End;
End;

Procedure TForm1.MenuItem2Click(Sender: TObject);
Var
  Ext: String;
Begin
  If OpenDialog1.Execute Then
  Begin
    FileName := OpenDialog1.Filename; //Caminho completo para o ficheiro selecionado
    Form1.Image1.Picture.LoadFromFile(FileName);
    Ext := ExtractFileExt(FileName);
    Form1.Image1.Picture.SaveToFile('temp/image' + Ext);
  End;
End;

Procedure TForm1.Button1Click(Sender: TObject);
Begin
  Form1.Image1.Picture.Clear;
  Form1.Image1.Picture.LoadFromFile(FileName);
  ProgressBar1.Position := 0;
End;

Procedure TForm1.FormCreate(Sender: TObject);
Begin
  DeleteDirectory('temp', True);
End;

Procedure TForm1.MenuItem10Click(Sender: TObject);
Var
  clr: TColor;
  g: Byte;
Begin
  For i := 0 To Form1.Image1.Picture.Width Do
  Begin
    For j := 0 To Form1.Image1.Picture.Height Do
    Begin
      clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
      g := Green(clr);
      Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(0, g, 0);
    End;
    Application.ProcessMessages;
  End;
End;

Procedure TForm1.MenuItem11Click(Sender: TObject);
Var
  clr: TColor;
  b: Byte;
Begin
  For i := 0 To Form1.Image1.Picture.Width Do
  Begin
    For j := 0 To Form1.Image1.Picture.Height Do
    Begin
      clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
      b := Blue(clr);
      Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(0, 0, b);
    End;
    Application.ProcessMessages;
  End;
End;

Procedure TForm1.MenuItem12Click(Sender: TObject);
Var
  clr: TColor;
  y: Byte;
Begin
  For i := 0 To Form1.Image1.Picture.Width Do
  Begin
    For j := 0 To Form1.Image1.Picture.Height Do
    Begin
      clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
      y := Round((Red(clr)) * 0.2126 + (Green(clr)) * 0.7152 + (Blue(clr)) * 0.0722);
      Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(y, y, y);
      ProgressBar1.Position := ProgressBar1.Position;
    End;
    Application.ProcessMessages;
  End;
End;

Procedure TForm1.MenuItem13Click(Sender: TObject);
Var
  clr: TColor;
  r, g, b: Byte;
Begin
  For i := 0 To Form1.Image1.Picture.Width Do
  Begin
    For j := 0 To Form1.Image1.Picture.Height Do
    Begin
      clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
      r := 255 - (Red(clr));
      g := 255 - (Green(clr));
      b := 255 - (Blue(clr));
      Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(r, g, b);
    End;
    Application.ProcessMessages;
  End;
End;

End.
