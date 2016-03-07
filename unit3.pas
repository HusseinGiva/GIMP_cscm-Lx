Unit Unit3;

{$mode objfpc}{$H+}

Interface

Uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ComCtrls,
  StdCtrls;

Type

  { TForm3 }

  TForm3 = Class(TForm)
    Button1: TButton;
    TrackBar1: TTrackBar;
    Procedure Button1Click(Sender: TObject);
    Procedure FormClose(Sender: TObject; Var CloseAction: TCloseAction);
    Procedure FormCreate(Sender: TObject);
    Procedure FormShow(Sender: TObject);
  Private
    { private declarations }
  Public
    { public declarations }
  End;

Var
  Form3: TForm3;
  counter: Integer;

Implementation

{$R *.lfm}

{ TForm3 }

Procedure TForm3.Button1Click(Sender: TObject); //When "Ok" is pressed
Begin
  Form3.Close;
  counter := counter + 1;
End;

Procedure TForm3.FormClose(Sender: TObject; Var CloseAction: TCloseAction); //When form is closed without using the "Ok"
Begin
  If counter = 0 Then
  Begin
    TrackBar1.Position := 0;
    Form3.Close;
  End
  Else
    Form3.Close;
End;

Procedure TForm3.FormCreate(Sender: TObject);  //On form create
Begin
  TrackBar1.Position := 0;
  counter := 0;
End;

Procedure TForm3.FormShow(Sender: TObject);    //When form is called
Begin
  counter := 0;
End;

End.
