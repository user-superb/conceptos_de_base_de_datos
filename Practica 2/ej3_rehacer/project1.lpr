program project1;
const
  valoralto=9999;
  cant_detalles=2;
type
  str50= String[50];
  calzado=record
    cod: Integer;
    num: Real;
    desc: str50;
    precio: Real;
    color: str50;
    stock: Integer;
    stock_min: Integer
  end;
  venta_calzado=record
    cod: Integer;
    num: Integer;
    cant: Integer;
  end;

  arc_maestro= File of calzado;
  arc_detalle= File of venta_calzado;
  arc_informe= Text;

  arr_detalle= Array[1..cant_detalles] of arc_detalle;
  arr_venta= Array[1..cant_detalles] of venta_calzado;

  procedure leer(var det: arc_detalle; var reg: venta_calzado);
  begin
    if (not EOF(det)) then
       read(det, reg)
    else
       reg.cod:= valoralto;
  end;

  procedure minimo(var adet: arr_detalle; var areg: arr_venta; var min: venta_calzado);
  var
    posMin: Integer;
    i: Integer;
  begin
    posMin:= 1;
    // El primer mínimo será el elemento 1
    min:= areg[1];
    // Recorro el arreglo de ventas
    for i:= 2 to cant_detalles do
    begin
      if ((areg[i].cod = min.cod) and (areg[i].num < min.num)) or ((areg[i].cod < min.cod)) then
         begin
           min:= areg[i];
           posMin:= i;
         end;
    end;

    // Actualizar registro de mínimos
    leer(adet[posMin], areg[posMin]);

    // El procedimiento "devuelve" el mínimo del arreglo de ventas y actualiza el elemento en esa posición al siguiente dentro del archivo detalle
  end;

  procedure imprimirMaestro(var mae: arc_maestro);
  var
    prod: calzado;
  begin
    reset(mae);
    while (not EOF(mae)) do
    begin
      read(mae, prod);
      writeln('cod: ', prod.cod, '. num: ', prod.num, ' stock: ', prod.stock:2, ' stock_min: ', prod.stock_min:2);
    end;
  end;

  procedure actualizarMaestro(var mae: arc_maestro; var informe: arc_informe; var reg: venta_calzado);
  var
    actual: calzado;
  begin
    actual.cod:= valoralto;
    actual.num:= -1;

    while (actual.cod <> reg.cod) do
    begin
      read(mae, actual);
      if (actual.cod <> reg.cod) then
         writeln('El calzado ',actual.cod,' num ',actual.num,'no tuvo ventas.');
    end;
    while ((actual.cod = reg.cod) and (actual.num <> reg.num)) do // Se asume que existe el código y el número del calzado
    begin
      read(mae,actual);
      if (actual.num <> reg.num) then
         writeln('El calzado ',actual.cod,' num ',actual.num,'no tuvo ventas.');
    end;


    actual.stock:= actual.stock - reg.cant;
    if (actual.stock >= 0) then
       begin
         if (actual.stock < actual.stock_min) then
            begin
              writeln(informe, actual.cod);
            end;
         seek(mae, FilePos(mae) - 1);
         write(mae, actual);
       end;
  end;

var
  mae: arc_maestro;
  informe: arc_informe;
  // Arreglo de detalles
  adet: arr_detalle;
  // Arreglo de ventas
  // Ej. El elemento 7 en el arreglo de ventas le corresponde al elemento 7 en el arreglo de detalles
  areg: arr_venta;

  prod, min: venta_calzado;

  lectura: str50;

  i: Integer;
begin
  assign(mae, 'maestro');
  write('Se asignó el archivo maestro');
  writeln();
  assign(informe, 'calzadosinstock.txt');
  rewrite(informe);
  write('Se asignó el archivo informe');
  writeln();

  imprimirMaestro(mae);
  reset(mae);

  // Asignar detalles
  for i:= 1 to cant_detalles do
  begin
    write('Nombre del archivo detalle: ');
    readln(lectura);
    assign(adet[i], lectura);
  end;

  // Asignar la primera venta del detalle i al elemento i del arreglo de ventas.
  for i:= 1 to cant_detalles do
  begin
    reset(adet[i]);
    leer(adet[i], areg[i]);
  end;

  minimo(adet, areg, min);

  while (min.cod <> valoralto) do
  begin
    prod.cod := min.cod;
    prod.num := min.num;
    prod.cant := 0;

    while ((min.cod = prod.cod) and (min.num = prod.num)) do
    begin
      prod.cant := prod.cant + min.cant;
      minimo(adet, areg, min);
    end;
    actualizarMaestro(mae, informe, prod);
  end;

  imprimirMaestro(mae);

  close(mae);
  close(informe);

  for i:= 1 to cant_detalles do
  begin
    close(adet[i]);
  end;

  writeln('Fin de la ejecución.');
  readln();
end.

