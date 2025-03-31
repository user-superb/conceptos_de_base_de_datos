program project1;
type
  tArchivo= File of Integer;
var
  nombreArchivo: String[50];
  arch: tArchivo;
  lecturaArchivo: Integer;
begin
  writeln('Nombre del archivo: ');
  readln(nombreArchivo);
  assign(arch, nombreArchivo);

  reset(arch);
  while (not eof(arch)) do
  begin
    write('votos: ');
    read(arch, lecturaArchivo);
    write(lecturaArchivo);
    writeln();
  end;
  writeln('Se abrió el archivo');
  readln();

  close(arch);
end.

