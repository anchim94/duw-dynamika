function [point] = GenPun(nazwa,x,y)
%GenPun Funkcja generuj�ca struktur� opisuj�c� punkt w dowolnym uk�adzie
%ARGUMENTY FUNKCJI:
%nazwa  --- nazwa punktu
%x      --- wsp�rz�dna x punktu
%y      --- wsp�rz�dna y punktu

%POLA STRUKTURY PUNKT:
%nazwa  --- przechowuje nazw� punktu
%q      --- przechowuje dwuelementow� tablic� wsp�rz�dnych x,y
point = struct('nazwa',nazwa,'q',[x;y]);
end

