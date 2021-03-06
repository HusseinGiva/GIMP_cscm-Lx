Unit Unit1;

{$mode objfpc}{$H+}

Interface

Uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, ExtCtrls, ComCtrls, Unit2, Unit3, DefaultTranslator;

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
    SaveDialog1: TSaveDialog;
    Procedure Button1Click(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var CloseAction: TCloseAction);
    Procedure FormCreate(Sender: TObject);
    Procedure MenuItem10Click(Sender: TObject);
    Procedure MenuItem11Click(Sender: TObject);
    Procedure MenuItem12Click(Sender: TObject);
    Procedure MenuItem13Click(Sender: TObject);
    Procedure MenuItem14Click(Sender: TObject);
    Procedure MenuItem2Click(Sender: TObject);
    Procedure MenuItem3Click(Sender: TObject);
    Procedure MenuItem4Click(Sender: TObject);
    Procedure MenuItem6Click(Sender: TObject);
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

Resourcestring
  saveMessage = 'File saving is completed';

Implementation

{$R *.lfm}

{ TForm1 }

Procedure TForm1.MenuItem2Click(Sender: TObject);   //File-Open
Var
  Ext: String;
Begin
  If OpenDialog1.Execute Then
  Begin
    FileName := OpenDialog1.Filename; //Caminho completo para o ficheiro selecionado
    Form1.Image1.Picture.LoadFromFile(FileName);
    Ext := ExtractFileExt(FileName);
    Image := 'temp/image' + Ext;
    Form1.Image1.Picture.SaveToFile('temp/image' + Ext);
    ProgressBar1.Max := (Form1.Image1.Picture.Width * Form1.Image1.Picture.Height);
    ProgressBar1.Position := 0;
    ProgressBar1.BarShowText := True;
  End;
End;

Procedure TForm1.MenuItem3Click(Sender: TObject);   //File-Save As BMP
Var
  f: File;
  BfSize, bfOffBits, biSize, biWidth, biHeight, biCompression, biSizeImage,
  biXPelsPerMeter, biYPelsPerMeter, biClrUsed, biClrImportant, counter: Integer;
  bfReserved1, bfReserved2, biPlanes, biBitCount: Word;
  clr: TColor;
  bfType, r, g, b, biZeros: Byte;
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    If SaveDialog1.Execute Then
    Begin
      assignFile(f, SaveDialog1.FileName);
      rewrite(f, 1);
      bfType := Ord('B');
      blockwrite(f, bfType, sizeof(bfType));
      bfType := Ord('M');
      blockwrite(f, bfType, sizeof(bfType));
      BfSize := (Form1.Image1.Picture.Width * Form1.Image1.Picture.Height * 3);
      blockwrite(f, BfSize, sizeof(BfSize));
      bfReserved1 := 0;
      blockwrite(f, bfReserved1, sizeof(bfReserved1));
      bfReserved2 := 0;
      blockwrite(f, bfReserved2, sizeof(bfReserved2));
      bfOffBits := 54;
      blockwrite(f, bfOffBits, sizeof(bfOffBits));
      biSize := 40;
      blockwrite(f, biSize, sizeof(biSize));
      biWidth := Form1.Image1.Picture.Width;
      blockwrite(f, biWidth, sizeof(biWidth));
      biHeight := Form1.Image1.Picture.Height;
      blockwrite(f, biHeight, sizeof(biHeight));
      biPlanes := 1;
      blockwrite(f, biPlanes, sizeof(biPlanes));
      biBitCount := 24;
      blockwrite(f, biBitCount, sizeof(biBitCount));
      biCompression := 0;
      blockwrite(f, biCompression, sizeof(biCompression));
      biSizeImage := 0;
      blockwrite(f, biSizeImage, sizeof(biSizeImage));
      biXPelsPerMeter := 0;
      blockwrite(f, biXPelsPerMeter, sizeof(biXPelsPerMeter));
      biYPelsPerMeter := 0;
      blockwrite(f, biYPelsPerMeter, sizeof(biYPelsPerMeter));
      biClrUsed := 0;
      blockwrite(f, biClrUsed, sizeof(biClrUsed));
      biClrImportant := 0;
      blockwrite(f, biClrImportant, sizeof(biClrImportant));
      For j := Form1.Image1.Picture.Height - 1 Downto 0 Do
      Begin
        For i := 0 To Form1.Image1.Picture.Width - 1 Do
        Begin
          clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
          b := Blue(clr);
          blockwrite(f, b, sizeof(b));
          g := Green(clr);
          blockwrite(f, g, sizeof(g));
          r := Red(clr);
          blockwrite(f, r, sizeof(r));
        End;
        Application.ProcessMessages;
        If ((Form1.Image1.Picture.Width * 3) Mod 4) <> 0 Then
        Begin
          biZeros := 0;
          For counter := 1 To 4 - ((Form1.Image1.Picture.Width * 3) Mod 4) Do
          Begin
            blockwrite(f, biZeros, sizeof(biZeros));
          End;
        End;
        Application.ProcessMessages;
      End;
      closefile(f);
    End;
    ShowMessage(saveMessage);
  End;
