function [monitory,dokladnosc,m] = ADAMS(mechanizm,czas_koncowy,krok,alpha,beta)
%ADAMS Funkcja rozwi�zuje zadanie proste dynamiki na po�o�enia, pr�dko�ci i przyspieszenia 
%ARGUMENTY FUNKCJI:
%mechanizm      --- struktura mechanizmu
%czas_koncowy   --- czas koncowy ruchu
%krok           --- d�ugo�� kroku czasowego
%alpha,beta     --- wsp�czynniki stabilizacji metod� Baumgarte'a

m = mechanizm;
%dodawanie monitor�w 
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
dokladnosc = zeros(length(0:krok:czas_koncowy),4);
it = 1;
m.pred = zeros(3*length(mechanizm.czlony),1); %wektor pocz�tkowy pr�dko�ci
m.przysp = zeros(3*length(mechanizm.czlony),1); %wektor pocz�tkowy przyspiesze�
for i=0:krok:czas_koncowy
   M=GenMasowa(m); %generowanie macierzy masowej
   J=GenJakobi(m,0); %generowanie macierzy Jakobiego
   wiez=GenRownanieWiezow(m,0); %generowanie wektora wi�z�w 
   Macierz=[M,J';J,zeros(size(J,1))]; %generowanie macierzy do rozwi�zania uk�adu dynamiki
   Q=GenerujSile(m); %generowanie wektora si� uog�lnionych
   Gamma=GenGamma(m,0); %generowanie wektora Gamma
   Gamma=Gamma-2*alpha*J*m.pred-(beta^2)*wiez; %stabilizacja wi�z�w - metoda Baumgarte'a
   Wektor=[Q;Gamma]; %wektor prawych stron uk�adu dynamiki
   wynik=Macierz\Wektor; %rozwi�zanie uk�adu dynamiki
   m.wynik=wynik; %wpisanie macierzy wynik do struktury mechanizmu
   dokladnosc(it,:)= [it*krok (sqrt(wiez'*wiez)) sqrt((J*m.pred)'*(J*m.pred)) sqrt((J*m.przysp-Gamma)'*(J*m.przysp-Gamma)) ]; %warto�ci dok�adno�ci spe�nienia r�wna� wi�z�w
   q = QzMechanizmu(m); %pobieranie wektora po�o�e� ze struktury mechanizmu
  
   %ca�kowanie algorytm Rungego-Kutty
   Y=[q;m.pred];
   [t,Y]=ode45(@(t,Y) H(t,Y,m),[it*krok (it+1)*krok],Y);
   n=size(Y,1); 
   Y = Y(n,:)'; %pobieranie wyniku dla czasu i+1
   
   m.przysp=wynik(1:(3*length(m.czlony)),1); %pobieranie wektora przyspiesze� z wyniku ca�kowania
   q=Y(1:(3*length(m.czlony)),1); %zmiana po�o�enia do i+1 kroku
   m.pred=Y((3*length(m.czlony)+1):(6*length(m.czlony)),1); %zmiana pr�dko�ci do i+1 kroku
   
   %SCHEMAT JAWNY EULERA
%    q = q + m.pred * krok + 0.5*m.przysp*krok*krok; %zmiana po�o�enia do i+1 kroku
%    m.pred=m.pred+m.przysp*krok; %zmiana pr�dko�ci do i+1 kroku
   m = QdoMechanizmu(m,q); %zapisanie wektora po�o�e� w strukturze mechanizmu
  % if zbiega==0 || rzad~=m.wiezyilosc
  %     disp(rzad);
  %     break;
  % end
   clf;
   RysujMechanizm(m); %rysujemy mechanizm
    subplot(5,1,3); hold on;
    plot(dokladnosc([1:it],1),dokladnosc([1:it],2));%rysowanie wykresu dok�adno�ci po�o�enia
    plot(dokladnosc([1:it],1),dokladnosc([1:it],3));%rysowanie wykresu dok�adno�ci pred
    plot(dokladnosc([1:it],1),dokladnosc([1:it],4));%rysowanie wykresu dok�adno�ci przysp
    legend("X","V","A");
    ylabel("Dok�adno�� wi�z�w"); xlabel("Czas");xlim([0 czas_koncowy]);
   tablica(it,:) = GenWartoscMonitor(m,i); %pobieramy warto�ci do monitor�w
   
   it = it+1; %kolejna iteracja
   pause(krok/16);
end
monitory = tablica; %zwraca do tablicy monitor�w ostateczne warto�ci
end

