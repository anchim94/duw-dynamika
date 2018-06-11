function [dY] = H(t,Y,mechanizm)
%H Funkcja zwracaj�ca wektor dY - do ca�kowania ode45

dq=Y((3*length(mechanizm.czlony)+1):6*length(mechanizm.czlony),:);

dY(1:(3*length(mechanizm.czlony)),:)=dq;
dY((3*length(mechanizm.czlony)+1):6*length(mechanizm.czlony))=mechanizm.wynik(1:3*length(mechanizm.czlony),:);

end

