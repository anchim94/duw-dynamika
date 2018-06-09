function [res,zbiega,rzad] = NRaphson(mechanizm,t)
%NRaphson Funkcja oblicza za pomoc� metody NewtonaRaphsona przemieszczenie
%mechanizmu
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%t          --- czas 
zbiega=1;
m = mechanizm; 
max_it = 50; %ograniczenie liczby iteracji
eps = 1e-9; %dok�adno�� wyniku - warunek STOP
J=zeros(m.wiezyilosc);
for i=1:max_it
   P = GenRownanieWiezow(m,t); %generowanie r�wna� wi�z�w
   Q = QzMechanizmu(m); %pobieramy wsp�rz�dne cz�on�w
   J = GenJakobi(m,t); %generowanie macierzy Jacobiego
   if norm(P)<eps %warunek STOP
       break;
   end
   dQ = J\P; 
   Q = Q - dQ; %nowe wsp�rz�dne punkt�w (wz�r za metod� NR)
   m = QdoMechanizmu(m,Q); %aktualizacja wsp�rz�dnych cz�on�w
end
rzad=rank(J);
if i == max_it %gdy brak zbie�no�ci przyjmuje pocz�tkowy stan za dobry
   disp('Brak zbieznosci');
   zbiega=0;
   res = mechanizm;
   return;
end
res = m;
end

