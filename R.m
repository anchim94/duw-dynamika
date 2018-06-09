function [M]= R(kat)
%R Generuje macierz obrotu
%ARGUMENTY FUNKCJI:
%kat    --- k¹t obrotu
M = [cos(kat),-sin(kat);sin(kat),cos(kat)];
end

