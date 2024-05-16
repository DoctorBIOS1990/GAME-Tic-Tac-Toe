unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.Buttons, MMSystem, dxGDIPlusClasses;

type
  TFormGame = class(TForm)
    Grid: TStringGrid;
    Bakckground: TImage;
    Difficulty: TRadioGroup;
    btnRestart: TBitBtn;
    PointsBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    ContPlayerLabel: TLabel;
    ContCPULabel: TLabel;
    procedure GridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure btnRestartClick(Sender: TObject);

    // MIS PROCEDIMIENTOS
    procedure restart;
    procedure aleatory;
    procedure playingCPU;
    procedure checkWinner;
    procedure showWinner;
    procedure bestMove;
    procedure checkTables;
    procedure OffensiveCPU;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormGame: TFormGame;
  Fila, Columna: Integer;
  Player: String;
  brainCPU, Winner: Boolean;

implementation

uses Unit2;

{$R *.dfm}
{$R MEDIAS.RES}

procedure TFormGame.aleatory; //aleatory
Begin
  Columna := Random(3);
  Fila := Random(3);
End;

procedure TFormGame.restart; // restart
Var
  I : Integer;
Begin
  Winner := False;
  for I := 0 to 2 do
    Begin
      Grid.Cells[0,I] := '';
      Grid.Cells[1,I] := '';
      Grid.Cells[2,I] := '';
    End;

End;

procedure TFormGame.playingCPU; // TURNO DEL PC
Var
  I :Integer;
Begin
  aleatory;
  bestMove;
  
 if (Winner = false) then
    Begin
     if (brainCPU = False) then
      Begin      
        if (Grid.Cells[Columna, Fila].IsEmpty) then
          Begin
            Grid.Cells[Columna, Fila] := 'O';
            Player := 'O';
            checkWinner;
            checkTables;
          End
      else
        Begin
          aleatory;
          playingCPU;
        end;
      End;
    End;

//   checkWinner;
 //  checkTables;
END;

procedure TFormGame.FormCreate(Sender: TObject);
begin
  Randomize;
end;

procedure TFormGame.checkWinner;  //CHEQUEAR GANADOR
Begin

// Filas
  if ( (Grid.Cells[0, 0] = Player) and 
       (Grid.Cells[1, 0] = Player) and
       (Grid.Cells[2, 0] = Player) )
  then 
    Begin
      Winner := True;
      showWinner
    End;

  if ( (Grid.Cells[0, 1] = Player) and 
       (Grid.Cells[1, 1] = Player) and
       (Grid.Cells[2, 1] = Player) )       
  then 
    Begin
      Winner := True;
      showWinner
    End;

  if ( (Grid.Cells[0, 2] = Player) and 
       (Grid.Cells[1, 2] = Player) and
       (Grid.Cells[2, 2] = Player) )       
  then 
    Begin
      Winner := True;
      showWinner
    End;
    
// COLUMNAS
  if ( (Grid.Cells[0, 0] = Player) and 
       (Grid.Cells[0, 1] = Player) and
       (Grid.Cells[0, 2] = Player) )       
  then 
    Begin
      Winner := True;
      showWinner
    End;

  if ( (Grid.Cells[1, 0] = Player) and 
       (Grid.Cells[1, 1] = Player) and
       (Grid.Cells[1, 2] = Player) )       
  then 
    Begin
      Winner := True;
      showWinner;
    End;

   if ((Grid.Cells[2, 0] = Player) and
       (Grid.Cells[2, 1] = Player) and
       (Grid.Cells[2, 2] = Player) )
  then
    Begin
      Winner := True;
      showWinner;
    End;

// DIAGONALES

  //IQUIERDA
  if ( (Grid.Cells[0, 0] = Player) and 
       (Grid.Cells[1, 1] = Player) and
       (Grid.Cells[2, 2] = Player) )       
  then 
    Begin
      Winner := True;
      showWinner;
    End;
    
  //DERECHA
  if ( (Grid.Cells[2, 0] = Player) and
       (Grid.Cells[1, 1] = Player) and
       (Grid.Cells[0, 2] = Player) )
  then 
    Begin
      Winner := True;
      showWinner;
    End;
                     
End;

