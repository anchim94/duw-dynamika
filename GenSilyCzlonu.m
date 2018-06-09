function [ sila ] = GenSilyCzlonu(typ,czlon,wartosc,punkt_przylozenia,czlon2,punkt_przylozenia2,wspolczynniki )
%GenSilyCzlonu Generuje strukture przechowuj�c� informacje o si�ach
%ARGUMENTY FUNKCJI:
%typ                --- typ si�y (sta�a, spr�yna,...)
%czlon              --- CZ�ON 1 - nazwa
%wartosc            --- tablica cz�on�w mechanizmu
%punkt_przylozenia  --- CZ�ON 1 - punkt przy�o�enia (nazwa)
%czlon2             --- CZ�ON 2 - nazwa
%punkt_przylozenia2 --- CZ�ON 2 - punkt przy�o�enia (nazwa)
%wspolczynniki      --- wsp�czynnik potrzebne do wyznaczenia si�y spr�yny


sila.typ=typ;
sila.wektor=wartosc;
sila.czlon=czlon;
sila.punkt_przylozenia=punkt_przylozenia;
sila.czlon2=czlon2;
sila.punkt_przylozenia2=punkt_przylozenia2;
sila.wspolczynniki=wspolczynniki;

end

