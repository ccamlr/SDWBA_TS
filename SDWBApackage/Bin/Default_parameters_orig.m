
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%   Default_parameters.m
%
%   Default parameters values:   
%   Inputs for SDWBA2010 Antarctic krill Target Strength
%   within Process_Krill_SDWBA_TS.m program
%   to process the SDWBA model for Krill.
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


%%% I/O
dirname = pwd ;                 % this is also the folder where the fileshape is storaged
file2save = 'SDWBA_TS' ;

%%% key parameters
ActualLength = '38.35' ; %*1e-3 ;
g0 = '1.0357' ;                 % Foote et al. (1990)
h0 = '1.0279' ;                 % Foote (1990)
c = '1456' ;                    % McGehee et al. (1998)

%%% basic parameters
fileshape = 'Esuperba_AT38_35mm_McGeheeetal_1998' ;   % McGehee et al (1998), Table 3 pag 1286
                                                        % the measures are in (mm)

L0 = '38.35' ; %*1e-3 ;         % reference length McGehee et al. (1998)
%N0 = '14' ;                    % McGehee et al. (1998)
fatness = 40 ;                 % (%) Conti and Demer (2006)
freq0 = '120' ;  %e3 ;          % McGehee et al. (1998)
stdphase0 = 'sqrt(2)/2' ;       % Demer and Conti (2003)

%%% operational parameters
frequency_min = '10' ; frequency_step = '5' ; frequency_max = '500' ;
discrete_frequency = ' [38 120]' ;
theta_min = '-90' ; theta_step = '1'; theta_max = '269' ;
discrete_incidence = ' [-90 0 90 180 270]' ;

radiobuttom_frequency_range = 'on' ;    % if you need discrete values as default, set this string different than 'on'
radiobuttom_incidence_range = 'on' ;    % if you need discrete values as default, set this string different than 'on'

noise_realisations = '100' ;             % Demer and Conti (2003)




