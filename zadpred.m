function [m] = zadpred(mechanizm,t)
%zadpred Funkcja rozwi¹zuj¹ca zadanie na prêdkoœci 

m=mechanizm;

J=GenJakobi(m,t); %macierz Jacobiego
T=GenJakobiT(m,t); %wektor zró¿niczkowanych po czasie lewych stron r-nañ wiêzów

m.pred = -J\T;

end

