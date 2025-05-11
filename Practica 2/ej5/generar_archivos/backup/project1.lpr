program generar_archivo;
type
  str50 = String[50];
  informacion = record
    par: str50;
    loc: str50;
    bar: str50;
    ni: Integer;
    ad: Integer;
  end;

  arc_info = File of informacion;

var
  arc: arc_info;
  info: informacion;
  nombreArchivo: str50;
  i: Integer;
begin
  write('Ingrese el nombre del archivo a crear: ');
  readln(nombreArchivo);

  assign(arc, nombreArchivo);
  rewrite(arc);

  writeln('Se ingresarán algunos registros de prueba...');
  writeln;

  // Ejemplo de datos de prueba agrupados por partido y localidad
  // Partido 1: "La Plata", Localidad: "Tol

