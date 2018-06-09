mech = GenerujProblem(); %generowanie problemu
czas = 5;
krok = 0.01;
[wyniki,dokl,m] = ADAMS(mech,czas,krok); %rozwi¹zywanie zadañ
subplot(3,1,[1 2]);hold on;
plot(wyniki(:,2),wyniki(:,3)); %rysowanie wyniku
hold off;