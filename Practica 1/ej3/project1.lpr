program project1;
const
     FIN = 'zzz';

type
  tArchivo= Text;
var
  arch: tArchivo;
  nomArch: String[50];
  lecDino: String[50];
begin
  write('Nombre del Archivo: ');
  readln(nomArch);

  assign(arch, nomArch);

  rewrite(arch);
  write('dino: ');
  readln(lecDino);
  while (lecDino <> FIN) do
  begin
       writeln(arch, lecDino);

       write('dino: ');
       readln(lecDino);
  end;

  close(arch);
end.

