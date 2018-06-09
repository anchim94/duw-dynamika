function [ M ] = GenMasowa( mechanizm )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
M=zeros(3*length(mechanizm.czlony),3*length(mechanizm.czlony));
for i=1:length(mechanizm.czlony)
    M([3*i-2,3*i-1,3*i],[3*i-2,3*i-1,3*i])=mechanizm.czlony(i).M;
end

