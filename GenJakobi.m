function [jakobi] = GenJakobi(mechanizm,t)
%GenJakobi Funkcja zwracaj�ca macierz jakobiego dla mechanizmu (jego stan
%przechowywany jest w samej strukturze mechanizmu)
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%t          --- czas 

jakobi = zeros(mechanizm.wiezyilosc);%wielko�� macierzy zale�y od ilo�� r�wna� wi�z�w
for i=1:length(mechanizm.wiezy)
    jakobi = AddWartoscJakobi(jakobi,mechanizm,mechanizm.wiezy(i),t);
    %funkcja AddWartoscJacobi zwraca odpowiednie warto�ci do macierzy
    %Jacobiego
end
end

