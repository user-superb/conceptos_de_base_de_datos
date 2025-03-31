program project1;
const
  FIN = 'zzz';
type
 Texto = String[50];
 flor = record
   num: Integer;
   altMax: Real;
   nom100: Texto;
   nomVul: Texto;
   color: Texto;
 end;

 tArchivo= File of Flor;
 tArchivoTexto= Text;

function leerFlor():flor;
var
  nue_flor: flor;
  lec_str: String[50];
  lec_int: Integer;
  lec_float: Real;
begin
  write('Nombre Cientifico: ');
  readln(lec_str);
  nue_flor.nom100:= lec_str;

  if (nue_flor.nom100 <> FIN) then
    begin
      write(' Nombre Vulgar: ');
      readln(lec_str);
      nue_flor.nomVul:= lec_str;

      write(' Numero de especie: ');
      readln(lec_int);
      nue_flor.num:= lec_int;

      write(' Color: ');
      readln(lec_str);
      nue_flor.color:= lec_str;

      write(' Altura Maxima: ');
      readln(lec_float);
      nue_flor.altMax:= lec_float;
    end;

    leerFlor:= nue_flor;
end;

function reportarCantEspecies(var arch: tArchivo):Integer;
var
  f: flor;
  cont: Integer;
begin
  cont:= 0;

  reset(arch);
  while (not eof(arch)) do
  begin
    read(arch, f);
    cont:= cont + 1;
  end;

  reportarCantEspecies:= cont;
end;

procedure listarFlores(var arch: tArchivo);
var
  f: flor;
begin
  reset(arch);

  while (not eof(arch)) do
  begin
    read(arch, f);
    writeln(f.num, ' ', f.nom100, ' ', f.nomVul, ' ', f.color, ' ', f.altMax);
  end;
end;

procedure cambiarNombre(var arch: tArchivo; a: Texto; b: Texto);
var
  f: flor;
begin
  reset(arch);

  while (not eof(arch)) do
  begin
    read(arch, f);

    if (f.nom100 = a) then
    begin
       f.nom100:= b;
       seek(arch, FilePos(arch) - 1);
       write(arch, f);
    end;
  end;

  close(arch);
end;

procedure agregarAlFinal(var arch: tArchivo);
var
  nue_flor: flor;
begin
  while(not eof(arch)) do
  begin
    read(arch, nue_flor);
  end;

  nue_flor:= leerFlor();
  while(nue_flor.nom100 <> FIN) do
  begin
    write(arch, nue_flor);

    writeln();
    nue_flor:= leerFlor();
  end;
end;

procedure exportarTexto(var arch: tArchivo);
var
  nomArchTexto: Texto;
  archTexto: tArchivoTexto;
  f: flor;
begin
  write('Nombre del Archivo de Texto a Exportar: ');
  readln(nomArchTexto);
  assign(archTexto, nomArchTexto);

  append(archTexto);

  reset(arch);
  while (not eof(arch)) do
  begin
    read(arch, f);
    writeln(archTexto, f.num, ' ', f.nom100, ' ', f.nomVul, ' ', f.color, ' ', f.altMax);
  end;

  close(archTexto);
  write('Se exportaron las flores a un archivo de texto.');
  writeln();
end;

var
  arch: tArchivo;
  nom_archivo: Texto;
  nue_flor: flor;
begin
  write('Nombre del Archivo a Escribir: ');
  readln(nom_archivo);

  assign(arch, nom_archivo);
  rewrite(arch);

  nue_flor:= leerFlor();
  while (nue_flor.nom100 <> FIN) do
  begin
    write(arch, nue_flor);

    writeln();
    nue_flor:= leerFlor();
  end;

//  writeln('Cantidad de especies: ', reportarCantEspecies(arch));
  writeln();
//  cambiarNombre(arch, 'Victoria amazonica', 'Victoria amazónica');
  listarFlores(arch);
//  writeln();
//  agregarAlFinal(arch);
//  writeln();
//  listarFlores(arch);

  exportarTexto(arch);

  close(arch);
  writeln('Se cerro el archivo.');
  readln();
end.