End;

Procedure TForm1.MenuItem4Click(Sender: TObject);   //File-Close
Begin
  DeleteDirectory('temp', True);
  Application.Terminate;
End;

Procedure TForm1.MenuItem8Click(Sender: TObject);   //Help-About
Begin
  Form2.ShowModal;
End;

Procedure TForm1.MenuItem6Click(Sender: TObject);   //Brighter
Var
  position_track: Integer;
  clr: TColor;
  r, g, b: Byte;
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    ProgressBar1.Position := 0;
    Form3.TrackBar1.Position := 0;
    Form3.ShowModal(); //Mostra o form3
    position_track := Round((Form3.TrackBar1.Position) / 10);
    //obter a posição da trackbar
    If Form3.TrackBar1.Position = 0 Then
    Else
    Begin
      For i := 0 To Form1.Image1.Picture.Width Do
      Begin
        For j := 0 To Form1.Image1.Picture.Height Do
        Begin
          clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
          If (Red(clr) + (Red(clr) * position_track)) >= 255 Then
            r := 255
          Else
            r := Red(clr) + (Red(clr) * position_track);
          If (Green(clr) + (Green(clr) * position_track)) >= 255 Then
            g := 255
          Else
            g := Green(clr) + (Green(clr) * position_track);
          If (Blue(clr) + (Blue(clr) * position_track)) >= 255 Then
            b := 255
          Else
            b := Blue(clr) + (Blue(clr) * position_track);
          Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(r, g, b);
          ProgressBar1.Position := ProgressBar1.Position + 1;
        End;
        Application.ProcessMessages;
      End;
    End;
  End;
End;

Procedure TForm1.MenuItem9Click(Sender: TObject);   //Red
Var
  clr: TColor;
  r: Byte;
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    ProgressBar1.Position := 0;
    For i := 0 To Form1.Image1.Picture.Width Do
    Begin
      For j := 0 To Form1.Image1.Picture.Height Do
      Begin
        clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
        r := Red(clr);
        Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(r, 0, 0);
        ProgressBar1.Position := ProgressBar1.Position + 1;
      End;
      Application.ProcessMessages;
    End;
  End;
End;

Procedure TForm1.MenuItem10Click(Sender: TObject);  //Green
Var
  clr: TColor;
  g: Byte;
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    ProgressBar1.Position := 0;
    For i := 0 To Form1.Image1.Picture.Width Do
    Begin
      For j := 0 To Form1.Image1.Picture.Height Do
      Begin
        clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
        g := Green(clr);
        Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(0, g, 0);
        ProgressBar1.Position := ProgressBar1.Position + 1;
      End;
      Application.ProcessMessages;
    End;
  End;
End;

