function [czlon] = GenCzlon(nazwa,srodek,masa,moment,kat,punkty,data,id)
%GenCzlon Funkcja generuj�ca struktur� opisuj�c� cz�on mechanizmu w oparciu
%o ci�g puntk�w opisuj�cych go. Dla uproszczenia przekazywane sa tablice ze
%zbiorem wszyskich puntkow startowych - do ulatwienia przeliczania
%ARGUMENTY FUNKCJI:
%nazwa      --- nazwa cz�onu
%srodek     --- nazwa punktu �rodka masy
%kat        --- pocz�tkowy k�t obrotu lokalnego uk�adu wsp�rz�dnych
%punkty     --- tablica nazw punkt�w
%data       --- tablica wszystkich punkt�w ca�ego mechanizmu
%id         --- numer identyfikacyjny cz�onu

%POLA STRUKTURY CZ�ON:
%id         --- numer id
%nazwa      --- nazwa czlonu
%srodek     --- punkt �rodka masy
%kat        --- k�t pocz�tkowy mi�dzy osiami uk�adu cz�onu i uk�adu globalnego
%kolor      --- kolor cz�onu
%lancuch    --- tablica przechowuj�ca list� punkt�w we wsp�.lokalnych

%srodek we wsp�rz�dnych absolutnych
czlon.id = id; %przypisanie numeru identyfikacyjnego
czlon.nazwa = nazwa; %przypisanie nazwy
czlon.srodek = FindPoint(srodek,data); %funkcja FindPoint wyszukuje odpowiedni punkt z tablicy wszystkich punkt�w
czlon.kat = kat; 
czlon.kolor = rand(1,3); %losowanie koloru cz�onu
for i=1:length(punkty)
    p = FindPoint(punkty(i),data);
    B = p.q - czlon.srodek.q;
    p.q = R(czlon.kat)\B;
    lancuch(i) = p; %tablicy lancuch przypisujemy list� punkt�w cz�onu we wsp�rz�dnych LOKALNYCH
end
czlon.lancuch = lancuch; %do��czenie tablicy lancuch jako elementu struktury czlon
czlon.M=[masa,0,0;0,masa,0;0,0,moment];
end

