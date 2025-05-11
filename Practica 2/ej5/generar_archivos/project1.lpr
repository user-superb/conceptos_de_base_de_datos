program generar_archivo;
type
  str50 = String[50];
  informacion = record
    par: str50;
    loc: str50;
    bar: str50;
    ni: Integer;
    ad: Integer;
  end;

  arc_info = File of informacion;

var
  arc: arc_info;
  info: informacion;
  nombreArchivo: str50;
  i: Integer;
begin
  write('Ingrese el nombre del archivo a crear: ');
  readln(nombreArchivo);

  assign(arc, nombreArchivo);
  rewrite(arc);

  writeln('Se ingresarán algunos registros de prueba...');
  writeln;

  // Ejemplo de datos de prueba agrupados por partido y localidad
  // Partido 1: "La Plata", Localidad: "Tolosa", "Ringuelet"
  // Partido 2: "Berisso", Localidad: "Villa Zula"
  for i := 1 to 5 do
  begin
    case i of
      1:
        begin
          info.par := 'La Plata';
          info.loc := 'Tolosa';
          info.bar := 'Barrio A';
          info.ni := 10;
          info.ad := 20;
        end;
      2:
        begin
          info.par := 'La Plata';
          info.loc := 'Tolosa';
          info.bar := 'Barrio B';
          info.ni := 5;
          info.ad := 10;
        end;
      3:
        begin
          info.par := 'La Plata';
          info.loc := 'Ringuelet';
          info.bar := 'Barrio C';
          info.ni := 7;
          info.ad := 8;
        end;
      4:
        begin
          info.par := 'Berisso';
          info.loc := 'Villa Zula';
          info.bar := 'Barrio D';
          info.ni := 12;
          info.ad := 15;
        end;
      5:
        begin
          info.par := 'Berisso';
          info.loc := 'Villa Zula';
          info.bar := 'Barrio E';
          info.ni := 9;
          info.ad := 13;
        end;
    end;

    write(arc, info);
  end;

  close(arc);
  writeln('Archivo creado y datos escritos correctamente.');
end.

