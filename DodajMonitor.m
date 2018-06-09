function [mech] = DodajMonitor(mechanizm,typ,czlon,punkt)
%DodajMonitor Funkcja dodaje monitor punktu - œledz¹cy jego po³o¿enie
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizm
%typ        --- typ monitoru ('X','Y')
%czlon      --- nazwa cz³onu œledzonego
%punkt      --- nazwa punktu œledzonego

%POLA STRUKTURY MONITOR:
%typ        --- typ monitoru ('X','Y')
%czlon      --- nazwa cz³onu œledzonego
%punkt      --- nazwa punktu œledzonego

%struktura mechanizmu
mech = mechanizm;
monitor = struct('typ',typ,'czlon',czlon,'punkt',punkt);

%licznik monitorów i dopisywanie monitorów do struktury mechanizm:
if(mech.liczbamonitorow ==0)
   	mech.monitory(1) = monitor;
else
    mech.monitory(mech.liczbamonitorow+1) = monitor;
end
mech.liczbamonitorow = mech.liczbamonitorow+1;
end