procedure TFormGame.showWinner;  // Mostrar Ganador
Begin

  if (Winner = True) then
  Begin
      if (Player = 'X') then
       Begin
         ContPlayerLabel.Caption := IntToStr(StrToInt(ContPlayerLabel.Caption)+1);
         MessageModal.Label1.Caption := 'You Win !!!';
         MessageModal.Image.ItemIndex := 1;
         PlaySound(Pchar('SUCCESS'),hinstance,SND_RESOURCE or SND_ASYNC);
         MessageModal.ShowModal;
       End;

      if (Player = 'O') then
       Begin
         ContCPULabel.Caption := IntToStr(StrToInt(ContCPULabel.Caption)+1);
         MessageModal.Label1.Caption := 'Your Lost !!!';
         MessageModal.Image.ItemIndex := 2;
         PlaySound(Pchar('LOSSER'),hinstance,SND_RESOURCE or SND_ASYNC);
         MessageModal.ShowModal;
       End;

      restart;
  End;

End;

procedure TFormGame.GridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean); 
Var
  scanRow, I: Integer;
begin

 // Human Player
  scanRow := 0 ;

    if (Grid.Cells[ACol, ARow].IsEmpty) then
      Begin
        PlaySound(Pchar('CLIC'),hinstance,SND_RESOURCE or SND_ASYNC);
        Grid.Cells[ACol, ARow]:= 'X';
        Player  := 'X';
        checkWinner;
        //checkTables;

      for I := 0 to 2 do
          Begin
            if (Grid.Cells[0,I].IsEmpty) then
               scanRow := scanRow + 1;

            if (Grid.Cells[1,I].IsEmpty) then
               scanRow := scanRow + 1;

            if (Grid.Cells[2,I].IsEmpty) then
               scanRow := scanRow + 1;
          End;

      if  ((scanRow >= 1) and (Winner = False)) then
          Begin
            playingCPU;
            checkWinner;
          End
      else
         Begin
           PlaySound(Pchar('TABLES'),hinstance,SND_RESOURCE or SND_ASYNC);
           MessageModal.Label1.Caption := 'TABLES!';
           MessageModal.Image.ItemIndex := 3;
           MessageModal.ShowModal;
           restart;
         End;
      End;
END;

procedure TFormGame.bestMove; // BEST MOVE CPU
Begin
  brainCPU := False;
  Player := 'O';
  OffensiveCPU;

//1 FILA
if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[0, 0].isEmpty) and
       (Grid.Cells[1, 0] = 'O') and
       (Grid.Cells[2, 0] = 'O') )              
  then 
    Begin
      Grid.Cells[0, 0] := 'O';
      brainCPU  := True;
    End;
  End;
  
if (brainCPU = False) then
Begin
  if ( (Grid.Cells[0, 0] = 'O') and 
       (Grid.Cells[1, 0].isEmpty) and
       (Grid.Cells[2, 0]= 'O') )              
  then 
    Begin
      Grid.Cells[1, 0] := 'O';
      brainCPU  := True;
    End;
  
End;

if (brainCPU = False) then
Begin
  if ( (Grid.Cells[0, 0] = 'O') and 
       (Grid.Cells[1, 0] = 'O') and
       (Grid.Cells[2, 0].isEmpty) )
  then 
    Begin
      Grid.Cells[2, 0] := 'O';
      brainCPU  := True;
    End;
End;

//2 FILA
if (brainCPU = False) then
Begin
  if ( (Grid.Cells[0, 1].isEmpty) and 
       (Grid.Cells[1, 1] = 'O') and
       (Grid.Cells[2, 1] = 'O') )              
  then Begin
    Grid.Cells[0, 1] := 'O';
    brainCPU  := True;
  End;

if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[0, 1] = 'O') and 
       (Grid.Cells[1, 1].isEmpty) and
       (Grid.Cells[2, 1]= 'O') )              
  then 
    Begin
      Grid.Cells[1, 1] := 'O';
      brainCPU  := True;
    End;

if (brainCPU = False) then
    Begin
      if ( (Grid.Cells[0, 1] = 'O') and 
           (Grid.Cells[1, 1] = 'O') and
           (Grid.Cells[2, 1].isEmpty) )              
      then 
      begin
          Grid.Cells[2, 1] := 'O';
          brainCPU  := True;
      end;
    End;
 End;
End;

