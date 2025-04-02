program project1;
type
  texto= String[50];
  cdMaestro= record
    cod: Integer;
    nomA: texto;
    nomD: texto;
    genero: texto;
    cantVend: Integer;
  end;

  tArchivoMaestro= File of cdMaestro;
  tArchivoInforme= Text;

var
  archCD: tArchivoMaestro;
  archInforme: tArchivoInforme;

  regcd: cdMaestro;

  cod_actual: Integer;
  gen_actual: Texto;
  totGen_actual: Integer;
  totAut_actual: Integer;
  totDiscografia: Integer;
begin
  totDiscografia:= 0;

  assign(archCD, 'CDs.dat');
  assign(archInforme, 'informe.txt');

  reset(archCD);
  rewrite(archInforme); 

  while (not eof(archCD)) do
  begin
    read(archCD, regcd);
    cod_actual:= regcd.cod;
    totAut_actual:= 0;

    write('Autor: ', regcd.nomA);
    writeln();

    write(archInforme, 'Autor: ', regcd.nomA);
    writeln(archInforme);

    while (not eof(archCD) and (regcd.cod = cod_actual)) do
    begin
      gen_actual:= regcd.genero;
      totGen_actual:= 0;

      write('Genero: ', regcd.genero);
      writeln();

      while (not eof(archCD) and (regcd.cod = cod_actual) and (regcd.genero = gen_actual)) do
      begin
        totGen_actual:= totGen_actual + regcd.cantVend;
        totAut_actual:= totAut_actual + regcd.cantVend;

        write('Nombre Disco: ', regcd.nomD, ' Cantidad Vendida: ', regcd.cantVend);
        writeln();

        write(archInforme, 'Nombre Disco: ', regcd.nomD, ' Cantidad Vendida: ', regcd.cantVend);
        writeln(archInforme);

        read(archCD, regcd);
      end;
      write('Total Genero: ', totGen_actual);
      writeln();
    end;
    write('Total Autor: ', totAut_actual);
    writeln();
    writeln();
  end;
  write('Total Discografia: ', totDiscografia);
  writeln();

  close(archInforme);
  close(archCD);
  writeln('Se cerraron los archivos.');
  readln();
end.

