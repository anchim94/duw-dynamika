function [mechanizm] = QdoMechanizmu(mechanizm,q)
%QdoMechanizmu Funkcja nadaje nowe wspó³rzêdne cz³onom mechanizmu
%(aktualizacja struktury)
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizmu
%q          --- wektor wspó³rzêdnych cz³onów (x,y,k¹t)

n = length(mechanizm.czlony);
%dla ka¿dego cz³onu przyspisuje nowe wspó³rzêdne œrodka i k¹t obrotu
for i=1:n
    czl = mechanizm.czlony(i);
    czl.srodek.q = q([3*czl.id+1 3*czl.id+2],1);
    czl.kat = q(3*czl.id+3,1);
    mechanizm.czlony(i) = czl;
end
end


