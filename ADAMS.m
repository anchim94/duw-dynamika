function [monitory,m] = ADAMS(mechanizm,czas_koncowy,krok)
%ADAMS Funkcja rozwi¹zuje zadanie na po³o¿enia, prêdkoœci i przyspieszenia
%ARGUMENTY FUNKCJI:
%mechanizm      --- struktura mechanizmu
%czas_koncowy   --- czas koncowy ruchu
%krok           --- d³ugoœæ kroku czasowego

m = mechanizm;
%dodawanie monitorów 
m = DodajMonitor(m,'X','CZL2','C'); 
m = DodajMonitor(m,'Y','CZL2','C');
m = DodajMonitor(m,'VX','CZL2','C'); 
m = DodajMonitor(m,'VY','CZL2','C');
m = DodajMonitor(m,'AX','CZL2','C'); 
m = DodajMonitor(m,'AY','CZL2','C');
m = DodajMonitor(m,'X','CZL2','D'); 
m = DodajMonitor(m,'Y','CZL2','D');
m = DodajMonitor(m,'VX','CZL2','D'); 
m = DodajMonitor(m,'VY','CZL2','D');
m = DodajMonitor(m,'AX','CZL2','D'); 
m = DodajMonitor(m,'AY','CZL2','D');
m = DodajMonitor(m,'X','CZL3','K'); 
m = DodajMonitor(m,'Y','CZL3','K');
m = DodajMonitor(m,'VX','CZL3','K'); 
m = DodajMonitor(m,'VY','CZL3','K');
m = DodajMonitor(m,'AX','CZL3','K'); 
m = DodajMonitor(m,'AY','CZL3','K');
RysujMechanizm(m);
xlim([-1 4])
ylim([-4 2])
tablica = zeros(length(0:krok:czas_koncowy),m.liczbamonitorow+1);
it = 1;
m.pred = zeros(3*length(mechanizm.czlony),1);
m.przysp = zeros(3*length(mechanizm.czlony),1);
for i=0:krok:czas_koncowy
   M=GenMasowa(m);
   J=GenJakobi(m,0);
   wiez=GenRownanieWiezow(m,0);
   disp(sqrt(wiez'*wiez));
   Macierz=[M,J';J,zeros(size(J,1))];
   Q=GenerujSile(m);
   Gamma=GenGamma(m,0);
   Gamma=Gamma-2*7*J*m.pred-((8)^2)*wiez;
   Wektor=[Q;Gamma];
   wynik=Macierz\Wektor;
   q = QzMechanizmu(m);
   m.przysp=wynik(1:3*length(m.czlony),1);
   q = q + m.pred * krok + 0.5*m.przysp*krok*krok;
   m.pred=m.pred+m.przysp*krok;
   m = QdoMechanizmu(m,q);
  % if zbiega==0 || rzad~=m.wiezyilosc
  %     disp(rzad);
  %     break;
  % end
   clf;
   RysujMechanizm(m); %rysujemy mechanizm
   tablica(it,:) = GenWartoscMonitor(m,i); %pobieramy wartoœci do monitorów
   it = it+1; %kolejna iteracja
   pause(krok);
end
monitory = tablica; %zwraca do tablicy monitorów ostateczne wartoœci
end

