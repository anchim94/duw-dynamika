function [gamma] = GenGamma(mechanizm,t)
%GenFamma Funkcja zwracaj�ca wektor r�niczkowania x2 wi�z�w przez t dla mechanizmu (jego stan
%przechowywany jest w samej strukturze mechanizmu)
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%t          --- czas 

gamma = zeros(mechanizm.wiezyilosc,1);%wielko�� wektora zale�y od ilo�ci r�wna� wi�z�w
for i=1:length(mechanizm.wiezy)
    gamma = AddWartoscGamma(gamma,mechanizm,mechanizm.wiezy(i),t);
    %funkcja AddWartoscGamma zwraca odpowiednie warto�ci do macierzy
    %Jacobiego
end
end
