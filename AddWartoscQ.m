function [ wynik ] = AddWartoscQ( wektor,mechanizm,czlon,num )
%AddWartoscQ Funkcja wype³niaj¹ca wektor si³ uogólnionych zgodnie z
%wczeœniej zdefiniowanymi si³ami w mechanizmie
%ARGUMENTY FUNKCJI:
%wektor         --- pocz¹tkowy wektor si³ uogólnionych
%mechanizm      --- struktura mechanizmu
%czlon          --- tablica cz³onów mechanizmu
%num            --- numer cz³ony

wynik = wektor; %wynikowa macierz przyjmuje wartoœæ pocz¹tkow¹
g=[0;-9.81;0]; % przyspieszenie grawitacyjne
omega=[0,-1;1,0];

%dodawanie si³y grawitacji skierowanej w dó³
wynik([3*num-2,3*num-1,3*num])=wynik([3*num-2,3*num-1,3*num])+czlon.M*g;

for i=1:length(mechanizm.sily)
    if strcmp(czlon.nazwa,mechanizm.sily(i).czlon) || strcmp(czlon.nazwa,mechanizm.sily(i).czlon2)
            %sta³a si³a - wektor przy³o¿ony do konkretnego punktu
        if strcmp(mechanizm.sily(i).typ,'stala')
            fi=czlon.kat;
            pkt=FindPoint(mechanizm.sily(i).punkt_przylozenia,czlon.lancuch);
            wynik([3*num-2,3*num-1,3*num])=wynik([3*num-2,3*num-1,3*num])+mechanizm.sily(i).wektor;
            wynik(3*num)=wynik(3*num)+(omega*R(fi)*pkt.q)'*mechanizm.sily(i).wektor(1:2);
        end
            %sprê¿yna pomiêdzy cz³onami zdefiniowana poprzez sztywnoœæ i
            %t³umienie
        if strcmp(mechanizm.sily(i).typ,'sprezyna')
            C1=FindCzlon(mechanizm.sily(i).czlon,mechanizm.czlony);
            C2=FindCzlon(mechanizm.sily(i).czlon2,mechanizm.czlony);
            d=C1.srodek.q-C2.srodek.q;
            u=d/norm(d);
            F1=mechanizm.sily(i).wspolczynniki(1)*(norm(d)-mechanizm.sily(i).wspolczynniki(3)); %si³a sprê¿yny
            v1=mechanizm.pred([3*C1.id+1 3*C1.id+2],1);
            v2=mechanizm.pred([3*C2.id+1 3*C2.id+2],1);
            dpr=-u'*(v2-v1);
            F2=dpr*mechanizm.sily(i).wspolczynniki(2); %si³a t³umi¹ca
            %wstawianie si³ dzia³aj¹cych na cz³on 1
            if strcmp(czlon.nazwa,C1.nazwa)
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])-eye(2)*u*F1;
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])-eye(2)*u*F2;
                
            end
            %wstawianie si³ dzia³aj¹cych na cz³on 2
            if strcmp(czlon.nazwa,C2.nazwa)
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])+eye(2)*u*F1;
                wynik([3*num-2,3*num-1])=wynik([3*num-2,3*num-1])+eye(2)*u*F2;
            end
        end
        
    end
    
end


