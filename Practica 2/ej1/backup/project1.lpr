program project1;
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

  regm: empMas;
  regd: empDet;
begin
  assign(archMas, 'master');
  assign(archDet, 'detail');
  assign(archInforme, 'informe.txt');

  reset(archMas);
  reset(archDet);
  append(archInforme);

  while (not eof(archDet)) do
  begin
    read(archDet, regd);

    // Inicializar regm
    regm.cod:= -1;
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

  close(archDet);
  close(archMas);
  close(archInforme);

  write('Se cerraron los archivos.');
  readln();
end.