//3 FILA
if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[0, 2].isEmpty) and 
       (Grid.Cells[1, 2] = 'O') and
       (Grid.Cells[2, 2] = 'O') )              
  then 
    Begin
      Grid.Cells[0, 2] := 'O';
      brainCPU  := True;
    End;
  End;

if (brainCPU = False) then
  Begin  
  if ( (Grid.Cells[0, 2] = 'O') and 
       (Grid.Cells[1, 2].isEmpty) and
       (Grid.Cells[2, 2]= 'O') )              
  then 
    Begin
      Grid.Cells[1, 2] := 'O';
      brainCPU  := True;
    End;
  End;

if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[0, 2] = 'O') and 
       (Grid.Cells[1, 2] = 'O') and
       (Grid.Cells[2, 2].isEmpty) )              
  then 
    Begin
      Grid.Cells[2, 2] := 'O';
      brainCPU  := True;   
    End;
  End;

//COLUMNA 1
if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[0, 0].isEmpty) and
       (Grid.Cells[0, 1] = 'O') and
       (Grid.Cells[0, 2] = 'O') )
  then
    Begin
      Grid.Cells[0, 0] := 'O';
      brainCPU  := True;  
    End;
  End;

if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[0, 0] = 'O') and
       (Grid.Cells[0, 1].isEmpty) and
       (Grid.Cells[0, 2] = 'O') )
  then
    Begin
      Grid.Cells[0, 1] := 'O';
      brainCPU  := True;  
    End;
  End;

if (brainCPU = False) then
  Begin
   if ( (Grid.Cells[0, 0] = 'O') and
       (Grid.Cells[0, 1] = 'O') and
       (Grid.Cells[0, 2].isEmpty) )
  then
    Begin
      Grid.Cells[0, 2] := 'O';
      brainCPU  := True;
    End;
  End;

//COLUMNA 2
if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[1, 0].isEmpty) and
       (Grid.Cells[1, 1] = 'O') and
       (Grid.Cells[1, 2] = 'O') )
  then
    Begin
      Grid.Cells[1, 0] := 'O';
      brainCPU  := True;
    End;
  End;

if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[1, 0] = 'O') and
       (Grid.Cells[1, 1].isEmpty) and
       (Grid.Cells[1, 2] = 'O') )
  then
    Begin
      Grid.Cells[1, 1] := 'O';
      brainCPU  := True;
    End;
  End;

if (brainCPU = False) then
  Begin
   if ( (Grid.Cells[1, 0] = 'O') and
       (Grid.Cells[1, 1] = 'O') and
       (Grid.Cells[1, 2].isEmpty) )
  then
    Begin
      Grid.Cells[1, 2] := 'O';
      brainCPU  := True;
    End;
  End;

//COLUMNA 3
if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[2, 0].isEmpty) and
       (Grid.Cells[2, 1] = 'O') and
       (Grid.Cells[2, 2] = 'O') )
  then
    Begin
      Grid.Cells[2, 0] := 'O';
      brainCPU  := True;
    End;
  End;

if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[2, 0] = 'O') and
       (Grid.Cells[2, 1].isEmpty) and
       (Grid.Cells[2, 2] = 'O') )
  then
    Begin
      Grid.Cells[2, 1] := 'O';
      brainCPU  := True;
    End;
  End;

if (brainCPU = False) then
  Begin
   if ( (Grid.Cells[2, 0] = 'O') and
       (Grid.Cells[2, 1] = 'O') and
       (Grid.Cells[2, 2].isEmpty) )
  then
    Begin
      Grid.Cells[2, 2] := 'O';
      brainCPU  := True;
    End;
  End;

// Diagonal  Izquierda
if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[0, 0].IsEmpty) and 
       (Grid.Cells[1, 1] = 'O') and
       (Grid.Cells[2, 2] = 'O') )       
  then 
    Begin
      Grid.Cells[0, 0] := 'O';
      brainCPU  := True;   
    End;
  End;

if (brainCPU = False) then
  Begin  
  if ( (Grid.Cells[0, 0] = 'O') and 
       (Grid.Cells[1, 1].IsEmpty) and
       (Grid.Cells[2, 2] = 'O') )       
  then 
    Begin
      Grid.Cells[1, 1] := 'O';
      brainCPU  := True;   
    End;
  End;

if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[0, 0] = 'O') and 
       (Grid.Cells[1, 1] = 'O') and
       (Grid.Cells[2, 2].IsEmpty) )       
  then 
    Begin
        Grid.Cells[2, 2] := 'O'; 
        brainCPU  := True;  
    End;
  End;

