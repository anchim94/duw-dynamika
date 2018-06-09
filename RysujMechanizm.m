function [] = RysujMechanizm(mechanizm)
%RysujMechanizm Funkcja rysuj¹ca aktualny stan mechanizmu z wykorzystaniem
%opisu punktow
%ARGUMENTY FUNKCJI:
%mechanizm  --- struktura mechanizmu

n = length(mechanizm.czlony);
subplot(3,1,[1 2]);title("Animacja mechanizmu");
hold on;
axis([-1 4 -3 2]);
for i=1:n
    czl = mechanizm.czlony(i); %pobiera cz³ony ze struktury mechanizm
    m = length(czl.lancuch);
    W = zeros(m,2);
    q = czl.srodek.q;
    for j=1:m
        W(j,:) = q + R(czl.kat)*czl.lancuch(j).q;
    end
    fill(W(:,1),W(:,2),czl.kolor);
end
hold off;
end