Procedure TForm1.MenuItem11Click(Sender: TObject);  //Blue
Var
  clr: TColor;
  b: Byte;
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    ProgressBar1.Position := 0;
    For i := 0 To Form1.Image1.Picture.Width Do
    Begin
      For j := 0 To Form1.Image1.Picture.Height Do
      Begin
        clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
        b := Blue(clr);
        Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(0, 0, b);
        ProgressBar1.Position := ProgressBar1.Position + 1;
      End;
      Application.ProcessMessages;
    End;
  End;
End;

Procedure TForm1.MenuItem12Click(Sender: TObject);  //Gray Scale
Var
  clr: TColor;
  y: Byte;
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    ProgressBar1.Position := 0;
    For i := 0 To Form1.Image1.Picture.Width Do
    Begin
      For j := 0 To Form1.Image1.Picture.Height Do
      Begin
        clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
        y := Round((Red(clr)) * 0.2126 + (Green(clr)) * 0.7152 + (Blue(clr)) * 0.0722);
        Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(y, y, y);
        ProgressBar1.Position := ProgressBar1.Position + 1;
      End;
      Application.ProcessMessages;
    End;
  End;
End;

Procedure TForm1.MenuItem13Click(Sender: TObject);  //Negative
Var
  clr: TColor;
  r, g, b: Byte;
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    ProgressBar1.Position := 0;
    For i := 0 To Form1.Image1.Picture.Width Do
    Begin
      For j := 0 To Form1.Image1.Picture.Height Do
      Begin
        clr := Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j];
        r := 255 - (Red(clr));
        g := 255 - (Green(clr));
        b := 255 - (Blue(clr));
        Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(r, g, b);
        ProgressBar1.Position := ProgressBar1.Position + 1;
      End;
      Application.ProcessMessages;
    End;
  End;
End;

Procedure TForm1.MenuItem14Click(Sender: TObject);  //Box Blur
Var
  r, g, b: Byte;
  m, n, red_a, green_a, blue_a, counter: Integer;
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    ProgressBar1.Position := 0;
    For i := 0 To Form1.Image1.Picture.Width Do
    Begin
      For j := 0 To Form1.Image1.Picture.Height Do
      Begin
        red_a := 0;
        green_a := 0;
        blue_a := 0;
        counter := 0;
        For m := -1 To 1 Do
        Begin
          For n := -1 To 1 Do
          Begin
            If (i + m >= 0) And (i + m < Form1.Image1.Picture.Width) And
              (j + n >= 0) And (j + n < Form1.Image1.Picture.Height) Then
            Begin
              red_a := red_a +
                Red(Form1.Image1.Picture.Bitmap.Canvas.Pixels[i + m, j + n]);
              green_a := green_a + Green(
                Form1.Image1.Picture.Bitmap.Canvas.Pixels[i + m, j + n]);
              blue_a := blue_a +
                Blue(Form1.Image1.Picture.Bitmap.Canvas.Pixels[i + m, j + n]);
              counter := counter + 1;
            End;
          End;
        End;
        r := Round(red_a / counter);
        g := Round(green_a / counter);
        b := Round(blue_a / counter);
        Form1.Image1.Picture.Bitmap.Canvas.Pixels[i, j] := RGBToColor(r, g, b);
        counter := 0;
        ProgressBar1.Position := ProgressBar1.Position + 1;
      End;
      Application.ProcessMessages;
    End;
  End;
End;

Procedure TForm1.Button1Click(Sender: TObject);     //Reset Button
Begin
  If Image1.Picture.Bitmap.Empty Then
  Else
  Begin
    Form1.Image1.Picture.Clear;
    Form1.Image1.Picture.LoadFromFile(Image);
    ProgressBar1.Position := 0;
  End;
End;

Procedure TForm1.FormClose(Sender: TObject; Var CloseAction: TCloseAction);  //On Close
Begin
  DeleteDirectory('temp', True);
End;

Procedure TForm1.FormCreate(Sender: TObject);       //On Create
Begin
  DeleteDirectory('temp', True);
End;

End.