// Diagonal  Derecha
if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[2, 0].IsEmpty) and
       (Grid.Cells[1, 1] = 'O') and
       (Grid.Cells[0, 2] = 'O') )
  then 
    Begin
      Grid.Cells[2, 0] := 'O';
      brainCPU  := True; 
    End;
  End;

if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[2, 0]= 'O') and 
       (Grid.Cells[1, 1].IsEmpty) and
       (Grid.Cells[0, 2] = 'O') )
  then 
    Begin
        Grid.Cells[1, 1] := 'O';
        brainCPU  := True;
    End;
  End;

if (brainCPU = False) then
  Begin
  if ( (Grid.Cells[2, 0]= 'O') and 
       (Grid.Cells[1, 1] = 'O') and
       (Grid.Cells[0, 0].IsEmpty) )       
  then 
    Begin
      Grid.Cells[0, 0] := 'O';
      brainCPU  := True;
    End;
  End;

  checkWinner;
  checkTables;

End;

procedure TFormGame.btnRestartClick(Sender: TObject);
begin
  Restart;
end;

procedure TFormGame.checkTables;
 Var
  Aux, I: Integer;
Begin
  Aux := 0 ;

   for I := 0 to 2 do
      Begin
        if (Grid.Cells[0,I].IsEmpty) then
           Aux := Aux + 1;

        if (Grid.Cells[1,I].IsEmpty) then
           Aux := Aux + 1;

        if (Grid.Cells[2,I].IsEmpty) then
           Aux := Aux + 1;
      End;

     if  ((Aux = 0) and (Winner = False))  then
      Begin
         PlaySound(Pchar('TABLES'),hinstance,SND_RESOURCE or SND_ASYNC);
         MessageModal.Label1.Caption := 'TABLES!';
         MessageModal.Image.ItemIndex := 3;
         MessageModal.ShowModal;
         restart;
      End;
End;

procedure TFormGame.OffensiveCPU; // Ofensiva CPU
Begin

