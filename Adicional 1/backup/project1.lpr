program project1;
const
  N = 500; FIN = 9999;
type
  str50= String[50];
  reg_det= record
    cod_prov: Integer;
    cod_loc: Integer;
    val: Integer;
    bla: Integer;
    anu: Integer;
  end;

  reg_mae= record
    cod_prov: Integer;
    prov: str50;
    val: Integer;
    bla: Integer;
    anu: Integer;
  end;

  arc_det = File of reg_det;
  arc_mae = File of reg_mae;

  arr_det = Array[1..N] of arc_det;
  arr_min = Array[1..N] of reg_det;

  Texto = Text;

procedure Leer(var arc: arc_det; var reg: reg_det);
begin
  if (not EOF(arc)) then
    read(arc, reg)
  else
    reg.cod_prov:= FIN;
end;

procedure Minimo(var adet: arr_det; var areg: arr_min; var min: reg_det);
var
  i, minPos: Integer;
begin
  min:= areg[1];
  minPos:= 1;

  for i:= 2 to N do
  begin
    if (areg[i].cod_prov < min.cod_prov) then
    begin
      minPos:= i;
      min:= areg[i];
    end
    else if (areg[i].cod_prov = min.cod_prov) and (areg[i].cod_loc < min.cod_loc) then
    begin
      minPos:= i;
      min:= areg[i];
    end;
  end;

  Leer(adet[minPos], areg[minPos]);
end;

procedure actualizarMaestro(var mae: arc_mae; actual: reg_det);
var
  aux_reg: reg_mae;
begin
  aux_reg.cod_prov:= -1;

  while (aux_reg.cod_prov <> actual.cod_prov) do
    read(mae, aux_reg);

  aux_reg.val:= aux_reg.val + actual.val;
  aux_reg.bla:= aux_reg.bla + actual.bla;
  aux_reg.anu:= aux_reg.anu + actual.anu;

  seek(mae, Filepos(mae) - 1);
  write(mae, aux_reg);
end;

procedure generarArchivoTexto(val, bla, anu: Integer);
var
  archivo: Texto;
begin
  assign(archivo, 'cantidad_votos_04_07_2023.txt');
  rewrite(archivo);

  writeln(archivo, 'Cantidad de archivos procesados: ', N);
  writeln(archivo, 'Cantidad total de votos: ', val + bla + anu);

  writeln(archivo, 'Cantidad de votos válidos: ', val);
  writeln(archivo, 'Cantidad de votos en blanco: ', bla);
  writeln(archivo, 'Cantidad de votos anulados: ', anu);

  close(archivo);
end;

var
  mae: arc_mae;
  adet: arr_det;
  areg: arr_min;

  actual, min: reg_det;

  aux_str: str50;
  i, total_val, total_bla, total_anu: Integer;
begin
  // Inicializar maestro
  assign(mae, 'maestro.dat');
  reset(mae);

  // Inicializar las variables totales
  total_val:= 0;
  total_bla:= 0;
  total_anu:= 0;

  // Inicializar el arreglo de detalles
  for i:= 1 to N do
  begin
    write('Ingrese el nombre del archivo detalle: ');
    readln(aux_str);
    assign(adet[i], aux_str);
  end;

  // Inicializar el arreglo de mínimos
  for i:= 1 to N do
  begin
    reset(adet[i]);
    Leer(adet[i], areg[i]);
  end;
  Minimo(adet, areg, min);

  // Recorrer los detalles
  while (min.cod_prov <> FIN) do
  begin
    // Inicializar cuando hay provincia nueva
    actual.cod_prov:= min.cod_prov;
    actual.val:= 0;
    actual.bla:= 0;
    actual.anu:= 0;

    // Mientras no se llegue al final y la provincia sea la misma
    while (min.cod_prov <> FIN) and (min.cod_prov = actual.cod_prov) do
    begin
      actual.val:= actual.val + min.val;
      actual.bla:= actual.bla + min.bla;
      actual.anu:= actual.anu + min.anu;

      // Asignar nuevo mínimo
      Minimo(adet, areg, min);
    end;

    // Sumar al total
    total_val:= total_val + actual.val;
    total_bla:= total_bla + actual.bla;
    total_anu:= total_anu + actual.anu;

    //
    actualizarMaestro(mae, actual);
  end;

  //
  generarArchivoTexto(total_val, total_bla, total_anu);

  // Finalizar programa
  for i:= 1 to N do
    close(adet[i]);

  close(mae);
end.

