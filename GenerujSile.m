function [ Q ] = GenerujSile( mechanizm )
%GenerujSile Funkcja zwraca wektor si³ uogólnionych dzia³aj¹cych na
%mechanizm
%ARGUMENTY FUNKCJI:
%mechanizm      --- struktura mechanizmu

%wektor pocz¹tkowy - zerowe wartoœci
Q=zeros(3*length(mechanizm.czlony),1);
for i=1:length(mechanizm.czlony)
    Q=AddWartoscQ(Q,mechanizm,mechanizm.czlony(i),i);
    %uzupe³nianie wektora si³ uogólnionych
end

