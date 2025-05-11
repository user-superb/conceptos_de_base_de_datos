program project1;
uses
  sysutils;
type
  tFecha=String[10]; // /DD/MM/AAAA
  tNombre=String[50]; // Nombre y Apellido
  tTexto=String[100];

  empDet = record
    cod: Integer;
    fecha: tFecha;
    diasLic: Integer;
  end;

  empMas = record
    cod: Integer;
    nom: tNombre;
    nacim: tFecha;
    dir: tTexto;
    cantHijos: Integer;
    tel: Integer;
    diasLic: Integer;
  end;

var
  maestro: file of empMas;
  detalle: array[1..10] of file of empDet;
procedure crearMaestro;
var
  e: empMas;
begin
  assign(maestro, 'maestro.dat');
  rewrite(maestro);

  // Agregar algunos empleados ficticios
  e.cod := 1; e.nom := 'Juan Perez'; e.nacim:= '1';
  e.dir := 'Calle Falsa 123'; e.cantHijos := 2; e.tel := 12345678; e.diasLic := 1000;
  write(maestro, e);

  e.cod := 2; e.nom := 'Maria Gomez'; e.nacim:= '5';
  e.dir := 'Av Siempreviva 742'; e.cantHijos := 1; e.tel := 87654321; e.diasLic := 500;
  write(maestro, e);

  close(maestro);
end;
procedure crearDetalles;
var
  i: Integer;
  d: empDet;
begin
  for i := 1 to 10 do
  begin
    assign(detalle[i], 'detalle' + IntToStr(i) + '.dat');
    rewrite(detalle[i]);

    // Crear datos ficticios de licencias
    d.cod := i mod 2 + 1;  // alternar entre código 1 y 2
    writeln(d.cod);
    d.fecha := '1';
    d.diasLic := i;

    write(detalle[i], d);

    close(detalle[i]);
  end;
end;
begin
  crearMaestro;
  crearDetalles;
  writeln('Archivo maestro y archivos detalle creados exitosamente.');
  readln();
end.

