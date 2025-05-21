program project1;
type
  str50= String[50];
  arch_texto= Text;

procedure CrearArchivoTexto(var arch: arch_texto);
var
  entrada: str50;
begin
  rewrite(arch);

  write(': ');
  readln(entrada);
  while(entrada <> 'FIN') do
  begin
    write(arch, entrada);
    write(': ');
    readln(entrada);
  end;
end;

procedure LeerArchivoTexto(var arch: arch_texto);
var
  aux_str: str50;
  aux_int: Integer;
begin
  reset(arch);

  aux_str:= 'VACIO';

  while (not EOF(arch)) do
    readln(arch, aux_str, aux_int);

  writeln('aux_str: ', aux_str);
  writeln('aux_int: ', aux_int);
end;

var
  texto: arch_texto;
begin
  assign(texto, 'texto.txt');
  CrearArchivoTexto(texto);
  LeerArchivoTexto(texto);

  close(texto);

  writeln('Fin del programa');
  readln();
end.

