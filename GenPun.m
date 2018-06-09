function [point] = GenPun(nazwa,x,y)
%GenPun Funkcja generuj¹ca strukturê opisuj¹c¹ punkt w dowolnym uk³adzie
%ARGUMENTY FUNKCJI:
%nazwa  --- nazwa punktu
%x      --- wspó³rzêdna x punktu
%y      --- wspó³rzêdna y punktu

%POLA STRUKTURY PUNKT:
%nazwa  --- przechowuje nazwê punktu
%q      --- przechowuje dwuelementow¹ tablicê wspó³rzêdnych x,y
point = struct('nazwa',nazwa,'q',[x;y]);
end

