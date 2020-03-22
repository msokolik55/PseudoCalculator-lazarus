program project1;
uses wincrt, graph;

var gd, gm: smallint;
  volba, x1, y1, sirka, vyska: integer;

procedure pozadie(x1, y1, sirka, vyska: integer);
begin
  setfillstyle(1, lightgray);
  bar(x1, y1, x1 + sirka, y1 + vyska);
end;

procedure tlacitka(x1, y1, volba: integer);
var napisy: array[1..3] of string;
  i, sirka, vyska: integer;
begin
  napisy[1] := 'Sucet';
  napisy[2] := 'Rozdiel';
  napisy[3] := 'Koniec';

  sirka := 150;
  vyska := 50;

  for i := 1 to length(napisy) do
  begin
    if(i = volba) then setcolor(black)
    else setcolor(white);
    line(x1, y1, x1 + sirka, y1);
    line(x1, y1, x1, y1 + vyska);
     
    if(i = volba) then setcolor(white)
    else setcolor(black);
    line(x1, y1 + vyska, x1 + sirka, y1 + vyska);
    line(x1 + sirka, y1, x1 + sirka, y1 + vyska);

    outtextxy(x1 + 10, y1 + vyska div 2, napisy[i]);

    y1 := y1 + vyska * 3 div 2;
  end;

  setcolor(white);
end;

procedure menu(x1, y1: integer; var volba: integer);
var ch: char;
begin
  repeat
    tlacitka(x1, y1, volba);

    ch := readkey;

    case ch of
      #072: volba := volba - 1;
      #080: volba := volba + 1;
    end;

    if(volba > 3) then volba := 1;
    if(volba < 1) then volba := 3;

  until ch = chr(13);
end;

procedure platno(x1, y1: integer);
begin
  setfillstyle(1, black);
  bar(x1, y1, x1 + 610, y1 + 480);
end;

function zadajCislo(x1, y1: integer): integer;
var ch: char;
  kod: integer;
  s: string;
begin
  repeat
    ch := readkey;

    if(ch >= '0') and (ch <= '9') then s := s + ch;
    outtextxy(x1, y1, s);
  until ch = chr(13);

  val(s, zadajCislo, kod);
end;

procedure priklad(x1, y1: integer; znamienko: string);
var vysledok, cislo1, cislo2: integer;
  s: string;
begin
  settextstyle(0, 0, 3);

  cislo1 := zadajCislo(x1, y1);

  y1 := y1 + 30;
  outtextxy(x1, y1, znamienko);
              
  y1 := y1 + 30;
  cislo2 := zadajCislo(x1, y1); 

  setlinestyle(0, 0, 3);
  y1 := y1 + 50;
  line(x1, y1, x1 + 200, y1);

  case znamienko of
    '+': vysledok := cislo1 + cislo2;
    '-': vysledok := cislo1 - cislo2;
  end; 

  y1 := y1 + 30;
  str(vysledok, s);
  outtextxy(x1, y1, s);

  settextstyle(0, 0, 1); 
  setlinestyle(0, 0, 1);
end;

begin
  gd := Detect;
  initgraph(gd, gm, '');

  volba := 1;
  x1 := 100;
  y1 := 100; 
  sirka := 800;
  vyska := 500;                

  pozadie(x1, y1, sirka, vyska);
  platno(x1 + 175, y1 + 10);

  repeat
    menu(x1 + 10, y1 + vyska div 7, volba);
    platno(x1 + 175, y1 + 10);

    case volba of
      1: priklad(x1 + 400, y1 + vyska div 5, '+');
      2: priklad(x1 + 400, y1 + vyska div 5, '-');
    end;

  until volba = 3;

  closegraph();
end.

