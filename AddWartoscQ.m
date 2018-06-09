function [ wynik ] = AddWartoscQ( wektor,mechanizm,czlon,num )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
wynik = wektor; %wynikowa macierz przyjmuje wartoœæ pocz¹tkow¹
g=[0;-9.81;0];
omega=[0,-1;1,0];

wynik([3*num-2,3*num-1,3*num])=wynik([3*num-2,3*num-1,3*num])+czlon.M*g;

for i=1:length(mechanizm.sily)
    if strcmp(czlon.nazwa,mechanizm.sily(i).czlon) || strcmp(czlon.nazwa,mechanizm.sily(i).czlon2)
        if strcmp(mechanizm.sily(i).typ,'stala')
            fi=czlon.kat;
            pkt=FindPoint(mechanizm.sily(i).punkt_przylozenia,czlon.lancuch);
            wynik([3*num-2,3*num-1,3*num])=wynik([3*num-2,3*num-1,3*num])+mechanizm.sily(i).wektor;
            wynik(3*num)=wynik(3*num)+(omega*R(fi)*pkt.q)'*mechanizm.sily(i).wektor(1:2);
        end
        if strcmp(mechanizm.sily(i).typ,'sprezyna')
            C1=FindCzlon(mechanizm.sily(i).czlon,mechanizm.czlony);
            C2=FindCzlon(mechanizm.sily(i).czlon2,mechanizm.czlony);
            d=C1.srodek.q-C2.srodek.q;
            u=d/norm(d);
            F1=mechanizm.sily(i).wspolczynniki(1)*(norm(d)-mechanizm.sily(i).wspolczynniki(3));
            v1=mechanizm.pred([3*C1.id+1 3*C1.id+2],1);
            v2=mechanizm.pred([3*C2.id+1 3*C2.id+2],1);
            dpr=-u'*(v2-v1);
            F2=dpr*mechanizm.sily(i).wspolczynniki(2);
            if strcmp(czlon.nazwa,C1.nazwa)
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])-eye(2)*u*F1;
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])-eye(2)*u*F2;
                
            end
            if strcmp(czlon.nazwa,C2.nazwa)
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])+eye(2)*u*F1;
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])+eye(2)*u*F2;
            end
        end
        
    end
    
end


