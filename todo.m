mech = GenerujProblem(); %generowanie problemu
czas = 5;
krok = 0.01;
[wyniki,dokl,m] = ADAMS(mech,czas,krok,20,10); %rozwi¹zywanie zadañ
subplot(5,1,[1 2]);hold on;
plot(wyniki(:,2),wyniki(:,3)); %rysowanie wyniku
hold off;
subplot(5,1,[4 5]); hold on; %rysowanie ró¿nicy z Matlabem
R = wyniki-macierz;
plot(macierz(:,1),R(:,14));
plot(macierz(:,1),R(:,15));
plot(macierz(:,1),R(:,16));
plot(macierz(:,1),R(:,17));
plot(macierz(:,1),R(:,18));
plot(macierz(:,1),R(:,19));
legend('X','Y','VX','VY','AX','AY'); title("Ró¿nica z matlabem dla punktu K");
hold off;
