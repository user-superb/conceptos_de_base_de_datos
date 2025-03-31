program project1;
type
  tArchivoInteger= File of Integer;
  tArchivoText= Text;

var
  archVotos: tArchivoInteger;
  archTexto: tArchivoText;

  lectura: Integer;

  nomArchVotos, nomArchTexto: String[50];
begin
  write('Nombre del Archivo con los Votos: ');
  readln(nomArchVotos);
  write('Nombre del Archivo de Texto: ');
  readln(nomArchTexto);

  assign(archVotos, nomArchVotos);
  reset(archVotos);
  assign(archTexto, nomArchTexto);
  rewrite(archTexto);

  while (not eof(archVotos)) do
  begin
    read(archVotos, lectura);
    writeln(archTexto, votos);
  end;

  close(archVotos);
  close(archTexto);
end.

