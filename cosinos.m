function [ co ] = cosinos(c,q )
%COSINOS Summary of this function goes here
%   Detailed explanation goes here
a=norm(c);
b=norm(q);
zarb=c'*q;
co=zarb/(a*b);

end

