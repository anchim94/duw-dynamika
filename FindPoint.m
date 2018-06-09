function [point] = FindPoint(nazwa,zrodlo)
%FindPoint Wyszukuje wsrod tablicy punktow punktu o podanej nazwie
%ARGUMENTY FUNKCJI:
%nazwa     --- nazwa poszukiwanego punktu
%zrodlo    --- tablica przechowuj¹ca punkty (Ÿród³owa)

for i =1:length(zrodlo)
    if strcmp(zrodlo(i).nazwa,nazwa)
        point = zrodlo(i); %po znalezieniu punktu funkcja zwraca punkt
        return
    end
end
disp('Nie znaleziono poszukiwanego punktu');
end

