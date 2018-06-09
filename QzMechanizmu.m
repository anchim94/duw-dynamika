function [q] = QzMechanizmu(mechanizm)
%QzMechanizmu Funkcja zwraca macierz wsp�rz�dnych x i y oraz k�tu obrotu
%wszystkich cz�on�w mechanizmu
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm

n = length(mechanizm.czlony);
q = zeros(3*n,1);
for i=1:n
    czl = mechanizm.czlony(i);
    q([3*czl.id+1 3*czl.id+2 3*czl.id+3],1) = [czl.srodek.q;czl.kat];
end
end

