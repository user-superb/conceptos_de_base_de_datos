program project1;
const
  fin='cemento';
type
  tMaterial= String[50];
  tArchivo= Text;
var
  material: tMaterial;
  archivo: tArchivo;
  nombre_archivo: String[50];
begin
  write('Nombre del Archivo: ');
  readln(nombre_archivo);
  assign(archivo, nombre_archivo);
  rewrite(archivo);

  write('Agregar Material');
  writeln();
  readln(material);

  while (material <> fin) do
  begin
    write(archivo, material);
    writeln(archivo);

    write('Agregar Material');
    writeln();
    readln(material);
  end;

  close(archivo);
end.

