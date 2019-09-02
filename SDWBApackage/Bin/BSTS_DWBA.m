function [TS,sigma,form_function]=BSTS_DWBA(frequency,r,a,h,g,phi)
% [TS,sigma,form_function]=BSTS_DWBA(frequency,rpos,a,h,g,phi)
% Program to calculate the back-scattering TS using the Born Approximation for
% the azimut theta for a scatterer with a density and a sound speed
%close to the  water ones.
%   frequency is a vector with the frequencies in Hertz.
%   rpos is a Nx3 matrix in meters where N is the number of points
%to define the scatterer. Usually the third dimension is not used.
%   a is Nx1 vector with the radius in meters at the N positions 
% to define the scatterer.
%   h is a Nx1 vector defining the density contrast values.
%   g is a Nx1 vector of sound speed contrast values.
%   phi is the incidence angle in XY in degrees. It is an option
% the default value is 0, which means a incident wave coming from 
% the negative X (it would be pi/2 coming from the negative Y). It
% can be a vector.
%
% Stephane Conti 
% 2005/06/02

global k1 r1 r2 a1 a2 betatilt g1 g2 h1 h2 theta
theta=pi;
if (nargin<6)
    phi=0;
end

%Check the dimensions of the matrix
if (size(frequency,1)>size(frequency,2))
    frequency=frequency.';
end
if (size(r,2)~=3)
    r=r.';
end
if (size(a,2)~=1)
    a=a.';
end
if (size(h,2)~=1)
    h=h.';
end
if (size(g,2)~=1)
    g=g.';
end

c=1500; %sound speed in the water in m/s
k=2*pi*frequency/c;
TS=zeros(length(frequency),length(phi));
sigma=zeros(length(frequency),length(phi));
form_function=zeros(length(frequency),length(phi));
phi=phi*pi/180;  %convert from degrees to radians

hh=waitbar(0,'DWBA calculations');
for i_phi=1:length(phi)
    for ik=1:length(k)
        k1=k(ik).*[cos(phi(i_phi));sin(phi(i_phi));0];  %dimension 3x1
        for iN=1:(length(a)-1)
            a1=a(iN);
            a2=a(iN+1);
            r1=r(iN,:);
            r2=r(iN+1,:);
            g1=g(iN);
            g2=g(iN+1);
            h1=h(iN);
            h2=h(iN+1);
            alphatilt=acos((r2-r1)*k1./(norm(k1).*norm(r2-r1)));
            betatilt=pi/2-alphatilt;
            form_function(ik,i_phi)=form_function(ik,i_phi)+quadl(@DWBA_integrandBS,0,1);
        end
    end
    waitbar(i_phi/length(phi));
end
close(hh);
sigma=abs(form_function).^2;
TS=10*log10(sigma);