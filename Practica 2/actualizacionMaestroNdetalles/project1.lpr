program project1;
const
  valoralto=9999;
  N=2;

type
  str50= String[50];
  plato= record
    cod: Integer;
    nom: str50;
    cost: Real;
    fec: str50;
    cant: Integer;
  end;
  venta= record
    cod: Integer;
    cant: Integer;
  end;

  arc_mae= File of plato;
  arc_det= File of venta;

  arr_reg= Array [1..N] of venta;
  arr_det= Array [1..N] of arc_det;

procedure leerDet(var det: arc_det; var reg: venta);
begin
  if (not EOF(det)) then
     read(det, reg)
  else
     reg.cod:= valoralto;
end;
procedure leerMae(var mae: arc_mae; var reg: plato);
begin
  if (not EOF(mae)) then
     read(mae, reg)
  else
     reg.cod:= valoralto;
end;

procedure minimo(var adet: arr_det; var areg: arr_reg; var min: venta);
var
  i, minPos: Integer;
begin
  minPos:= 1;
  min:= areg[1];

  for i:= 2 to N do
  begin
    if (areg[i].cod < min.cod) then
    begin
      minPos:= i;
      min:= areg[i];
    end;
  end;

  leerDet(adet[minPos], areg[minPos]);
end;

procedure actualizarMaestro(var mae: arc_mae; reg_venta: venta);
var
  reg_plato: plato;
begin
  leerMae(mae, reg_plato);
  while (not EOF(mae) and (reg_plato.cod <> reg_venta.cod)) do
    leerMae(mae, reg_plato);

  reg_plato.cant:= reg_plato.cant + reg_venta.cant;

  seek(mae, FilePos(mae) - 1);
  write(mae, reg_plato);
end;

var
  mae: arc_mae;

  adet: arr_det;
  areg: arr_reg;

  min, actual: venta;

  lectura: str50;
  i: Integer;
begin
  assign(mae, 'maestro');
  writeln('Se abrio el archivo maestro');
  reset(mae);

  for i:= 1 to N do
  begin
    write('Ingrese el nombre del archivo detalle: ');
    readln(lectura);

    assign(adet[i], lectura);
  end;
  writeln('Se abrieron los archivos detalle');

  for i:= 1 to N do
  begin
    reset(adet[i]);
    read(adet[i], areg[i]);
  end;

  minimo(adet, areg, min);
  while (min.cod <> valoralto) do
  begin
    actual.cod:= min.cod;
    actual.cant:= 0;

    while ((min.cod <> valoralto) and (min.cod = actual.cod)) do
    begin
      actual.cant:= actual.cant + min.cant;
      minimo(adet, areg, min);
    end;

    actualizarMaestro(mae, actual);
  end;

  close(mae);
  writeln('Se cerro el archivo maestro');

  for i:= 1 to N do
  begin
    close(adet[i]);
  end;
  writeln('Se cerraron los archivos detalle');

  writeln('Fin del programa');
  readln();
end.

