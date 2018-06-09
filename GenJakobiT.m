function [jakobit] = GenJakobiT(mechanizm,t)
%GenJakobiT Funkcja zwracaj�ca wektor r�niczkowania wi�z�w przez t dla mechanizmu (jego stan
%przechowywany jest w samej strukturze mechanizmu)
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%t          --- czas 

jakobit = zeros(mechanizm.wiezyilosc,1);%wielko�� wektora zale�y od ilo�ci r�wna� wi�z�w
for i=1:length(mechanizm.wiezy)
    jakobit = AddWartoscJakobiT(jakobit,mechanizm,mechanizm.wiezy(i),t);
    %funkcja AddWartoscJacobiT zwraca odpowiednie warto�ci do wektora
    %zr�niczkowanych lewych stron
end
end
