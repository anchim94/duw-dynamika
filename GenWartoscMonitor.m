function [result] = GenWartoscMonitor(mechanizm,t)
%GenWartoscMonitor Zwraca nowy wiesz do tablicy do tablicowania wartosci
%monitor nadanych dla danych punktow ciala
%ARGUMENTY FUNKCJI:
%mechanizm      --- struktura mechanizmu
%t              --- czas

result = zeros(mechanizm.liczbamonitorow+1,1);
result(1) = t;
omega = [0,-1;1,0];

for i=1:mechanizm.liczbamonitorow
   monitor = mechanizm.monitory(i); %pobiera monitory ze struktury mechanizm
   C1 = FindCzlon(monitor.czlon,mechanizm.czlony); %pobiera cz�on monitoru
   P1 = FindPoint(monitor.punkt,C1.lancuch); %pobiera punkt monitoru
   %TYP 'X' - pobiera wsp�rz�dn� X punktu
   if strcmp(monitor.typ,'X')
        r = (C1.srodek.q + R(C1.kat)*P1.q);
        result(i+1) = r(1);
   end
   %TYP 'Y' - pobiera wsp�rz�dn� Y punktu
   if strcmp(monitor.typ,'Y')
       r = (C1.srodek.q + R(C1.kat)*P1.q);
        result(i+1) = r(2);
   end
     %TYP 'VX' - pobiera pr�dko�� punktu na kierunku X 
   if strcmp(monitor.typ,'VX')
       r = mechanizm.pred([3*C1.id+1 3*C1.id+2],1)+omega*R(C1.kat)*P1.q*mechanizm.pred(3*C1.id+3,1);
        result(i+1) = r(1);
   end
      %TYP 'VY' - pobiera pr�dko�� punktu na kierunku Y 
   if strcmp(monitor.typ,'VY')
      r = mechanizm.pred([3*C1.id+1 3*C1.id+2],1)+omega*R(C1.kat)*P1.q*mechanizm.pred(3*C1.id+3,1);
        result(i+1) = r(2);
   end
      %TYP 'AX' - pobiera przyspieszenie punktu na kierunku X 
   if strcmp(monitor.typ,'AX')
       r = mechanizm.przysp([3*C1.id+1 3*C1.id+2],1)-R(C1.kat)*P1.q*(mechanizm.pred(3*C1.id+3,1))^2+...
       omega*R(C1.kat)*P1.q*mechanizm.przysp(3*C1.id+3,1);
        result(i+1) = r(1);
   end
         %TYP 'AY' - pobiera przyspieszenie punktu na kierunku Y 
   if strcmp(monitor.typ,'AY')
       r = mechanizm.przysp([3*C1.id+1 3*C1.id+2],1)-R(C1.kat)*P1.q*(mechanizm.pred(3*C1.id+3,1))^2+...
       omega*R(C1.kat)*P1.q*mechanizm.przysp(3*C1.id+3,1);
        result(i+1) = r(2);
   end
            %TYP 'PHI' - pobiera k�t po�o�enia cz�onu
   if strcmp(monitor.typ,'PHI')
        result(i+1) = C1.kat;
   end
         %TYP 'PHI1' - pobiera pr�dko�� k�tow� cz�onu
   if strcmp(monitor.typ,'PHI1')
        result(i+1) = mechanizm.pred(3*C1.id+3,1);
   end
         %TYP 'PHI2' - pobiera przyspieszenie k�towe cz�onu
   if strcmp(monitor.typ,'PHI2')
        result(i+1) = mechanizm.przysp(3*C1.id+3,1);
   end
end
result = result';
end

