function [czlon] = GenCzlon(nazwa,srodek,masa,moment,kat,punkty,data,id)
%GenCzlon Funkcja generuj¹ca strukturê opisuj¹c¹ cz³on mechanizmu w oparciu
%o ci¹g puntków opisuj¹cych go. Dla uproszczenia przekazywane sa tablice ze
%zbiorem wszyskich puntkow startowych - do ulatwienia przeliczania
%ARGUMENTY FUNKCJI:
%nazwa      --- nazwa cz³onu
%srodek     --- nazwa punktu œrodka masy
%kat        --- pocz¹tkowy k¹t obrotu lokalnego uk³adu wspó³rzêdnych
%punkty     --- tablica nazw punktów
%data       --- tablica wszystkich punktów ca³ego mechanizmu
%id         --- numer identyfikacyjny cz³onu

%POLA STRUKTURY CZ£ON:
%id         --- numer id
%nazwa      --- nazwa czlonu
%srodek     --- punkt œrodka masy
%kat        --- k¹t pocz¹tkowy miêdzy osiami uk³adu cz³onu i uk³adu globalnego
%kolor      --- kolor cz³onu
%lancuch    --- tablica przechowuj¹ca listê punktów we wspó³.lokalnych

%srodek we wspó³rzêdnych absolutnych
czlon.id = id; %przypisanie numeru identyfikacyjnego
czlon.nazwa = nazwa; %przypisanie nazwy
czlon.srodek = FindPoint(srodek,data); %funkcja FindPoint wyszukuje odpowiedni punkt z tablicy wszystkich punktów
czlon.kat = kat; 
czlon.kolor = rand(1,3); %losowanie koloru cz³onu
for i=1:length(punkty)
    p = FindPoint(punkty(i),data);
    B = p.q - czlon.srodek.q;
    p.q = R(czlon.kat)\B;
    lancuch(i) = p; %tablicy lancuch przypisujemy listê punktów cz³onu we wspó³rzêdnych LOKALNYCH
end
czlon.lancuch = lancuch; %do³¹czenie tablicy lancuch jako elementu struktury czlon
czlon.M=[masa,0,0;0,masa,0;0,0,moment];
end

