program GenerarCDs;

uses SysUtils;

type
  texto = string[50];
  cdMaestro = record
    cod: Integer;
    nomA: texto;
    nomD: texto;
    genero: texto;
    cantVend: Integer;
  end;

var
  archivo: File of cdMaestro;
  temp: cdMaestro;

begin
  temp.cod:= 001;
  temp.nomA:= 'nose';
  temp.nomD:= 'disco';
  temp.genero:= 'cumbia';
  temp.cantVend:= 1000;

  Assign(archivo, 'CDs.dat');
  Rewrite(archivo);

  write(archivo, temp);

  Close(archivo);
  WriteLn('Archivo "CDs.dat" generado exitosamente y ordenado.');
  readln();
end.

