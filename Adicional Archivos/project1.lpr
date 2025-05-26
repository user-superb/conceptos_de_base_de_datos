program project1;
type
  str50 = String[50];
  turno = record
    dni: Integer;
    apellido: str50;
    nombre: str50;
    especialista: str50;
    fecha: str50;
  end;

  arch_turno = File of turno;
  arch_bajas = Text;

procedure Baja(var arch: arch_turno; busqueda: turno);
var
  cabecera, aux_turno: turno;

  pos: Integer;
  seEncontro: Boolean;
begin
  seEncontro:= false;

  while (not EOF(arch) and not seEncontro) do
  begin
    read(arch, aux_turno);
    if (aux_turno.dni = busqueda.dni) and (aux_turno.apellido = busqueda.apellido) and (aux_turno.nombre = busqueda.nombre) and (aux_turno.especialista = busqueda.especialista) and (aux_turno.fecha = busqueda.fecha) then
      seEncontro:= true;
  end;

  if (seEncontro) then
  begin
    pos:= FilePos(arch) - 1;
    pos:= pos * -1;
    aux_turno.dni:= pos;
    seek(arch, 0); read(arch, cabecera); write(arch, aux_turno);
    seek(arch, pos); write(arch, cabecera);
  end
  else
    writeln('No se encontro el turno.');
end;

procedure Alta(var arch: arch_turno; nuevo: turno);
var
  cabecera, aux_turno: turno;
  pos: Integer;
begin
  reset(arch);
  read(arch, cabecera);

  if (cabecera.dni = 0) then
  begin
    seek(arch, FileSize(arch));
    write(arch, nuevo);
  end
  else
  begin
    pos:= cabecera.dni * -1;
    seek(arch, pos); read(arch, aux_turno); write(arch, nuevo);
    seek(arch, 0); write(arch, aux_turno);
  end;
end;

procedure RealizarAltas(var arch: arch_turno);
var
  nuevo: turno;
begin
  writeln('Nueva Alta');
  write('dni: ');
  readln(nuevo.dni);
  while (nuevo.dni > 0) do
  begin
    write('apellido: ');
    readln(nuevo.apellido);
    write('nombre: ');
    readln(nuevo.nombre);
    write('especialista: ');
    readln(nuevo.especialista);
    write('fecha: ');
    readln(nuevo.fecha);

    Alta(arch, nuevo);
  end;
end;

procedure RealizarBajas(var arch: arch_turno);
var
  bajas: arch_bajas;

  aux_turno: turno;
begin
  assign(bajas, 'bajas_del_dia.txt');
  reset(bajas);

  while (not EOF(bajas)) do
  begin
    readln(bajas, aux_turno.dni, aux_turno.apellido, aux_turno.nombre, aux_turno.especialista, aux_turno.fecha);
    Baja(arch, aux_turno);
  end;

  close(bajas);
end;

begin
end.

