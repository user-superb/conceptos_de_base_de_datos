program project1;
type
  str50= String[50];
  disco= record
    cod: Integer;
    nom: str50;
    gen: str50;
    art: str50;
    ed: Integer;
    stock: Integer;
  end;

  arc_discos= File of disco;

procedure ModificarStock(var arc: arc_discos; cod: Integer);
var
  aux_disco: disco;
begin
  reset(arc);

  aux_disco.cod:= -1;
  while (aux_disco.cod <> cod) do
  begin
    read(arc, aux_disco);
    if (aux_disco.stock = 0) then
      writeln(aux_disco.nom,' no tiene stock.');
  end;

  if (aux_disco.cod = cod) then
  begin
    aux_disco.stock:= 0;
    seek(arc, FilePos(arc) - 1);
    write(arc, aux_disco);
  end
  else
    writeln('No se encontro el disco.');
end;

procedure Actualizar(var arc: arc_discos);
var
  aux_cod: Integer;
begin
  writeln('Modificar el stock a 0');

  aux_cod:= 0;

  while (aux_cod <> -1) do
  begin
    write('Cod. del disco: ');
    readln(aux_cod);
    while (aux_cod <= 0) do
    begin
      write('Cod. invalido. Ingrese de nuevo: ');
      readln(aux_cod);
    end;

    ModificarStock(arc, aux_cod);
  end;
end;

procedure BajaFisica(var arc: arc_discos; pos: Integer);
var
  aux_disco: disco;
begin
  seek(arc, FilePos(arc) - 1); read(arc, aux_disco);
  seek(arc, pos); write(arc, aux_disco);
  seek(arc, 0);
  truncate(arc);

end;

procedure CompactarArchivo(var arc: arc_discos);
var
  aux_disco: disco;
begin
  reset(arc);

  while (not EOF(arc)) do
  begin
    read(arc, aux_disco);
    if (aux_disco.stock <= 0) then
    begin
      BajaFisica(arc, FilePos(arc) - 1);

    end;
  end;
end;

begin
end.

