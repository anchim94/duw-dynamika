function [m] = zadprzysp(mechanizm,t)
%zadprzysp Funkcja rozwi�zuj�ca zadanie na przyspieszenia

m=mechanizm;

J=GenJakobi(m,t); %macierz Jacobiego
G=GenGamma(m,t); %wektor zr�niczkowanychx2 po czasie lewych stron r-na� wi�z�w
m.G = G;
m.przysp = J\G;

end
