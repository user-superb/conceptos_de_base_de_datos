program project1;
const
  valoralto=9999;
  cant_cines=2;
type
  str50= String[50];
  pelicula= record
    cod: Integer;
    nom: str50;
    gen: str50;
    dir: str50;
    dur: Integer;
    fecha: str50;
    cant: Integer;
  end;

  arc_pelicula= File of pelicula;

  arr_detalle= Array [1..cant_cines] of arc_pelicula;
  arr_pelicula= Array [1..cant_cines] of pelicula;

procedure leer(var det: arc_pelicula; var reg: pelicula);
begin
  if (not EOF(det)) then
    read(det, reg)
  else
    reg.cod:= valoralto;
end;

procedure minimo(var adet: arr_detalle; var areg: arr_pelicula; var min: pelicula);
var
  i, posMin: Integer;
begin
  posMin:= 1;
  min:= areg[1];

  for i:= 2 to cant_cines do
  begin
    if (areg[i].cod < min.cod) then
    begin
      min:= areg[i];
      posMin:= i;
    end;
  end;

  leer(adet[posMin], areg[posMin]);
end;

procedure actualizarMaestro(var mae: arc_pelicula; prod: pelicula);
var
  actual: pelicula;
begin
  leer(mae, actual);
  while ((actual.cod <> valoralto) and (actual.cod <> prod.cod)) do
  begin
    leer(mae, actual);
  end;

  if (actual.cod = prod.cod) then
  begin
    actual.cant:= actual.cant + prod.cant;

    seek(mae, FilePos(mae) - 1);
    write(mae, actual);
  end
  else
  begin
    write(mae, prod);
    seek(mae, FilePos(mae) - 1);
  end;
end;

procedure informarMaestro(var mae: arc_pelicula);
var
  actual: pelicula;
begin
  reset(mae);

  while (not EOF(mae)) do
  begin
    read(mae, actual);
    writeln('cod: ', actual.cod, ' cant: ', actual.cant);
  end;
end;

var
  mae: arc_pelicula;
  adet: arr_detalle;
  areg: arr_pelicula;

  lectura: str50;

  prod, min: pelicula;

  i: Integer;
begin
  assign(mae, 'maestro');
  rewrite(mae);
  writeln('Se asigno el archivo maestro');

  for i:= 1 to cant_cines do
  begin
    write('Nombre del archivo detalle: ');
    readln(lectura);

    assign(adet[i], lectura);

    informarMaestro(adet[i]);
  end;
  writeln('Se abrieron los archivos detalle');

  // Asignar primera lectura de cada archivo detalle
  for i:= 1 to cant_cines do
  begin
    reset(adet[i]);
    leer(adet[i], areg[i]);
  end;

  // Obtener el elemento mínimo dentro del arreglo de películas
  minimo(adet, areg, min);
  while (min.cod <> valoralto) do
  begin
    prod:= min;
    prod.cant:= 0;
    while (min.cod = prod.cod) do
    begin
      prod.cant:= prod.cant + min.cant;

      minimo(adet, areg, min);
    end;

    actualizarMaestro(mae, prod);
  end;

  informarMaestro(mae);

  // Cerrar archivos
  close(mae);
  writeln('Se cerro el archivo maestro');

  for i:= 1 to cant_cines do
  begin
    close(adet[i]);
  end;
  writeln('Se cerraron los archivos detalles');

  writeln('Fin del programa');
  readln();
end.

