function [V_mm] = Volume_Shape(r_v,a_v)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%   [V_mm] = Volume_Shape(r_v,a_v)
%
%   Calculate the volume of a krill shape with first cylinder ray = 0
%
%
%   GNU Public Licence Copyright (c) Lucio Calise
%   Comments and suggestions to lucio@imr.no
%
%   Lucio Calise
%   Institute of Marine Research
%   Bergen, Norway
%   August 2011
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
for kk = 2:size(r_v,1)
    h(kk) = sqrt( ( r_v(kk,2) - r_v(kk-1,2) )^2 + ( r_v(kk,1) - r_v(kk-1,1) )^2 ) ;
    v(kk) = pi*a_v(kk)^2*h(kk) ;
end

V = sum(v)    ;         % Volume in cubic meters
V_mm = V*10^6 ;         % Volume in cubic centimeters