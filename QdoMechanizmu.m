function [mechanizm] = QdoMechanizmu(mechanizm,q)
%QdoMechanizmu Funkcja nadaje nowe wsp�rz�dne cz�onom mechanizmu
%(aktualizacja struktury)
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizmu
%q          --- wektor wsp�rz�dnych cz�on�w (x,y,k�t)

n = length(mechanizm.czlony);
%dla ka�dego cz�onu przyspisuje nowe wsp�rz�dne �rodka i k�t obrotu
for i=1:n
    czl = mechanizm.czlony(i);
    czl.srodek.q = q([3*czl.id+1 3*czl.id+2],1);
    czl.kat = q(3*czl.id+3,1);
    mechanizm.czlony(i) = czl;
end
end


