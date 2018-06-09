function [wynik] = AddWartoscGamma(wektor,mechanizm,wiez,t)
%AddWartoscGamma Funkcja generuj¹ca wartoœæ fragmentu wektora ró¿niczkowaniax2 dla danego wiêzu.
%ARGUMENTY FUNKCJI:
%wektor    --- wynikowy wektor ró¿niczkowania
%mechanizm  --- struktura mechanizm
%wiez       --- wiez dla którego generowane jest równanie
%t          --- czas

wynik = wektor; %wynikowa macierz przyjmuje wartoœæ pocz¹tkow¹
omega = [0,-1;1,0]; %macierz ró¿niczkowania omega
pr = mechanizm.pred;

%TYP OBROTOWA
if strcmp(wiez.typ, 'obrotowa')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera strukturê punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony); %pobiera strukturê cz³onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch); %pobiera strukturê punktu (punkt 2)
    
    %dodawanie elementów wektora gamma
    wynik([wiez.id+1 wiez.id+2],1) = R(C1.kat)*P1.q*pr(3*C1.id+3)^2 - R(C2.kat)*P2.q*pr(3*C2.id+3)^2;
    return;
end

%TYP POSTÊPOWA
if strcmp(wiez.typ, 'postepowa')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera strukturê punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch);%pobiera strukturê punktu (punkt 2)
    f = wiez.fun(t);
    v = f(2:3,1); %wektor prostopadly do ruchu postêpowego
    
    %dodawanie elementów wektora Gamma
    pr([(3*C2.id)+1 (3*C2.id)+2 (3*C2.id)+3])=[0 0 0];
    wynik(wiez.id+2,1) = (R(C2.kat)*v)'*(2*omega*(pr([(3*C2.id)+1 (3*C2.id)+2])-pr([(3*C1.id)+1 (3*C1.id)+2]))*pr((3*C2.id)+3)+...
    (C2.srodek.q-C1.srodek.q)*(pr((3*C2.id)+3))^2 - R(C1.kat)*P1.q*(pr((3*C2.id)+3)-pr((3*C1.id)+3))^2);

    wynik(wiez.id+1,1) = 0;
    return;
end

%TYP MOCOWANIE
if strcmp(wiez.typ, 'mocowanie')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera strukturê punktu (punkt 1)
    
    %dodawanie elementów macierzy Jacobiego
    wynik([wiez.id+1 wiez.id+2],1) = R(C1.kat)*P1.q*pr(3*C1.id+3)^2;
    return;
end

%TYP OBROT
if strcmp(wiez.typ, 'obrot')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera strukturê punktu (punkt 1)
    
    %dodawanie elementów macierzy Jacobiego
    wynik(wiez.id+1,1) = -mechanizm.f2(t);
    return;
end

%TYP PRZEMIESZCZENIE
if strcmp(wiez.typ,'przemieszczenie')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera strukturê punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony);%pobiera strukturê cz³onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch);%pobiera strukturê punktu (punkt 2)
    f = wiez.fun(t);
    u = f(2:3,1); %wektor prostopadly do ruchu postêpowego
    
     %dodawanie elementów wektora ró¿niczkowania przez t
    id=wiez.funid;%numer id funkcji kieruj¹cej
    wynik(wiez.id+1,1) = (R(C2.kat)*u)'*(2*omega*(pr([(3*C2.id)+1 (3*C2.id)+2])-pr([(3*C1.id)+1 (3*C1.id)+2]))*pr((3*C2.id)+3)+...
    (C2.srodek.q-C1.srodek.q)*(pr(3*C2.id+3))^2 - R(C1.kat)*P1.q*(pr(3*C2.id+3)-pr(3*C1.id+3))^2)-mechanizm.a(id) * (mechanizm.om(id))^2 * sin(mechanizm.om(id)*(t)+mechanizm.phi(id));
    return;
end
disp('Nieznany rodzaj wiezow');
end