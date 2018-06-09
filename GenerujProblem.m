function [mechanizm] = GenerujProblem()
%GenerujProblem Funkcja generuj¹ca z danych wyjsciowych elementy do
%analizy w oparciu o ogólny rysunek problemu. Wykorzystuje ogólne podejœcie
%do rozwi¹zywania problemów 2D

%generowanie punktów mechanizmu przy pomocy funkcji GenPun(nazwa,x,y)
%tablica punkty przechowuje listê punktów mechanizmu
punkty = [GenPun('O',0.0,0.0);GenPun('H',0.4,-0.2);GenPun('N',0.1,-0.8);
GenPun('M',1.9,-1.4);GenPun('G',1.6,0.4);GenPun('D',2.2,-0.4);GenPun('C',2.5,-1.4);
GenPun('B',2.9,-1.1);GenPun('A',2.9,-1.9);GenPun('K',3.4,-1.9);
GenPun('c1',1.65,-0.85);GenPun('c2',2.15,-0.50);GenPun('c3',3.05,-1.60);
GenPun('c4',2.70,-1.25);GenPun('c5',0.55,-0.95);GenPun('c6',1.45,-1.25);
GenPun('c7',0.70,-0.05);GenPun('c8',1.30,0.25);GenPun('Q',1.0,0.1);
GenPun('W',1.0,-1.1)];

%generowanie cz³onów mechanizmu przy pomocy funkcji GenCzlon(nazwa,srodek,punkty,data,id)
%tablica czlony przechowuje listê punktów mechanizmu
mechanizm.czlony = [GenCzlon('CZL1','c1',165.0,110.0,0,['O','D','A','M'],punkty,0);
GenCzlon('CZL2','c2',30,8.4,0,['G','D','C'],punkty,1);GenCzlon('CZL3','c3',25,1.8,0,['A','B','K'],punkty,2);
GenCzlon('CZL4','c4',4.5,0.2,0,['B','C'],punkty,3);GenCzlon('CZL5','c5',8.0,0.7,0,['N','W'],punkty,4);
GenCzlon('CZL6','c6',8.0,0.7,0,['M','W'],punkty,5);GenCzlon('CZL7','c7',7.0,0.5,0,['H','Q'],punkty,6);
GenCzlon('CZL8','c8',7.0,0.5,0,['G','Q'],punkty,7)];

%generowanie si³ dzia³aj¹cych na cz³ony - (niegrawitacyjne)
mechanizm.sily=[GenSilyCzlonu('stala','CZL3',[1000*cos(285*pi/180);1000*sin(285*pi/180);0],'K','CZL3','K',[0;0]);
    GenSilyCzlonu('sprezyna','CZL7',[0;0;0],'c7','CZL8','c8',[3.5*10^5;2.0*10^3;norm(punkty(17).q-punkty(18).q)]);
    GenSilyCzlonu('sprezyna','CZL5',[0;0;0],'c5','CZL6','c6',[2.0*10^5;4.0*10^3;norm(punkty(15).q-punkty(16).q)])];
%mechanizm.sily=[GenSilyCzlonu('stala','CZL3',[1000*cos(285*pi/180);1000*sin(285*pi/180);0],'K','CZL3','K',[0;0])];

%definicja funkcji opisuj¹cych przemieszczenie si³owników
%f(t)=l+a*sin(om*t+phi)
%l = [-sqrt(1.8*1.8+0.6*0.6) -sqrt(1.2*1.2+0.6*0.6)]; 
% a = [-0.15 -0.3];
% om = [1.44*pi 1.23*pi];
% phi = [pi 0];
% %f1 = @(t) l(1)+a(1)*sin(om(1)*t+phi(1));
% %f2 = @(t) l(2)+a(2)*sin(om(2)*t+phi(2));
% %zapisywanie danych funkcji kieruj¹cej do struktury mechanizmu
% mechanizm.a = a;
% mechanizm.om = om;
% mechanizm.phi = phi;

%definiowanie równañ wiêzów przy pomocy funkcji DodajWiez(mechanizm,typ,ob1,punkt1,ob2,punkt2,funkcja)
mechanizm.wiezyilosc = 0;
mechanizm.liczbamonitorow = 0;

mechanizm = DodajWiez(mechanizm,'mocowanie','CZL1','O','','',@(t)0,0);
mechanizm = DodajWiez(mechanizm,'mocowanie','CZL5','N','','',@(t)0,0);
mechanizm = DodajWiez(mechanizm,'mocowanie','CZL7','H','','',@(t)0,0);
mechanizm = DodajWiez(mechanizm,'postepowa','CZL7','H','CZL8','G',@(t)0,0);
%mechanizm = DodajWiez(mechanizm,'przemieszczenie','CZL7','H','CZL8','G',f2,2);
mechanizm = DodajWiez(mechanizm,'postepowa','CZL5','N','CZL6','M',@(t)0,0);
%mechanizm = DodajWiez(mechanizm,'przemieszczenie','CZL5','N','CZL6','M',f1,1);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL8','G','CZL2','G',@(t)0,0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL2','D','CZL1','D',@(t)0,0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL2','C','CZL4','C',@(t)0,0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL4','B','CZL3','B',@(t)0,0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL3','A','CZL1','A',@(t)0,0);
mechanizm = DodajWiez(mechanizm,'obrotowa','CZL1','M','CZL6','M',@(t)0,0);
end

