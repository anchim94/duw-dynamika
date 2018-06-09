function [result] = AddWartoscWiezu(wektor,mechanizm,wiez,t)
%WartoscWiezu Oblicza wartosc wiezu, do rozwiazywania ukladu rownan za
%pomoca Newtona-Rapsona,
%ARGUMENTY FUNKCJI:
%wektor     --- wynikowy wektor równañ wiêzów
%mechanizm  --- struktura mechanizm
%wiez       --- wiez dla którego generowane jest równanie
%t          --- czas

result = wektor; %wynikowy wektor przyjmuje wartoœæ pocz¹tkow¹

%TYP OBROTOWA
if strcmp(wiez.typ, 'obrotowa')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch); %pobiera strukturê punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch);%pobiera strukturê punktu (punkt 2)
    %ZWRACA ODLEG£OŒÆ PUNKTÓW CZ£ONU OD SIEBIE
    result([wiez.id+1 wiez.id+2],1) = C1.srodek.q+R(C1.kat)*P1.q-C2.srodek.q-R(C2.kat)*P2.q;
    return;
end
%TYP POSTÊPOWA
if strcmp(wiez.typ, 'postepowa')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch); %pobiera strukturê punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch); %pobiera strukturê punktu (punkt 2)
    f = wiez.fun(t); 
    v = f(2:3,1); %wektor prostopadly ???
    result(wiez.id+2,1) = (R(C2.kat)*v)'*(C2.srodek.q-C1.srodek.q - R(C1.kat)*P1.q)+v'*P2.q; 
    result(wiez.id+1,1) = C1.kat - C2.kat - f(1); %f(1) - pocz¹tkowy k¹t miêdzy uk³adami lokalnymi cz³onów
    return;
end
%TYP MOCOWANIE
if strcmp(wiez.typ, 'mocowanie')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch); %pobiera strukturê punktu (punkt 1)
    prev = wiez.fun(t); 
    result([wiez.id+1 wiez.id+2],1) = C1.srodek.q+R(C1.kat)*P1.q - prev;
    return;
end
%TYP OBROT
if strcmp(wiez.typ, 'obrot')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch); %pobiera strukturê punktu (punkt 1)
    prev = wiez.fun(t); 
    result(wiez.id+1,1) = C1.kat - prev;
    return;
end
%TYP PRZEMIESZCZENIE
if strcmp(wiez.typ,'przemieszczenie')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);
    P1 = FindPoint(wiez.PA,C1.lancuch);
    C2 = FindCzlon(wiez.OB,mechanizm.czlony);
    P2 = FindPoint(wiez.PB,C2.lancuch);
    f = wiez.fun(t);
    u = f(2:3,1);
    result(wiez.id+1,1) = (R(C2.kat)*u)'*(C2.srodek.q+R(C2.kat)*P2.q-C1.srodek.q-R(C1.kat)*P1.q)-f(1);
    %f(1) - funkcja opisuj¹ca odleglosc miêdzy punktami wiezu (dana)
    return;
end
disp('Nieznany rodzaj wiezow');
end

