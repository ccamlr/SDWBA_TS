
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%   Process_Krill_SDWBA_TS.m
%   is a program to process the SDWBA model for Krill.
%
%   It is based on the previous program
%   ProcessKrillEupSDWBATS.m implemented by
%   Stephane Conti 2005/06/03,
%   included in SDWBApackage20050603
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


%%% Calculate the realisations of the noise
if ~(exist('p','var') & exist('A','var'))
    clear all
end
warning off ;
currentdir = pwd ;
path(path,'Bin\') ; path(path,'Auxiliary\') ;


ButtonName = questdlg('SDWBA Target Strength', ...
    'SDWBApackage2010', ...
    'Estimate TS Database','Orientation average','Exit','Estimate TS');
 
switch ButtonName,
    case 'Estimate TS Database',
        
        GUI_Estimation_SDWBA2010_TS
        clear
                 
    case 'Orientation average'
        % Orientation distribution
        GUI_Orientation_SDWBA2010_TS
        clear
             
    case 'Exit'
        clear
 end