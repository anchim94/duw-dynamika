function [mech] = DodajMonitor(mechanizm,typ,czlon,punkt)
%DodajMonitor Funkcja dodaje monitor punktu - �ledz�cy jego po�o�enie,
%pr�dko�� lub przyspieszenie
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%typ        --- typ monitoru ('X','Y')
%czlon      --- nazwa cz�onu �ledzonego
%punkt      --- nazwa punktu �ledzonego

%POLA STRUKTURY MONITOR:
%typ        --- typ monitoru ('X','Y')
%czlon      --- nazwa cz�onu �ledzonego
%punkt      --- nazwa punktu �ledzonego

%struktura mechanizmu
mech = mechanizm;
monitor = struct('typ',typ,'czlon',czlon,'punkt',punkt);

%licznik monitor�w i dopisywanie monitor�w do struktury mechanizm:
if(mech.liczbamonitorow ==0)
   	mech.monitory(1) = monitor;
else
    mech.monitory(mech.liczbamonitorow+1) = monitor;
end
mech.liczbamonitorow = mech.liczbamonitorow+1;
end

