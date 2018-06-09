function [jakobi] = GenJakobi(mechanizm,t)
%GenJakobi Funkcja zwracaj¹ca macierz jakobiego dla mechanizmu (jego stan
%przechowywany jest w samej strukturze mechanizmu)
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%t          --- czas 

jakobi = zeros(mechanizm.wiezyilosc);%wielkoœæ macierzy zale¿y od iloœæ równañ wiêzów
for i=1:length(mechanizm.wiezy)
    jakobi = AddWartoscJakobi(jakobi,mechanizm,mechanizm.wiezy(i),t);
    %funkcja AddWartoscJacobi zwraca odpowiednie wartoœci do macierzy
    %Jacobiego
end
end

