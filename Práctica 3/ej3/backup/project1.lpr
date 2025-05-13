program project1;
type
  str50= String[50];
  producto= record
    cod: Integer;
    nom: str50;
    desc: str50;
    stock: Integer;
  end;

  arc_producto= File of producto;

  arc_texto= Text;

procedure GenerarArchivoBinario(var texto: arc_texto; var bin: arc_producto);
var
  aux_producto: producto;
  aux_str: str50;

  cod: integer;
begin
  // Crear archivo binario
  assign(bin, 'data.bin');
  rewrite(bin);

  // Analizar texto. Se asume que hay 1 dato por línea y que hay 4*n datos ordenados de forma: cod, nom, desc y por último stock, n es el número de productos.
  reset(texto);
  while (not EOF(texto)) do
  begin
    // Código.
    read(texto, aux_str);
    val(aux_str, aux_producto.cod, cod);

    // Nombre.
    read(texto, aux_producto.nom);

    // Descripción.
    read(texto, aux_producto.desc);

    // Stock.
    read(texto, aux_str);
    val(aux_str, aux_producto.stock, cod);


    // Escribir en 'data.bin'
    write(bin, aux_producto);
  end;

  close(bin);
end;

procedure BajaLogica(var arc: arc_producto; cod: Integer);
var
  aux_producto: producto;
begin
  reset(arc);

  aux_producto.cod:= -1;
  while (aux_producto.cod <> cod) do
    read(arc, aux_producto);

  if (aux_producto.cod = cod) then
  begin
    seek(arc, FilePos(arc) - 1);
    aux_producto.stock:= -1;
    write(arc, aux_producto);
  end
  else
    writeln('No se encontro el producto.');
end;

procedure Alta(var arc: arc_producto; prod: producto);
begin
  seek(arc, FileSize(arc));
  write(arc, prod);
end;

procedure BajaLogicaConRecu(var arc: arc_producto; cod: Integer);
var
  aux_producto: producto;

  pos: Integer;
begin
  reset(arc);

  aux_producto.cod:= -1;
  while (aux_producto.cod <> cod) do
    read(arc, aux_producto);

  if (aux_producto.cod = cod) then
  begin
    pos:= FilePos(arc) - 1;
    // Leo el registro cabecera.
    seek(arc, 0); read(arc, aux_producto);

    // Escribo el registro cabecera en la posición que quiero borrar.
    seek(arc, pos); write(arc, aux_producto;

    // Cambio el código del registro cabecera al número de posición a la que se marcó.
    aux_producto.cod:= pos;
    seek(arc, 0); write(arc, aux_producto);
  end
  else
    writeln('No se encontro el producto.');
end;

procedure AltaConRecu(var arc: arc_producto; prod: producto);
var
  registroLibre: producto;
  nLibre: Integer;
begin
  reset(arc);

  // Leer cabecera.
  read(arc, registroLibre);

  if (registroLibre.cod = -1) then // Cabecera sin puntero.
  begin
    seek(arc, FileSize(arc));
    write(arc, prod);
  end
  else // Cabecera con puntero a un registro.
  begin
    nLibre:= registroLibre.cod;
    seek(arc, nLibre); read(arc, registroLibre);
    seek(arc, 0); write(arc, registroLibre);
    seek(arc, nLibre); write(arc, prod);
  end;
end;

procedure GenerarArchivoBinarioConRecu(var texto: arc_texto; var bin: arc_producto);
var
  aux_producto: producto;
  aux_str: str50;

  cod: integer;
begin
  // Crear archivo binario
  assign(bin, 'data.bin');
  rewrite(bin);

  // Asignar registro cabecera
  aux_producto.cod:= -1;
  aux_producto.stock:= -1;
  write(bin, aux_producto);

  // Analizar texto. Se asume que hay 1 dato por línea y que hay 4*n datos ordenados de forma: cod, nom, desc y por último stock, n es el número de productos.
  reset(texto);
  while (not EOF(texto)) do
  begin
    // Código.
    read(texto, aux_str);
    val(aux_str, aux_producto.cod, cod);

    // Nombre.
    read(texto, aux_producto.nom);

    // Descripción.
    read(texto, aux_producto.desc);

    // Stock.
    read(texto, aux_str);
    val(aux_str, aux_producto.stock, cod);


    // Escribir en 'data.bin'
    write(bin, aux_producto);
  end;

  close(bin);
end;

// Punto g.: Ventajas de usar técnica de recuperación:
//           1. Ahorro de almacenamiento
//           2. Permite saber inmediatamente si hay un registro libre
//
//           Ventajas de NO usar técnica de recuperación:
//           1. Es más rápido a costa de que se produzca fragmentación interna.

begin
end.

