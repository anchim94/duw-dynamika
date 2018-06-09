function [ M ] = GenMasowa( mechanizm )
%GenMasowa Funkcja zwraca macierz masow¹ ca³ego uk³adu
%ARGUMENTY FUNKCJI:
%mechanizm       --- struktura mechanizmu

M=zeros(3*length(mechanizm.czlony),3*length(mechanizm.czlony));

for i=1:length(mechanizm.czlony)
    M([3*i-2,3*i-1,3*i],[3*i-2,3*i-1,3*i])=mechanizm.czlony(i).M;
end

