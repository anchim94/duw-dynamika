function [ wynik ] = AddWartoscQ( wektor,mechanizm,czlon,num )
%AddWartoscQ Funkcja wype�niaj�ca wektor si� uog�lnionych zgodnie z
%wcze�niej zdefiniowanymi si�ami w mechanizmie
%ARGUMENTY FUNKCJI:
%wektor         --- pocz�tkowy wektor si� uog�lnionych
%mechanizm      --- struktura mechanizmu
%czlon          --- tablica cz�on�w mechanizmu
%num            --- numer cz�ony

wynik = wektor; %wynikowa macierz przyjmuje warto�� pocz�tkow�
g=[0;-9.81;0]; % przyspieszenie grawitacyjne
omega=[0,-1;1,0];

%dodawanie si�y grawitacji skierowanej w d�
wynik([3*num-2,3*num-1,3*num])=wynik([3*num-2,3*num-1,3*num])+czlon.M*g;

for i=1:length(mechanizm.sily)
    if strcmp(czlon.nazwa,mechanizm.sily(i).czlon) || strcmp(czlon.nazwa,mechanizm.sily(i).czlon2)
            %sta�a si�a - wektor przy�o�ony do konkretnego punktu
        if strcmp(mechanizm.sily(i).typ,'stala')
            fi=czlon.kat;
            pkt=FindPoint(mechanizm.sily(i).punkt_przylozenia,czlon.lancuch);
            wynik([3*num-2,3*num-1,3*num])=wynik([3*num-2,3*num-1,3*num])+mechanizm.sily(i).wektor;
            wynik(3*num)=wynik(3*num)+(omega*R(fi)*pkt.q)'*mechanizm.sily(i).wektor(1:2);
        end
            %spr�yna pomi�dzy cz�onami zdefiniowana poprzez sztywno�� i
            %t�umienie
        if strcmp(mechanizm.sily(i).typ,'sprezyna')
            C1=FindCzlon(mechanizm.sily(i).czlon,mechanizm.czlony);
            C2=FindCzlon(mechanizm.sily(i).czlon2,mechanizm.czlony);
            d=C1.srodek.q-C2.srodek.q;
            u=d/norm(d);
            F1=mechanizm.sily(i).wspolczynniki(1)*(norm(d)-mechanizm.sily(i).wspolczynniki(3)); %si�a spr�yny
            v1=mechanizm.pred([3*C1.id+1 3*C1.id+2],1);
            v2=mechanizm.pred([3*C2.id+1 3*C2.id+2],1);
            dpr=-u'*(v2-v1);
            F2=dpr*mechanizm.sily(i).wspolczynniki(2); %si�a t�umi�ca
            %wstawianie si� dzia�aj�cych na cz�on 1
            if strcmp(czlon.nazwa,C1.nazwa)
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])-eye(2)*u*F1;
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])-eye(2)*u*F2;
                
            end
            %wstawianie si� dzia�aj�cych na cz�on 2
            if strcmp(czlon.nazwa,C2.nazwa)
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])+eye(2)*u*F1;
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])+eye(2)*u*F2;
            end
        end
        
    end
    
end


