program generarDetalles;

uses
  SysUtils;

const
  MAX_ARCHIVOS = 20;

type
  str50 = string[50];
  venta_calzado = record
    cod: Integer;
    num: Integer;
    cant: Integer;
  end;

  arc_detalle = file of venta_calzado;

var
  archivos: array[1..MAX_ARCHIVOS] of arc_detalle;
  nombre: str50;
  i, j, cantidadRegistros: Integer;
  reg: venta_calzado;

begin
  for i := 1 to MAX_ARCHIVOS do
  begin
    Str(i, nombre);
    nombre := 'detalle' + nombre + '.dat';
    Assign(archivos[i], nombre);
    Rewrite(archivos[i]);

    // Puedes cambiar la cantidad de registros por archivo aquí
    cantidadRegistros := 5;

    // Generar registros ordenados por cod y num
    for j := 1 to cantidadRegistros do
    begin
      reg.cod := j; // cod entre 1 y cantidadRegistros
      reg.num := 35 + (j mod 5); // número de calzado entre 35 y 39
      reg.cant := 1 + Random(5); // cantidad vendida entre 1 y 5
      Write(archivos[i], reg);
    end;

    Close(archivos[i]);
  end;

  writeln('Archivos detalles generados correctamente.');
  readln();
end.

