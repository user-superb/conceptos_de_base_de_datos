program project1;
uses
  sysutils;
type
  tFecha=String[10]; // /DD/MM/AAAA
  tNombre=String[50]; // Nombre y Apellido
  tTexto=String[100];
  empDet= record
    cod: Integer;
    fecha: tFecha;
    diasLic: Integer;
  end;
  empMas= record
    cod: Integer;
    nom: tNombre;
    nacim: tFecha;
    dir: tTexto;
    cantHijos: Integer;
    tel: Integer;
    diasLic: Integer;
  end;
  tArchMas= File of empMas;
  tArchDet= File of empDet;
  tArchInforme= Text;

var
  archMas: tArchMas;
  archDet: tArchDet;
  archInforme: tArchInforme;

  i: Integer;

  regm: empMas;
  regd: empDet;
begin
  assign(archMas, 'maestro.dat');
  assign(archInforme, 'informe.txt');

  reset(archMas);
  while (not Eof(archMas)) do
  begin
    read(archMas, regm);
    writeln('cod: ', regm.cod, ' diasLic: ', regm.diasLic);
  end;
  reset(archMas);

  append(archInforme);
  for i:= 1 to 10 do
  begin
    assign(archDet, concat('detalle', IntToStr(i), '.dat'));
    writeln(concat('detalle', IntToStr(i), '.dat'));
    reset(archDet);
    while (not eof(archDet)) do
      begin
        read(archDet, regd);

        // Inicializar regm
        regm.cod:= -1;

        reset(archMas);
        while (not eof(archMas) and (regd.cod <> regm.cod)) do
        begin
          read(archMas, regm);
        end;
        if (regd.cod = regm.cod) then
        begin
          if (regd.diasLic > regm.diasLic) then
          begin
            writeln(archInforme, regm.cod, ' ', regm.nom, ' ', regm.diasLic, ' ', regd.diasLic);
          end
          else if (regd.diasLic <= regm.diasLic) then
          begin
            regm.diasLic:= regm.diasLic - regd.diasLic;
            seek(archMas, FilePos(archMas) - 1);
            write(archMas, regm);
          end;
        end;
      end;
  end;

  reset(archMas);
  while (not Eof(archMas)) do
  begin
    read(archMas, regm);
    writeln('cod: ', regm.cod, ' diasLic: ', regm.diasLic);
  end;

  close(archDet);
  close(archMas);
  close(archInforme);

  writeln('Se cerraron los archivos.');
  readln();
end.

