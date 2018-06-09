function [mechanizm] = DodajWiez(mechanizm,typ,ob1,punkt1,ob2,punkt2,funkcja, funid)
%DodajWiez Funkcja generuj¹ca wiêz do obslugi po³¹cznienia pomiêdzy dwoma
%obiektami-czlonami (ob_) oraz punktami do nich nale¿¹cych (punkt_).
%Id opisuje miejsce w ukladzie rownañ oraz macierzy jakobiego, a funkcja to
%opis do specyficznych wiezow okreslanych w czasie.
%ARGUMENTY FUNKCJI:
%mechanizm   --- struktura mechanizm
%typ         --- nazwa typu wiêzu ('obrotowa', 'postepowa', 'mocowanie', 'przemieszczenie')
%ob1         --- nazwa obiektu (cz³on) 1
%punkt1      --- nazwa punktu wiêzu nale¿¹cy do cz³onu 1
%ob2         --- nazwa obiektu (cz³on) 2
%punkt2      --- nazwa punktu wiêzu nale¿¹cy do cz³onu 2
%funkcja     --- funkcja specjalna opisuj¹ca relacjê miêdzy cz³onami (dotyczy typu przemieszczenie)
%funid       --- numer funkcji steruj¹cej

%POLA STRUKTUY WIEZ:
%typ        --- typ wiezu
%OA         --- obiekt 1
%PA         --- punkt 1
%OB         --- obiekt 2
%PB         --- punkt 2
%fun        --- funkcja opsiuj¹ca relacje miedzy punktami wiezu
%id         --- numer id wiezu
%funid      --- numer funkcji steruj¹cej

%funkcja zlicza iloœæ wiêzów, która jest przechowywana w strukturze mechanizm
n = mechanizm.wiezyilosc;
if mechanizm.wiezyilosc == 0
    i=1;
else
    i = length(mechanizm.wiezy)+1;
end

%TYP OBROTOWA (odbiera mo¿liwoœæ ruchu postêpowego punktów wzglêdem siebie)
if strcmp(typ,'obrotowa')
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',funkcja,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+2;
end

%TYP POSTÊPOWA -- ??????????????????????????????????????????????????
if strcmp(typ,'postepowa')
    C1 = FindCzlon(ob1,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(punkt1,C1.lancuch); %pobiera strukturê punktu (punkt 1)
    C2 = FindCzlon(ob2,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 2)
    P2 = FindPoint(punkt2,C2.lancuch); %pobiera strukturê punktu (punkt 2)
    d = C1.srodek.q+R(C1.kat)*P1.q-C2.srodek.q-R(C2.kat)*P2.q; %d - odleglosc miedzy punktami 1 i 2
    %wyznaczenie v(j) -> j czyli drugi uk³ad, zwi¹zany z C2
    v = [0,-1;1,0]*inv(R(C2.kat))*d; %???????????????????????????
    v = v/norm(v);
    F = @(t)[C1.kat-C2.kat;v]; %??????????????????????????????????
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',F,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+2; %wiêz odbiera dwa stopnie swobody
end

%TYP MOCOWANIE - fiksuje punkt do pod³o¿a (odbiera ruch postêpowy, tylko
%obrót)
if strcmp(typ,'mocowanie')
    C1 = FindCzlon(ob1,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(punkt1,C1.lancuch); %pobiera strukturê punktu (punkt 1)
    F = @(t)C1.srodek.q+R(C1.kat)*P1.q; %funkcja opisuj¹ca wspó³rzêdn¹ punktu
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',F,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+2; %wiêz odbiera dwa stopnie swobody
end
%TYP OBROT - wiêz kieruj¹cy obrotem
if strcmp(typ,'obrot')  
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',funkcja,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+1; %wiêz odbiera dwa stopnie swobody
end
%TYP PRZEMIESZCZENIE --- ???????????????????????????????????????
if strcmp(typ,'przemieszczenie')
    C1 = FindCzlon(ob1,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(punkt1,C1.lancuch); %pobiera strukturê punktu (punkt 1)
    C2 = FindCzlon(ob2,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 2)
    P2 = FindPoint(punkt2,C2.lancuch);%pobiera strukturê punktu (punkt 2)
    d = C1.srodek.q+R(C1.kat)*P1.q-C2.srodek.q-R(C2.kat)*P2.q; %d - odleglosc miedzy punktami 1 i 2
    %wyznaczenie v(j) -> j czyli drugi uk³ad, zwi¹zany z C2
    u = inv(R(C2.kat))*d; %??????????????????????????????????????
    u = u/norm(u); %u - wersor na kierunku miêdzy punktami 1 i 2
    F = @(t)[funkcja(t);u]; 
    wiez = struct('typ',typ,'OA',ob1,'PA',punkt1,'OB',ob2,'PB',punkt2,'fun',F,'id',n,'funid',funid);
    mechanizm.wiezyilosc = mechanizm.wiezyilosc+1; %wiêz odbiera jeden stopieñ swobody
end

%dodanie wiêzu do struktury mechanizm
mechanizm.wiezy(i,1) = wiez;
