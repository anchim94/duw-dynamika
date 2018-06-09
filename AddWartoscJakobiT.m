function [wynik] = AddWartoscJakobiT(wektor,mechanizm,wiez,t)
%AddWartoscJakobi Funkcja generuj�ca warto�� fragmentu wektora zr�niczkowanych lewych stron 
%r-na� wi�z�w dla danego wi�zu.
%ARGUMENTY FUNKCJI:
%wektor    --- wynikowy wektor r�niczkowania
%mechanizm  --- struktura mechanizm
%wiez       --- wiez dla kt�rego generowane jest r�wnanie
%t          --- czas

wynik = wektor; %wynikowa macierz przyjmuje warto�� pocz�tkow�

%TYP PRZEMIESZCZENIE
if strcmp(wiez.typ,'przemieszczenie')
    %dodawanie element�w wektora r�niczkowania przez t
    id=wiez.funid;%numer id funkcji kieruj�cej
    wynik(wiez.id+1,1) = - mechanizm.a(id) * mechanizm.om(id) * cos(mechanizm.om(id)*(t)+mechanizm.phi(id));
    return;
end
%TYP OBROT
if strcmp(wiez.typ,'obrot')
    %dodawanie element�w wektora r�niczkowania przez t
    wynik(wiez.id+1,1) = - mechanizm.f1(t);
    return;
end
end
