function [TS,sigma,form_function]=BSTS_SDWBA(frequency,r0,a0,h0,g0,phi,initial_parameters,c,waitbarparameters)
% [TS,sigma,form_function]=BSTS_SDWBA(frequency,rpos,a,h,g,phi,initial_parameters,c)
%
% Program to calculate the back-scattering TS using the Born Approximation for
% the azimut theta for a scatterer with a density and a sound speed
%close to the  water ones.
%   frequency is a vector with the frequencies in Hertz.
%   rpos is a Nx3 matrix in meters were N is the number of points
%to define the scatterer. Usually the third dimension is not used.
%   a is Nx1 vector with the radius in meters at the N positions 
% to define the scatterer.
%   h is a Nx1 vector defining the contrast values.
%   g is a Nx1 vector of sound speed contrast values.
%   phi is the incidence angle in XY in degrees. It is an option
% the default value is 0, which means a incident wave coming from 
% the negative X (it would be pi/2 coming from the negative Y). It
% can be a vector.
%   initial_parameters is a vector [sdphi0 frequency0 N0], default
% [sqrt(2)/2 120e3 14]
%
% Stephane Conti
% 2005/06/02

global k1 r1 r2 a1 a2 betatilt g1 g2 h1 h2 theta
theta=pi;
if (nargin<6)
    phi=0;
end
if (nargin<7)
    initial_parameters=[sqrt(2)/2 120e3 14];
end
stdphase0=initial_parameters(1);
freq0=initial_parameters(2);
N0=initial_parameters(3);
if nargin<8
    c=1500;
end

%Check the dimensions of the matrix
if (size(frequency,1)>size(frequency,2))
    frequency=frequency.';
end
if (size(r0,2)~=3)
    r0=r0.';
end
if (size(a0,2)~=1)
    a0=a0.';
end
if (size(h0,2)~=1)
    h0=h0.';
end
if (size(g0,2)~=1)
    g0=g0.';
end

k=2*pi*frequency/c;
TS=zeros(length(frequency),length(phi));
sigma=zeros(length(frequency),length(phi));
form_function=zeros(length(frequency),length(phi));
phi=phi*pi/180;  %convert from degrees to radians

if exist('waitbarparameters','var')
    hh=waitbar(0,sprintf('SDWBA calculations %d of %d',waitbarparameters));
else
    hh=waitbar(0,'SDWBA calculations');
end
for ik=1:length(k)
    N=ceil(N0*frequency(ik)/freq0);
    if N<N0
        stdphase=stdphase0;
        r=r0;
        a=a0;
        h=h0;
        g=g0;
    else
        stdphase=stdphase0*N0/N;
        NbCylinders=N+1;
        if (size(r0,1)>NbCylinders)
            q=NbCylinders;
            p=size(r0,1);
        elseif (size(r0,1)<NbCylinders)
            q=size(r0,1);
            p=NbCylinders;
        else
            p=1;
            q=1;
        end
        r=resample(r0,p,q);
        a=resample(a0,p,q);
        h=h0(1)*ones(NbCylinders,1);
        g=g0(1)*ones(NbCylinders,1);
    end
    
    for i_phi=1:length(phi)
        k1=k(ik).*[cos(phi(i_phi));sin(phi(i_phi));0];  %dimension 3x1
        for iN=1:(length(a)-1)
            buff=0;
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
            buff=quadl(@DWBA_integrandBS,0,1);
            noise=exp(i*(stdphase.^2*randn(size(buff))));
            buff=buff*noise;
            form_function(ik,i_phi)=form_function(ik,i_phi)+buff;
        end
        waitbar((i_phi+(ik-1)*length(phi))/length(phi)/length(k));
    end
end
close(hh);
sigma=abs(form_function).^2;
TS=10*log10(sigma);