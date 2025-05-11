program generar_archivos;
uses SysUtils;

const
  N = 17;
  nombreMae = 'maestro';

type
  str50 = String[50];
  plato = record
    cod: Integer;
    nom: str50;
    cost: Real;
    fec: str50;
    cant: Integer;
  end;
  venta = record
    cod: Integer;
    cant: Integer;
  end;

  arc_mae = File of plato;
  arc_det = File of venta;

var
  mae: arc_mae;
  detalles: array[1..N] of arc_det;
  i, j, codActual: Integer;
  p: plato;
  v: venta;
  nombreArchivo: string;

{ Genera una fecha aleatoria simple en formato DD/MM/AAAA }
function generarFecha: str50;
var
  dia, mes, anio: Integer;
begin
  dia := Random(28) + 1;
  mes := Random(12) + 1;
  anio := 2024;
  generarFecha := Format('%2.2d/%2.2d/%4.4d', [dia, mes, anio]);
end;

{ Genera el archivo maestro ordenado por código }
procedure generarMaestro;
begin
  Assign(mae, nombreMae);
  Rewrite(mae);

  for codActual := 1 to 100 do
  begin
    with p do
    begin
      cod := codActual;
      nom := 'Plato ' + IntToStr(cod);
      cost := Random * 100 + 10;
      fec := generarFecha;
      cant := Random(100);
    end;
    Write(mae, p);
  end;

  Close(mae);
  Writeln('Archivo maestro generado correctamente.');
end;

{ Genera archivos detalle ordenados por código }
procedure generarDetalles;
begin
  for i := 1 to N do
  begin
    nombreArchivo := 'detalle' + IntToStr(i) + '.dat';
    Assign(detalles[i], nombreArchivo);
    Rewrite(detalles[i]);

    for j := 1 to 20 do
    begin
      with v do
      begin
        cod := (i * 5 + j) mod 100 + 1;  // asegurar valores de cod entre 1 y 100
        cant := Random(5) + 1;
      end;
      Write(detalles[i], v);
    end;

    Close(detalles[i]);
    Writeln('Archivo detalle ', i, ' generado: ', nombreArchivo);
  end;
end;

begin
  Randomize;
  generarMaestro;
  generarDetalles;
  Writeln('Todos los archivos fueron generados.');
  Readln;
end.

