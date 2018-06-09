function [m] = zadpred(mechanizm,t)
%zadpred Funkcja rozwi�zuj�ca zadanie na pr�dko�ci 

m=mechanizm;

J=GenJakobi(m,t); %macierz Jacobiego
T=GenJakobiT(m,t); %wektor zr�niczkowanych po czasie lewych stron r-na� wi�z�w

m.pred = -J\T;

end

