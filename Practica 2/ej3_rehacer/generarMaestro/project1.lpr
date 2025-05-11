program generarMaestro;

uses
  SysUtils;

type
  str50 = string[50];

  calzado = record
    cod: Integer;
    num: Real;
    desc: str50;
    precio: Real;
    color: str50;
    stock: Integer;
    stock_min: Integer;
  end;

  arc_maestro = file of calzado;

var
  mae: arc_maestro;
  i: Integer;
  reg: calzado;

begin
  Assign(mae, 'maestro');
  Rewrite(mae);

  for i := 1 to 5 do
  begin
    reg.cod := i;                      // Mismo rango que en los archivos detalle
    reg.num := 35 + (i mod 5);         // Números de calzado entre 35 y 39
    reg.desc := 'Zapatilla modelo ' + IntToStr(i);
    reg.precio := 1000 + i * 50;       // Precios variados
    reg.color := 'Color ' + IntToStr(i);
    reg.stock := 50 + i * 10;
    reg.stock_min := 10;

    Write(mae, reg);
  end;

  Close(mae);
  writeln('Archivo maestro generado correctamente.');
  readln();
end.

