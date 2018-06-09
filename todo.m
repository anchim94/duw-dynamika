mech = GenerujProblem(); %generowanie problemu
czas = 5;
krok = 0.01;
[wyniki,m] = ADAMS(mech,czas,krok); %rozwi¹zywanie zadañ
hold on;
plot(wyniki(:,2),wyniki(:,3)); %rysowanie wyniku
hold off;