function [czlon] = FindCzlon(nazwa,zrodlo)
%FindCzlon Znajduje czlon w mechanizmie po nazwie
%ARGUMENTY FUNKCJI:
%nazwa     --- nazwa poszukiwanego czlonu
%zrodlo    --- tablica przechowuj¹ca czlony (Ÿród³owa)

for i =1:length(zrodlo)
    if strcmp(zrodlo(i).nazwa, nazwa)
        czlon = zrodlo(i); %po znalezieniu cz³ou funkcja zwraca cz³on
        return
    end
end
disp('Nie znaleziono poszukiwanego czlonu');
end

