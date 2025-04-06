program project1;
uses
  sysutils;
type
  Texto=String[50];
  ventas= record
    cod: Integer;
    tam: Integer;
    cant_vend: Integer;
  end;
  calzados= record
    cod: Integer;
    tam: Integer;
    desc: Texto;
    precio: Real;
    color: Texto;
    stock: Integer;
    stockMin: Integer;
  end;
  tArchCalzados= File of calzados;
  tArchVentas= File of ventas;

  tArchInforme= Text;

procedure actualizarCalzados(var archCalzados: tArchCalzados; var archInforme: tArchInforme; regV: ventas);
var
  seEncontro: Boolean;
  hayData: Boolean;

  regC: calzados;
begin
  reset(archCalzados);

  hayData:= false;
  seEncontro:= false;

  if (not eof(archCalzados)) then
  begin
    read(archCalzados, regC);
    hayData:= true;
  end;

  while (hayData and not seEncontro) do
  begin
    if (regV.cod = regC.cod) then
       seEncontro:= true;

    if (not seEncontro and not eof(archCalzados)) then
       read(archCalzados, regC)
    else
      hayData:= false;
  end;

  if (seEncontro) then
  begin
    if ((regC.stock - regV.cant_vend) >= 0) then
    begin
      regC.stock:= regC.stock - regV.cant_vend;
      seek(archCalzados, FilePos(archCalzados - 1));
      write(archCalzados, regC);
    end
    else if (regV.cant_vend = 0) then
    begin
      write('Calzado ', regV.cod, 'no tuvo ventas.');
      writeln();
    end;

    if (regC.stock < regC.stockMin) then
    begin
       write(archInforme, 'Calzado ', regC.cod, ' Stock quedo debajo del minimo.');
       writeln(archInforme);
    end;
  end;
end;

procedure imprimirCalzados(var archCalzados: tArchCalzados);
var
  regC: calzados;

  hayData: Boolean;
begin
  reset(archCalzados);

  if (not eof(archCalzados)) then
  begin
    read(archCalzados, regC);
    hayData:= true;
  end;

  while (hayData) do
  begin
    writeln('cod: ', regC.cod, ' stock: ', regC.stock);

    if (not eof(archCalzados)) then
      read(archCalzados, regC)
    else
      hayData:= false;
  end;
end;

var
  archCalzados: tArchCalzados;
  archVentas: tArchVentas;

  archInforme: tArchInforme;

  hayData: Boolean;

  regV: ventas;

  i: Integer;
begin
  assign(archCalzados, 'calzados.dat');
  assign(archInforme, 'calzadosinstock.txt');
  reset(archCalzados);
  append(archInforme);

  imprimirCalzados(archCalzados);

  for i:= 1 to 3 do
  begin
    hayData:= false;

    assign(archVentas, Concat('ventas', IntToStr(i),'.dat'));
    reset(archVentas);
    writeln('Se abrio ventas', IntToStr(i), '.dat');

    if (not eof(archVentas)) then
    begin
       read(archVentas, regV);
       hayData:= true;
    end;

    while (hayData) do
    begin
      actualizarCalzados(archCalzados, archInforme, regV);
      if (not eof(archVentas)) then
        read(archVentas, regV)
      else
        hayData:= false;
    end;

    close(archVentas);
  end;

  imprimirCalzados(archCalzados);

  close(archCalzados);
  close(archInforme);
  readln();
end.

