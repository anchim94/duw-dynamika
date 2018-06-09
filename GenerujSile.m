function [ Q ] = GenerujSile( mechanizm )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Q=zeros(3*length(mechanizm.czlony),1);
for i=1:length(mechanizm.czlony)
    Q=AddWartoscQ(Q,mechanizm,mechanizm.czlony(i),i);

end

