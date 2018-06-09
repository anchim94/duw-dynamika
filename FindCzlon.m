function [czlon] = FindCzlon(nazwa,zrodlo)
%FindCzlon Znajduje czlon w mechanizmie po nazwie
%ARGUMENTY FUNKCJI:
%nazwa     --- nazwa poszukiwanego czlonu
%zrodlo    --- tablica przechowuj�ca czlony (�r�d�owa)

for i =1:length(zrodlo)
    if strcmp(zrodlo(i).nazwa, nazwa)
        czlon = zrodlo(i); %po znalezieniu cz�ou funkcja zwraca cz�on
        return
    end
end
disp('Nie znaleziono poszukiwanego czlonu');
end

