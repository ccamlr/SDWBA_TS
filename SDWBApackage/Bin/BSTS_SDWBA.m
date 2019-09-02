function [TS,sigma,form_function,Stdphase_vs_freq,Cylinders_vs_freq] = BSTS_SDWBA_2010(frequency,r0,a0,h0,g0,phi,initial_parameters,c,waitbarparameters,file2save)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  SDWBApackage2010, version 1.0
%
%  BSTS_SDWBA_2010.m
%
%  Modification of the Stephane Conti 2005/06/03 BSTSSDWBA.m implementation
%
%  Program to calculate the back-scattering TS using the Born Approximation for
%  the azimut phi for a scatterer with a density and a sound speed
%  close to the  water ones.
%  - frequency is a vector with the frequencies in Hertz.
%  - rpos is a Nx3 matrix in meters were N is the number of points
%    to define the scatterer. Usually the third dimension is not used.
%  - a is Nx1 vector with the radius in meters at the N positions
%    to define the scatterer.
%  - h is a Nx1 vector defining the contrast values.
%  - g is a Nx1 vector of sound speed contrast values.
%  - phi is the incidence angle in XY in degrees. It is an option
%    the default value is 0, which means a incident wave coming from
%    the negative X (it would be pi/2 coming from the negative Y). It
%    can be a vector.
%  - initial_parameters is a vector [sdphi0 frequency0 N0], default
%    [sqrt(2)/2 120e3 14]
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



if (nargin<6)
    phi = 0 ;
end
if (nargin<7)
    initial_parameters = [sqrt(2)/2 120e3 14] ;
end
stdphase0 = initial_parameters(1) ;
freq0 = initial_parameters(2) ;
N0 = initial_parameters(3) ;
if nargin<8
    c = 1500 ;
end

%%% Check the dimensions of the matrix
if (size(frequency,1)>size(frequency,2))
    frequency = frequency.' ;
end
if (size(r0,2)~=3)
    r0 = r0.' ;
end
if (size(a0,2)~=1)
    a0 = a0.' ;
end
if (size(h0,2)~=1)
    h0 = h0.' ;
end
if (size(g0,2)~=1)
    g0 = g0.' ;
end

k = 2*pi*frequency/c ;                           % wave number
form_function = zeros(length(frequency),length(phi)) ;  % % backscattering function vector declaration
phi = phi*pi/180 ;                               % convert from degrees to radians

%%% WAITBAR
if ~isempty(waitbarparameters)
    if exist('waitbarparameters','var')
        hh = waitbar(0,sprintf('calculation  %d  of  %d  stochastic realizations',waitbarparameters),'Name',['Database ' file2save ]) ;
    else
        hh = waitbar(0,'SDWBA2010 calculations');
    end
end

%%% RESAMPLING
for ik = 1:length(k)
    N = ceil(N0*frequency(ik)/freq0);            % definition of Cilinders number Conti and Demer (2006) eq. 8 pag 930
    if N <= N0                                    % for Cilinder_shape-frequency less than 14
        stdphase = stdphase0;
        r = r0;
        a = a0;
        N = N0;
        %%% Material Parameter for each cylinder
        h = h0*ones(size(a)) ;
        g = g0*ones(size(a)) ;
        
    else                                        % for Cilinder_shape-frequency more than 14
        
        stdphase = stdphase0*N0/N;              % definition of sd of stochastic phase Conti and Demer (2006) eq. 9 pag 930   
        
        %%%% NEW resampling
        [r,a] = Shape_resampling_2010(r0,a0,N) ;

        %%% back to m after the resampling
        a = a*10^-3 ;  r = r*10^-3 ;
        %%% Material Parameter for each cylinder
        h = h0(1)*ones(N+1,1);
        g = g0(1)*ones(N+1,1);
    end

    
    
    %%% Calculate the scattering function
    for i_phi = 1:length(phi)
        k1 = k(ik).*[cos(phi(i_phi));sin(phi(i_phi));0];  %dimension 3x1
        for iN = 1:(length(a)-1)
            a1 = a(iN);
            a2 = a(iN+1);
            r1 = r(iN,:);
            r2 = r(iN+1,:);
            g1 = g(iN);
            g2 = g(iN+1);
            h1 = h(iN);
            h2 = h(iN+1);
            alphatilt = acos((r2-r1)*k1./(norm(k1).*norm(r2-r1)));
            betatilt = pi/2-alphatilt;
            buff = quadl(@(s) DWBA_integrandBS(s, k1, r1, r2, a1, a2, betatilt, g1, g2, h1, h2), 0, 1);
            noise = exp(1i*(stdphase.^2*randn(size(buff))));
            buff = buff*noise;
            form_function(ik,i_phi) = form_function(ik,i_phi)+buff;
        end
        if exist('hh', 'var')
            hh = waitbar((i_phi+(ik-1)*length(phi))/length(phi)/length(k));
        end
    end
    Cylinders_vs_freq(ik) = N ;                   % in order to save number of cylinder and stdphase versus frequency
    Stdphase_vs_freq(ik) = stdphase ;
end
if exist('hh', 'var')
    close(hh);
end
sigma = abs(form_function).^2;
TS = 10*log10(sigma);
