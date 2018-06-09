function [result] = GenRownanieWiezow(mechanizm,t)
%GenRownanieWiezow Funkcja zwracaj�ca r�wno�� wi�z�w nadanych na uk�adzie
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%t          --- czas 
%n = length(mechanizm.czlony);
%result = zeros(3*n,1);
result = zeros(mechanizm.wiezyilosc,1);
for i=1:length(mechanizm.wiezy)
    result = AddWartoscWiezu(result,mechanizm,mechanizm.wiezy(i),t);
    %funkcja AddWartoscWiezu zwraca odpowiednie warto�ci wi�z�w
end
end