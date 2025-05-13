program project1;
const
  fin=100000;
type
  str50= String[50];
  planta= record
    cod: Integer;
    vulg: str50;
    cien: str50;
    alt: Real;
    desc: str50;
    zona: str50;
  end;

  arc_planta= File of planta;

procedure BajaLogica(var a: arc_planta; cod: Integer);
var
  aux_planta: planta;
begin
  reset(a);
  aux_planta.cod:= -1;

  // Buscar la planta
  while (not EOF(a) and (aux_planta.cod <> cod)) do
    read(a, aux_planta);

  // Se encontró la planta
  if (aux_planta.cod = cod) then
  begin
    aux_planta.cod:= -1;
    seek(a, FilePos(a) - 1);
    write(a, aux_planta);
  end
  else
    writeln('No se encuentra la planta en el archivo');
end;

procedure BajaFisica(var a: arc_Planta; cod: Integer);
var
  aux_planta: planta;
  pos: Integer;
begin
  reset(a);
  aux_planta.cod:= -1;

  while (not EOF(a) and (aux_planta.cod <> cod)) do
    read(a, aux_planta);

  if (aux_planta.cod = cod) then
  begin
    pos:= FilePos(a) - 1;
    seek(a, FileSize(a) - 1);
    read(a, aux_planta);
    seek(a, pos);
    write(a, aux_planta);
    seek(a, FileSize(a) - 1);
    truncate(a);
  end
  else
    writeln('No se encontro la planta en el archivo');
end;

procedure GenerarArchivo(var a: arc_planta; var nuevo: arc_planta);
var
  aux_planta: planta;
begin
  reset(a);
  rewrite(nuevo);

  while (not EOF(a)) do
  begin
    read(a, aux_planta);
    if (aux_planta.cod <> -1) then
      write(nuevo, aux_planta);
  end;
end;

var
  a, nuevo: arc_planta;

  lectura: Integer;
begin
  assign(a, 'plantas.dat');

  write('Codigo de la planta a elminar: ');
  readln(lectura);
  while (lectura <> fin) do
  begin
    //BajaLogica(a, lectura);
    //BajaFisica(a, cod);
  end;

  assign(nuevo, 'nuevo.dat');
  GenerarArchivo(a, nuevo);

  close(a);
  close(nuevo);
end.

