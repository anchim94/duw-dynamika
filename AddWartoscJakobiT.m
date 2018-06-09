function [wynik] = AddWartoscJakobiT(wektor,mechanizm,wiez,t)
%AddWartoscJakobi Funkcja generuj¹ca wartoœæ fragmentu wektora zró¿niczkowanych lewych stron 
%r-nañ wiêzów dla danego wiêzu.
%ARGUMENTY FUNKCJI:
%wektor    --- wynikowy wektor ró¿niczkowania
%mechanizm  --- struktura mechanizm
%wiez       --- wiez dla którego generowane jest równanie
%t          --- czas

wynik = wektor; %wynikowa macierz przyjmuje wartoœæ pocz¹tkow¹

%TYP PRZEMIESZCZENIE
if strcmp(wiez.typ,'przemieszczenie')
    %dodawanie elementów wektora ró¿niczkowania przez t
    id=wiez.funid;%numer id funkcji kieruj¹cej
    wynik(wiez.id+1,1) = - mechanizm.a(id) * mechanizm.om(id) * cos(mechanizm.om(id)*(t)+mechanizm.phi(id));
    return;
end
%TYP OBROT
if strcmp(wiez.typ,'obrot')
    %dodawanie elementów wektora ró¿niczkowania przez t
    wynik(wiez.id+1,1) = - mechanizm.f1(t);
    return;
end
end
