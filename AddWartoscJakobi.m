function [wynik] = AddWartoscJakobi(macierz,mechanizm,wiez,t)
%AddWartoscJakobi Funkcja generuj�ca warto�� fragmentu macierzy Jakobiego dla danego wi�zu.
%ARGUMENTY FUNKCJI:
%macierz    --- wynikowa macierz Jacobiego
%mechanizm  --- struktura mechanizm
%wiez       --- wiez dla kt�rego generowane jest r�wnanie
%t          --- czas

wynik = macierz; %wynikowa macierz przyjmuje warto�� pocz�tkow�
omega = [0,-1;1,0]; %macierz r�niczkowania omega

%TYP OBROTOWA
if strcmp(wiez.typ, 'obrotowa')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony); %pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera struktur� punktu (punkt 1)
    C2 = FindCzlon(wiez.OB,mechanizm.czlony); %pobiera struktur� cz�onu (obiekt 2)
    P2 = FindPoint(wiez.PB,C2.lancuch); %pobiera struktur� punktu (punkt 2)
    
    %dodawanie element�w macierzy Jacobiego
    wynik([wiez.id+1 wiez.id+2],[C1.id*3+1 C1.id*3+2]) = eye(2);
    wynik([wiez.id+1 wiez.id+2],C1.id*3+3) = omega*R(C1.kat)*P1.q; 
    wynik([wiez.id+1 wiez.id+2],[C2.id*3+1 C2.id*3+2]) = -eye(2);
    wynik([wiez.id+1 wiez.id+2],C2.id*3+3) = -omega*R(C2.kat)*P2.q;
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
    
    %dodawanie element�w macierzy Jacobiego
    wynik(wiez.id+2,[C1.id*3+1 C1.id*3+2]) = -(R(C2.kat)*v)';
    wynik(wiez.id+2,C1.id*3+3) = -(R(C2.kat)*v)'*omega*R(C1.kat)*P1.q;
    
    wynik(wiez.id+2,[C2.id*3+1 C2.id*3+2]) = (R(C2.kat)*v)';
    wynik(wiez.id+2,C2.id*3+3) = -(R(C2.kat)*v)'*omega*(C2.srodek.q-C1.srodek.q - R(C1.kat)*P1.q);
    
    wynik(wiez.id+1,[C1.id*3+3 C2.id*3+3]) = [1, -1];
    return;
end

%TYP MOCOWANIE
if strcmp(wiez.typ, 'mocowanie')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera struktur� punktu (punkt 1)
    
    %dodawanie element�w macierzy Jacobiego
    wynik([wiez.id+1 wiez.id+2],[C1.id*3+1 C1.id*3+2]) = eye(2);
    wynik([wiez.id+1 wiez.id+2],C1.id*3+3) = omega*R(C1.kat)*P1.q;
    return;
end
%TYP OBROT
if strcmp(wiez.typ, 'obrot')
    C1 = FindCzlon(wiez.OA,mechanizm.czlony);%pobiera struktur� cz�onu (obiekt 1)
    P1 = FindPoint(wiez.PA,C1.lancuch);%pobiera struktur� punktu (punkt 1)
    
    %dodawanie element�w macierzy Jacobiego
    wynik(wiez.id+1,C1.id*3+3) = 1;
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
    
    %dodawanie element�w macierzy Jacobiego
    wynik(wiez.id+1,[C1.id*3+1 C1.id*3+2]) = -(R(C2.kat)*u)';
    wynik(wiez.id+1,C1.id*3+3) = -(R(C2.kat)*u)'*omega*R(C1.kat)*P1.q;
    
    wynik(wiez.id+1,[C2.id*3+1 C2.id*3+2]) = (R(C2.kat)*u)';
    wynik(wiez.id+1,C2.id*3+3) = -(R(C2.kat)*u)'*omega*(C2.srodek.q-C1.srodek.q - R(C1.kat)*P1.q);
    return;
end
disp('Nieznany rodzaj wiezow');
end

