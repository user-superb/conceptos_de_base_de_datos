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

const
  NUM_REGISTROS = 20;  {Número de CDs a generar}
  AUTORES: array[1..5] of texto = ('Autor A', 'Autor B', 'Autor C', 'Autor D', 'Autor E');
  DISCOS: array[1..10] of texto = ('Disco X', 'Disco Y', 'Disco Z', 'Disco W', 'Disco V', 'Disco U', 'Disco T', 'Disco S', 'Disco R', 'Disco Q');
  GENEROS: array[1..3] of texto = ('Rock', 'Pop', 'Jazz');

var
  archivo: File of cdMaestro;
  lista: array[1..NUM_REGISTROS] of cdMaestro;
  i, j: Integer;
  temp: cdMaestro;

procedure OrdenarLista(var arr: array of cdMaestro; n: Integer);
begin
  for i := 0 to n - 2 do
    for j := i + 1 to n - 1 do
      if (arr[i].cod > arr[j].cod) or
         ((arr[i].cod = arr[j].cod) and (arr[i].genero > arr[j].genero)) or
         ((arr[i].cod = arr[j].cod) and (arr[i].genero = arr[j].genero) and (arr[i].nomD > arr[j].nomD)) then
      begin
        temp := arr[i];
        arr[i] := arr[j];
        arr[j] := temp;
      end;
end;

begin
  Randomize;

  for i := 1 to NUM_REGISTROS do
  begin
    lista[i].cod := Random(5) + 1; {Selecciona un código de autor del 1 al 5}
    lista[i].nomA := AUTORES[lista[i].cod];
    lista[i].nomD := DISCOS[Random(10) + 1]; {Selecciona un disco aleatorio}
    lista[i].genero := GENEROS[Random(3) + 1]; {Selecciona un género aleatorio}
    lista[i].cantVend := Random(100) + 1; {Cantidad entre 1 y 100}
  end;

  OrdenarLista(lista, NUM_REGISTROS);

  Assign(archivo, 'CDs.dat');
  Rewrite(archivo);

  for i := 1 to NUM_REGISTROS do
    Write(archivo, lista[i]);

  Close(archivo);
  WriteLn('Archivo "CDs.dat" generado exitosamente y ordenado.');
end.

