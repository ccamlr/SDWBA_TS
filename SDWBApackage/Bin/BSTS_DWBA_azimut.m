function [TS,sigma]=BSTS_DWBA_azimut(frequency,r,a,h,g,theta_vec,phi)
% [TS,sigma]=BSTS_DWBA_azimut(frequency,rpos,a,h,g,theta,phi)
% 10/25/2001
% Program to calculate the TS using the Born Approximation for
% the azimut theta for a scatterer with a density and a sound speed
%close to the  water ones.
%   frequency is a vector with the frequencies in Hertz.
%   rpos is a Nx3 matrix in meters were N is the number of points
%to define the scatterer. Usually the third dimension is not used.
%   a is Nx1 vector with the radius in meters at the N positions 
% to define the scatterer.
%   h is a Nx1 vector defining the contrast values.
%   g is a Nx1 vector of sound speed contrast values.
%   theta is a vector of the azimut angles in degrees for the TS.
%   phi is the incidence angle in XY in degrees. It is an option
% the default value is 0, which means a incident wave coming from 
% the negative X (it would be pi/2 coming from the negative Y). It
% can be a vector.
%
% Stephane Conti 
% 2005/06/02

global k1 r1 r2 a1 a2 betatilt g1 g2 h1 h2 theta

if (nargin<7)
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
TS=zeros(length(frequency),length(theta_vec),length(phi));
sigma=zeros(length(frequency),length(theta_vec),length(phi));
form_function=zeros(length(frequency),length(theta_vec),length(phi));
phi=phi*pi/180;  %convert from degrees to radians
theta_vec=theta_vec*pi/180;

for i_phi=1:length(phi)
    for i_theta=1:length(theta_vec)
        theta=theta_vec(i_theta);
        hh=waitbar(0,sprintf('Incidence %d/%d - Azimut %d/%d',i_phi,length(phi),i_theta,length(theta_vec)));
        for ik=1:length(k)
            k1=k(ik).*[cos(phi(i_phi));sin(phi(i_phi));0];  %dimension 3x1
            %form_function=0;
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
                form_function(ik,i_theta,i_phi)=form_function(ik,i_theta,i_phi)+quadl(@DWBA_integrand,0,1);
            end
            waitbar(ik/length(k));
        end
        close(hh);
    end
end
sigma=abs(form_function).^2; 
TS=10*log10(sigma);