function [q] = QzMechanizmu(mechanizm)
%QzMechanizmu Funkcja zwraca macierz wspó³rzêdnych x i y oraz k¹tu obrotu
%wszystkich cz³onów mechanizmu
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm

n = length(mechanizm.czlony);
q = zeros(3*n,1);
for i=1:n
    czl = mechanizm.czlony(i);
    q([3*czl.id+1 3*czl.id+2 3*czl.id+3],1) = [czl.srodek.q;czl.kat];
end
end

