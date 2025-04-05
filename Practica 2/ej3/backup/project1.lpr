program project1;
uses
  sysutils;
type
  Texto=String[100];
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
    read(archCalzados, regC);
    if (regV.cod = regC.cod) then
       seEncontro:= true;
  end;

  if (seEncontro) then
  begin
    if ((regC.stock - regV.cant_vend) >= 0) then
    begin
      regC.stock:= regC.stock - regV.cant_vend;
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

var
  archCalzados: tArchCalzados;
  archVentas: tArchVentas;

  archInforme: tArchInforme;

  hayData: Boolean;

  regV: ventas;

  i: Integer;
begin
  assign(archCalzados, 'calzados');
  assign(archInforme, 'calzadosinstock.txt');
  reset(archCalzados);
  append(archInforme);

  for i:= 0 to 19 do
  begin
    hayData:= false;

    assign(archVentas, Concat('ventas', IntToStr(i + 1)));
    reset(archVentas);
    writeln('Abierto: ventas', IntToStr(i));

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

  close(archCalzados);
  readln();
end.

