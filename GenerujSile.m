function [ Q ] = GenerujSile( mechanizm )
%GenerujSile Funkcja zwraca wektor si� uog�lnionych dzia�aj�cych na
%mechanizm
%ARGUMENTY FUNKCJI:
%mechanizm      --- struktura mechanizmu

%wektor pocz�tkowy - zerowe warto�ci
Q=zeros(3*length(mechanizm.czlony),1);
for i=1:length(mechanizm.czlony)
    Q=AddWartoscQ(Q,mechanizm,mechanizm.czlony(i),i);
    %uzupe�nianie wektora si� uog�lnionych
end

