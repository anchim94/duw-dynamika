function [gamma] = GenGamma(mechanizm,t)
%GenFamma Funkcja zwracaj¹ca wektor ró¿niczkowania x2 wiêzów przez t dla mechanizmu (jego stan
%przechowywany jest w samej strukturze mechanizmu)
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%t          --- czas 

gamma = zeros(mechanizm.wiezyilosc,1);%wielkoœæ wektora zale¿y od iloœci równañ wiêzów
for i=1:length(mechanizm.wiezy)
    gamma = AddWartoscGamma(gamma,mechanizm,mechanizm.wiezy(i),t);
    %funkcja AddWartoscGamma zwraca odpowiednie wartoœci do macierzy
    %Jacobiego
end
end
