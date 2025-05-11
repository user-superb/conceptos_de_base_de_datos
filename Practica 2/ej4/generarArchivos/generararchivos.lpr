program generarDetalles;
uses SysUtils;

const
  cant_cines = 20;

type
  str50 = string[50];
  pelicula = record
    cod: Integer;
    nom: str50;
    gen: str50;
    dir: str50;
    dur: Integer;
    fecha: str50;
    cant: Integer;
  end;

  arc_pelicula = file of pelicula;

var
  i, j, cant_registros: Integer;
  f: arc_pelicula;
  p: pelicula;
  nombreArchivo: str50;
begin
  Randomize;
  for i := 1 to cant_cines do
  begin
    nombreArchivo := 'detalle' + IntToStr(i);
    Assign(f, nombreArchivo);
    Rewrite(f);
    // Número aleatorio de registros por archivo (3 a 5)
    cant_registros := 10 + Random(5);
    for j := 1 to cant_registros do
    begin
      p.cod := 100 + j;  // cod ordenado: 101, 102, etc., 201, 202, etc.
      p.nom := 'Pelicula_' + IntToStr(p.cod);
      p.gen := 'Genero_' + IntToStr(Random(5) + 1);
      p.dir := 'Director_' + IntToStr(Random(10) + 1);
      p.dur := 80 + Random(60); // Duración entre 80 y 140 mins
      p.fecha := '2025-0' + IntToStr(Random(9) + 1) + '-0' + IntToStr(Random(9) + 1);
      p.cant := Random(100) + 1; // Entradas entre 1 y 100
      Write(f, p);
    end;
    Close(f);
    WriteLn('Archivo ', nombreArchivo, ' generado con éxito.');
  end;
end.

