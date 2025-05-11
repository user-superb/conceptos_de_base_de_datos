program project1;
type
  str50= String[50];
  informacion= record
    par: str50;
    loc: str50;
    bar: str50;
    ni: Integer;
    ad: Integer;
  end;

  arc_info= File of informacion;

procedure leer(var arc: arc_info; var info: informacion);
begin
  if (not EOF(arc)) then
     read(arc, info);
end;

var
  arc: arc_info;
  info, actual: informacion;

  entrada: str50;

  hayData: Boolean;

  LcantNi, LcantAd, PcantNi, PcantAd: Integer;
begin
  write('Nombre del archivo: ');
  readln(entrada);
  assign(arc, entrada);
  reset(arc);

  if (not EOF(arc)) then
  begin
    read(arc, info);
    hayData:= true;
  end
  else
    hayData:= false;

  while (hayData) do
  begin
    actual:= info;
    writeln('Partido: ', actual.par);

    PcantNi:= 0;
    PcantAd:= 0;

    while (hayData and (actual.par = info.par)) do
    begin
      actual.loc:= info.loc;
      writeln('Localidad: ', info.loc);

      LcantNi:= 0;
      LcantAd:= 0;

      while (hayData and (actual.par = info.par) and (actual.loc = info.loc)) do
      begin
        writeln('Cantidad niños: ', info.ni, '  Cantidad adultos: ', info.ad);
        LcantNi:= LcantNi + info.ni;
        LcantAd:= LcantAd + info.ad;

        if (not EOF(arc)) then
          read(arc, info)
        else
          hayData:= false;
      end;

      writeln('Total niños localidad ',actual.loc,' : ', LcantNi, '  Total adultos localidad ',actual.loc,' : ', LcantAd);

      PcantNi:= PcantNi + LcantNi;
      PcantAd:= PcantAd + LcantAd;
    end;

    writeln('TOTAL NIÑOS PARTIDO: ', PcantNi, '  TOTAL ADULTOS PARTIDO: ', PcantAd);
  end;

  close(arc);
end.

