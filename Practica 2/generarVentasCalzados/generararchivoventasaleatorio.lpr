program GenerarArchivosDetalleVentas;

uses
  crt, sysutils;

type
  venta = record
    cod: Integer;
    tam: Integer;
    cant_vend: Integer;
  end;

var
  archivo: file of venta;
  v: venta;
  i, j, numArchivos, ventasPorArchivo: Integer;
  nombreArchivo: string;

begin
  Randomize;
  numArchivos := 3;         // Cambia según cuántos archivos quieras
  ventasPorArchivo := 4;    // Cuántas ventas por archivo

  for i := 1 to numArchivos do
  begin
    nombreArchivo := 'ventas' + IntToStr(i) + '.dat';
    Assign(archivo, nombreArchivo);
    Rewrite(archivo);

    for j := 1 to ventasPorArchivo do
    begin
      v.cod := 1000 + j*2;       // Puede coincidir o no con calzados
      v.tam := 35 + Random(15);
      v.cant_vend := 1 + Random(5);       // Ventas entre 1 y 5 pares
      Write(archivo, v);

      writeln('cod: ', v.cod);
      writeln('cant_vend: ', v.cant_vend);
    end;

    Close(archivo);
    writeln('Archivo detalle "', nombreArchivo, '" generado.');
  end;

  readln;
end.

