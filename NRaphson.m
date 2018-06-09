function [res,zbiega,rzad] = NRaphson(mechanizm,t)
%NRaphson Funkcja oblicza za pomoc¹ metody NewtonaRaphsona przemieszczenie
%mechanizmu
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%t          --- czas 
zbiega=1;
m = mechanizm; 
max_it = 50; %ograniczenie liczby iteracji
eps = 1e-9; %dok³adnoœæ wyniku - warunek STOP
J=zeros(m.wiezyilosc);
for i=1:max_it
   P = GenRownanieWiezow(m,t); %generowanie równañ wiêzów
   Q = QzMechanizmu(m); %pobieramy wspó³rzêdne cz³onów
   J = GenJakobi(m,t); %generowanie macierzy Jacobiego
   if norm(P)<eps %warunek STOP
       break;
   end
   dQ = J\P; 
   Q = Q - dQ; %nowe wspó³rzêdne punktów (wzór za metod¹ NR)
   m = QdoMechanizmu(m,Q); %aktualizacja wspó³rzêdnych cz³onów
end
rzad=rank(J);
if i == max_it %gdy brak zbie¿noœci przyjmuje pocz¹tkowy stan za dobry
   disp('Brak zbieznosci');
   zbiega=0;
   res = mechanizm;
   return;
end
res = m;
end

