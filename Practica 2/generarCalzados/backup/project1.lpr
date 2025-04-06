program GenerarMaestroCalzados;

uses
  crt, sysutils;

type
  Texto = string[50];

  calzado = record
    cod: Integer;
    tam: Integer;
    desc: Texto;
    precio: Real;
    color: Texto;
    stock: Integer;
    stockMin: Integer;
  end;

const
  descripciones: array[1..5] of Texto = (
    'Zapatilla deportiva',
    'Botín de cuero',
    'Sandalia de verano',
    'Zapato formal',
    'Bota impermeable'
  );

  colores: array[1..5] of Texto = (
    'Negro',
    'Blanco',
    'Rojo',
    'Azul',
    'Marrón'
  );

var
  archivo: file of calzado;
  c: calzado;
  i, totalRegistros: Integer;

begin
  Randomize;
  Assign(archivo, 'calzados.dat');
  Rewrite(archivo);

  totalRegistros := 10;

  for i := 1 to totalRegistros do
  begin
    c.cod := 1000 + Random(5);
    c.tam := 35 + Random(15);
    c.desc := descripciones[1 + Random(5)];
    c.precio := 500 + Random * 1500;
    c.color := colores[1 + Random(5)];
    c.stock := 10 + Random(40);       // Stock entre 10 y 50
    c.stockMin := 1 + Random(10);     // Stock mínimo entre 1 y 10

    writeln('cod: ', c.cod);
    writeln('stock: ', c.stock);

    Write(archivo, c);
  end;

  Close(archivo);
  writeln('Archivo maestro "calzados.dat" generado con éxito.');
  readln;
end.
