program project1;
type
  str50= String[50];
  tVehiculo= record
    codigoVehiculo: Integer;
    patente: str50;
    numMotor: str50;
    cantidadPuertas: Integer;
    precio: Real;
    descripcion: str50;
  end;
  tArchivo= File of tVehiculo;

procedure agregar(var arch: tArchivo; vehiculo: tVehiculo);
var
  sLibre: tVehiculo;
  nLibre, cod: Integer;
begin
  reset(arch);

  // Leer cabecera.
  read(arch, sLibre);
  nLibre:= sLibre.codigoVehiculo;

  if (nLibre = 0) then // Si no hay registro disponible:
    seek(arch, FileSize(arch))
  else // Sino (Hay registro/s disponible/s):
  begin
    seek(arch, nLibre); read(arch, sLibre);
    seek(arch, 0); write(arch, sLibre);
    seek(arch, nLibre);
  end;

  // Escribir en el archivo.
  write(arch, vehiculo);
end;

procedure eliminar(var arch: tArchivo; codigoVehiculo: Integer);
var
  aux_vehiculo: tVehiculo;
  sLibre: tVehiculo;
  nLibre: Integer;
begin
  reset(arch);

  // Leer cabecera
  read(arch, sLibre);

  // Buscar vehículo
  aux_vehiculo.codigoVehiculo:= -1;
  while (aux_vehiculo.codigoVehiculo <> codigoVehiculo) do
    read(arch, aux_vehiculo);

  if (aux_vehiculo.codigoVehiculo = codigoVehiculo) then // Si se encontró el vehículo:
  begin
    nLibre:= FilePos(arch) - 1;
    seek(arch, nLibre); write(arch, sLibre); // Escribo lo que estaba en la cabecera al registro n.
    sLibre.codigoVehiculo:= nLibre;
    seek(arch, 0); write(arch, sLibre); // Escribo n en la cabecera.
  end
  else // Sino:
    writeln('No se encontro el vehiculo.');
end;

begin
end.

