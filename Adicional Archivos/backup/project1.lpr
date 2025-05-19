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
  aux_turno: turno;

  pos: Integer;
  seEncontro: Boolean;
begin
  seEncontro:= false;

  while (not EOF(arch) and not seEncontro) do
  begin
    read(arch, aux_turno);
    if (aux_turno.dni = busqueda.dni) then
      if (aux_turno.apellido = busqueda.apellido) then
        if (aux_turno.nombre = busqueda.nombre) then
          if (aux_turno.especialista = busqueda.especialista) then
            if (aux_turno.fecha = busqueda.fecha) then
              seEncontro:= true;
  end;

  if (seEncontro) then
  begin
    pos:= FilePos(arch) - 1;
    pos:= pos * -1;
    seek(arch, 0); read(arch, aux_turno);
    seek(arch, pos); write(arch, aux_turno);

    aux_turno.dni:= pos;
    seek(arch, 0); write(arch, aux_turno);
  end
  else
    writeln('No se encontro el turno.');
end;

procedure Alta(var arch: arch_turno; nuevo: turno);
var
  aux_turno: turno;
  pos: Integer;
begin
  reset(arch);
  read(arch, aux_turno);

  if (aux_turno.dni >= 0) then
  begin
    seek(arch, FileSize(arch));
    write(arch, nuevo);
  end
  else
  begin
    pos:= aux_turno.dni * -1;
    seek(arch, pos); read(arch, aux_turno);
    seek(arch, 0); write(arch, aux_turno);
    seek(arch, pos); write(arch, nuevo);
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
  aux_str: str50;

  code: Integer;
begin
  assign(bajas, 'bajas_del_dia.txt');
  reset(bajas);

  while (not EOF(text) do
  begin
    read(bajas, aux_str);
    Val(aux_str, aux_turno.dni, code);
    read(bajas, aux_turno.apellido);
    read(bajas, aux_turno.nombre);
    read(bajas, aux_turno.especialista);
    read(bajas, aux_turno.fecha);

    Baja(arch, aux_turno);
  end;

  close(bajas);
end;

begin
end.

