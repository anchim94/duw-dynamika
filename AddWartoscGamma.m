function [wynik] = AddWartoscGamma(wektor,mechanizm,wiez,t)
%AddWartoscGamma Funkcja generuj�ca warto�� fragmentu wektora r�niczkowaniax2 dla danego wi�zu.
%ARGUMENTY FUNKCJI:
%wektor    --- wynikowy wektor r�niczkowania
%mechanizm  --- struktura mechanizm
%wiez       --- wiez dla kt�rego generowane jest r�wnanie
%t          --- czas

wynik = wektor; %wynikowa macierz przyjmuje warto�� pocz�tkow�
omega = [0,-1;1,0]; %macierz r�niczkowania omega
pr = mechanizm.pred;

%TYP OBROTOWA
if strcmp(wiez.typ, 'obrotowa')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony); %pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera struktur� punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony); %pobiera struktur� cz�onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch); %pobiera struktur� punktu (punkt 2)
    
    %dodawanie element�w wektora gamma
    wynik([wiez.id+1 wiez.id+2],1) = R(C1.kat)*P1.q*pr(3*C1.id+3)^2 - R(C2.kat)*P2.q*pr(3*C2.id+3)^2;
    return;
end

%TYP POST�POWA
if strcmp(wiez.typ, 'postepowa')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera struktur� punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch);%pobiera struktur� punktu (punkt 2)
    f = wiez.fun(t);
    v = f(2:3,1); %wektor prostopadly do ruchu post�powego
    
    %dodawanie element�w wektora Gamma
    pr([(3*C2.id)+1 (3*C2.id)+2 (3*C2.id)+3])=[0 0 0];
    wynik(wiez.id+2,1) = (R(C2.kat)*v)'*(2*omega*(pr([(3*C2.id)+1 (3*C2.id)+2])-pr([(3*C1.id)+1 (3*C1.id)+2]))*pr((3*C2.id)+3)+...
    (C2.srodek.q-C1.srodek.q)*(pr((3*C2.id)+3))^2 - R(C1.kat)*P1.q*(pr((3*C2.id)+3)-pr((3*C1.id)+3))^2);

    wynik(wiez.id+1,1) = 0;
    return;
end

%TYP MOCOWANIE
if strcmp(wiez.typ, 'mocowanie')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera struktur� punktu (punkt 1)
    
    %dodawanie element�w macierzy Jacobiego
    wynik([wiez.id+1 wiez.id+2],1) = R(C1.kat)*P1.q*pr(3*C1.id+3)^2;
    return;
end

%TYP OBROT
if strcmp(wiez.typ, 'obrot')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera struktur� punktu (punkt 1)
    
    %dodawanie element�w macierzy Jacobiego
    wynik(wiez.id+1,1) = -mechanizm.f2(t);
    return;
end

%TYP PRZEMIESZCZENIE
if strcmp(wiez.typ,'przemieszczenie')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera struktur� punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch);%pobiera struktur� punktu (punkt 2)
    f = wiez.fun(t);
    u = f(2:3,1); %wektor prostopadly do ruchu post�powego
    
     %dodawanie element�w wektora r�niczkowania przez t
    id=wiez.funid;%numer id funkcji kieruj�cej
    wynik(wiez.id+1,1) = (R(C2.kat)*u)'*(2*omega*(pr([(3*C2.id)+1 (3*C2.id)+2])-pr([(3*C1.id)+1 (3*C1.id)+2]))*pr((3*C2.id)+3)+...
    (C2.srodek.q-C1.srodek.q)*(pr(3*C2.id+3))^2 - R(C1.kat)*P1.q*(pr(3*C2.id+3)-pr(3*C1.id+3))^2)-mechanizm.a(id) * (mechanizm.om(id))^2 * sin(mechanizm.om(id)*(t)+mechanizm.phi(id));
    return;
end
disp('Nieznany rodzaj wiezow');
end