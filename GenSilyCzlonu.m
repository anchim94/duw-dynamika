function [ sila ] = GenSilyCzlonu(typ,czlon,wartosc,punkt_przylozenia,czlon2,punkt_przylozenia2,wspolczynniki )
%GenSilyCzlonu Generuje strukture przechowuj¹c¹ informacje o si³ach
%ARGUMENTY FUNKCJI:
%typ                --- typ si³y (sta³a, sprê¿yna,...)
%czlon              --- CZ£ON 1 - nazwa
%wartosc            --- tablica cz³onów mechanizmu
%punkt_przylozenia  --- CZ£ON 1 - punkt przy³o¿enia (nazwa)
%czlon2             --- CZ£ON 2 - nazwa
%punkt_przylozenia2 --- CZ£ON 2 - punkt przy³o¿enia (nazwa)
%wspolczynniki      --- wspó³czynnik potrzebne do wyznaczenia si³y sprê¿yny


sila.typ=typ;
sila.wektor=wartosc;
sila.czlon=czlon;
sila.punkt_przylozenia=punkt_przylozenia;
sila.czlon2=czlon2;
sila.punkt_przylozenia2=punkt_przylozenia2;
sila.wspolczynniki=wspolczynniki;

end