if (Difficulty.ItemIndex = 1) then
Begin

    //1 FILA
    if (brainCPU = False) then
      Begin
      if ( (Grid.Cells[0, 0].isEmpty) and
           (Grid.Cells[1, 0] = 'X') and
           (Grid.Cells[2, 0] = 'X') )
      then
        Begin
          Grid.Cells[0, 0] := 'O';
          brainCPU  := True;
        End;
      End;

      if (brainCPU = False) then
      Begin
        if ( (Grid.Cells[0, 0] = 'X') and
             (Grid.Cells[1, 0].isEmpty) and
             (Grid.Cells[2, 0]= 'X') )
        then
          Begin
            Grid.Cells[1, 0] := 'O';
            brainCPU  := True;
          End;

      End;

      if (brainCPU = False) then
      Begin
        if ( (Grid.Cells[0, 0] = 'X') and
             (Grid.Cells[1, 0] = 'X') and
             (Grid.Cells[2, 0].isEmpty) )
        then
          Begin
            Grid.Cells[2, 0] := 'O';
            brainCPU  := True;
          End;
      End;

      //2 FILA
      if (brainCPU = False) then
      Begin
        if ( (Grid.Cells[0, 1].isEmpty) and
             (Grid.Cells[1, 1] = 'X') and
             (Grid.Cells[2, 1] = 'X') )
        then Begin
          Grid.Cells[0, 1] := 'O';
          brainCPU  := True;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 1] = 'X') and
             (Grid.Cells[1, 1].isEmpty) and
             (Grid.Cells[2, 1]= 'X') )
        then
          Begin
            Grid.Cells[1, 1] := 'O';
            brainCPU  := True;
          End;

      if (brainCPU = False) then
          Begin
            if ( (Grid.Cells[0, 1] = 'X') and
                 (Grid.Cells[1, 1] = 'X') and
                 (Grid.Cells[2, 1].isEmpty) )
            then
            begin
                Grid.Cells[2, 1] := 'O';
                brainCPU  := True;
            end;
          End;
       End;
      End;

      //3 FILA
      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 2].isEmpty) and
             (Grid.Cells[1, 2] = 'X') and
             (Grid.Cells[2, 2] = 'X') )
        then
          Begin
            Grid.Cells[0, 2] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 2] = 'X') and
             (Grid.Cells[1, 2].isEmpty) and
             (Grid.Cells[2, 2]= 'X') )
        then
          Begin
            Grid.Cells[1, 2] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 2] = 'X') and
             (Grid.Cells[1, 2] = 'X') and
             (Grid.Cells[2, 2].isEmpty) )
        then
          Begin
            Grid.Cells[2, 2] := 'O';
            brainCPU  := True;
          End;
        End;

      //COLUMNA 1
      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 0].isEmpty) and
             (Grid.Cells[0, 1] = 'X') and
             (Grid.Cells[0, 2] = 'X') )
        then
          Begin
            Grid.Cells[0, 0] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 0] = 'X') and
             (Grid.Cells[0, 1].isEmpty) and
             (Grid.Cells[0, 2] = 'X') )
        then
          Begin
            Grid.Cells[0, 1] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
         if ( (Grid.Cells[0, 0] = 'X') and
             (Grid.Cells[0, 1] = 'X') and
             (Grid.Cells[0, 2].isEmpty) )
        then
          Begin
            Grid.Cells[0, 2] := 'O';
            brainCPU  := True;
          End;
        End;

      //COLUMNA 2
      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[1, 0].isEmpty) and
             (Grid.Cells[1, 1] = 'X') and
             (Grid.Cells[1, 2] = 'X') )
        then
          Begin
            Grid.Cells[1, 0] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[1, 0] = 'X') and
             (Grid.Cells[1, 1].isEmpty) and
             (Grid.Cells[1, 2] = 'X') )
        then
          Begin
            Grid.Cells[1, 1] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
         if ( (Grid.Cells[1, 0] = 'X') and
             (Grid.Cells[1, 1] = 'X') and
             (Grid.Cells[1, 2].isEmpty) )
        then
          Begin
            Grid.Cells[1, 2] := 'O';
            brainCPU  := True;
          End;
        End;

      //COLUMNA 3
      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[2, 0].isEmpty) and
             (Grid.Cells[2, 1] = 'O') and
             (Grid.Cells[2, 2] = 'O') )
        then
          Begin
            Grid.Cells[2, 0] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[2, 0] = 'X') and
             (Grid.Cells[2, 1].isEmpty) and
             (Grid.Cells[2, 2] = 'X') )
        then
          Begin
            Grid.Cells[2, 1] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
         if ( (Grid.Cells[2, 0] = 'X') and
             (Grid.Cells[2, 1] = 'X') and
             (Grid.Cells[2, 2].isEmpty) )
        then
          Begin
            Grid.Cells[2, 2] := 'O';
            brainCPU  := True;
          End;
        End;


      // Diagonal  Izquierda
      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 0].IsEmpty) and
             (Grid.Cells[1, 1] = 'X') and
             (Grid.Cells[2, 2] = 'X') )
        then
          Begin
            Grid.Cells[0, 0] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 0] = 'X') and
             (Grid.Cells[1, 1].IsEmpty) and
             (Grid.Cells[2, 2] = 'X') )
        then
          Begin
            Grid.Cells[1, 1] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[0, 0] = 'X') and
             (Grid.Cells[1, 1] = 'X') and
             (Grid.Cells[2, 2].IsEmpty) )
        then
          Begin
              Grid.Cells[2, 2] := 'O';
              brainCPU  := True;
          End;
        End;

      // Diagonal  Derecha
      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[2, 0].IsEmpty) and
             (Grid.Cells[1, 1] = 'X') and
             (Grid.Cells[0, 2] = 'X') )
        then
          Begin
            Grid.Cells[2, 0] := 'O';
            brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[2, 0]= 'X') and
             (Grid.Cells[1, 1].IsEmpty) and
             (Grid.Cells[0, 2] = 'X') )
        then
          Begin
              Grid.Cells[1, 1] := 'O';
              brainCPU  := True;
          End;
        End;

      if (brainCPU = False) then
        Begin
        if ( (Grid.Cells[2, 0]= 'X') and
             (Grid.Cells[1, 1] = 'X') and
             (Grid.Cells[0, 0].IsEmpty) )
        then
          Begin
            Grid.Cells[0, 0] := 'O';
            brainCPU  := True;
          End;
        End;
        checkWinner;
        checkTables;
End;



End;  // End for Offensive Move CPU


END. // END FOR PROYECT
