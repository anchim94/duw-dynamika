function [mechanizm] = DodajWiez(mechanizm,typ,ob1,punkt1,ob2,punkt2,funkcja, funid)
%DodajWiez Funkcja generuj�ca wi�z do obslugi po��cznienia pomi�dzy dwoma
%obiektami-czlonami (ob_) oraz punktami do nich nale��cych (punkt_).
%Id opisuje miejsce w ukladzie rowna� oraz macierzy jakobiego, a funkcja to
%opis do specyficznych wiezow okreslanych w czasie.
%ARGUMENTY FUNKCJI:
%mechanizm   --- struktura mechanizm
%typ         --- nazwa typu wi�zu ('obrotowa', 'postepowa', 'mocowanie', 'przemieszczenie')
%ob1         --- nazwa obiektu (cz�on) 1
%punkt1      --- nazwa punktu wi�zu nale��cy do cz�onu 1
%ob2         --- nazwa obiektu (cz�on) 2
%punkt2      --- nazwa punktu wi�zu nale��cy do cz�onu 2
%funkcja     --- funkcja specjalna opisuj�ca relacj� mi�dzy cz�onami (dotyczy typu przemieszczenie)
%funid       --- numer funkcji steruj�cej

%POLA STRUKTUY WIEZ:
%typ        --- typ wiezu
%OA         --- obiekt 1
%PA         --- punkt 1
%OB         --- obiekt 2
%PB         --- punkt 2
%fun        --- funkcja opsiuj�ca relacje miedzy punktami wiezu
%id         --- numer id wiezu
%funid      --- numer funkcji steruj�cej

%funkcja zlicza ilo�� wi�z�w, kt�ra jest przechowywana w strukturze mechanizm
n = mechanizm.wiezyilosc;
if mechanizm.wiezyilosc == 0
    i=1;
else
    i = length(mechanizm.wiezy)+1;
end

%TYP OBROTOWA (odbiera mo�liwo�� ruchu post�powego punkt�w wzgl�dem siebie)
if strcmp(typ,'obrotowa')
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',funkcja,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+2;
end

%TYP POST�POWA -- ??????????????????????????????????????????????????
if strcmp(typ,'postepowa')
    C1 = FindCzlon(ob1,mechanizm.czlony); %pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(punkt1,C1.lancuch); %pobiera struktur� punktu (punkt 1)
    C2 = FindCzlon(ob2,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 2)
    P2 = FindPoint(punkt2,C2.lancuch); %pobiera struktur� punktu (punkt 2)
    d = C1.srodek.q+R(C1.kat)*P1.q-C2.srodek.q-R(C2.kat)*P2.q; %d - odleglosc miedzy punktami 1 i 2
    %wyznaczenie v(j) -> j czyli drugi uk�ad, zwi�zany z C2
    v = [0,-1;1,0]*inv(R(C2.kat))*d; %???????????????????????????
    v = v/norm(v);
    F = @(t)[C1.kat-C2.kat;v]; %??????????????????????????????????
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',F,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+2; %wi�z odbiera dwa stopnie swobody
end

%TYP MOCOWANIE - fiksuje punkt do pod�o�a (odbiera ruch post�powy, tylko
%obr�t)
if strcmp(typ,'mocowanie')
    C1 = FindCzlon(ob1,mechanizm.czlony); %pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(punkt1,C1.lancuch); %pobiera struktur� punktu (punkt 1)
    F = @(t)C1.srodek.q+R(C1.kat)*P1.q; %funkcja opisuj�ca wsp�rz�dn� punktu
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',F,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+2; %wi�z odbiera dwa stopnie swobody
end
%TYP OBROT - wi�z kieruj�cy obrotem
if strcmp(typ,'obrot')  
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',funkcja,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+1; %wi�z odbiera dwa stopnie swobody
end
%TYP PRZEMIESZCZENIE --- ???????????????????????????????????????
if strcmp(typ,'przemieszczenie')
    C1 = FindCzlon(ob1,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(punkt1,C1.lancuch); %pobiera struktur� punktu (punkt 1)
    C2 = FindCzlon(ob2,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 2)
    P2 = FindPoint(punkt2,C2.lancuch);%pobiera struktur� punktu (punkt 2)
    d = C1.srodek.q+R(C1.kat)*P1.q-C2.srodek.q-R(C2.kat)*P2.q; %d - odleglosc miedzy punktami 1 i 2
    %wyznaczenie v(j) -> j czyli drugi uk�ad, zwi�zany z C2
    u = inv(R(C2.kat))*d; %??????????????????????????????????????
    u = u/norm(u); %u - wersor na kierunku mi�dzy punktami 1 i 2
    F = @(t)[funkcja(t);u]; 
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',F,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+1; %wi�z odbiera jeden stopie� swobody
end

%dodanie wi�zu do struktury mechanizm
mechanizm.wiezy(i,1) = wiez;
