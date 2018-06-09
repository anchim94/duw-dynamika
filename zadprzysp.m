function [m] = zadprzysp(mechanizm,t)
%zadprzysp Funkcja rozwi¹zuj¹ca zadanie na przyspieszenia

m=mechanizm;

J=GenJakobi(m,t); %macierz Jacobiego
G=GenGamma(m,t); %wektor zró¿niczkowanychx2 po czasie lewych stron r-nañ wiêzów
m.G = G;
m.przysp = J\G;

end
