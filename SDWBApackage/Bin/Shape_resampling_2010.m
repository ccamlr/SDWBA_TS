
function [r,a] = Shape_resampling_2010(r0,a0,N)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Shape_resampling_2010.m 
%   calculate the new position vector r
%   and radii values a of the cylinders
%   describing the shape of krill
%   for frequencies higher than the reference
%   to ensure general utility of the SDWBA model (Conti and Demer, 2006)
%
%   The approach used by the Shape_resampling_2010.m function
%   is described in:
%   Calise and Skaret
%   SENSITIVITY INVESTIGATION OF THE SDWBA ANTARCTIC KRILL 
%   TARGET STRENGTH MODEL TO FATNESS, MATERIAL CONTRAST AND ORIENTATION
%   to be published in CCMLAR Science 2011
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


    xx = linspace(r0(1,1),r0(1,end),N+1) ;           % finding the N+1 array of equal-distance points along the x-coordinate
    %nearests = unique(dsearchn(xx',r0(:,1)));      % finding the N+1 nearest point array
    nearests = dsearchn(xx',r0(:,1)) ;               % THIS UNICITY HAS TO BE CHACKED
    xx(nearests(2:end-1)) = r0((2:end-1),1) ;
    
    %%% split the cylinder in equal size
    B = r0(:,1);
    for hh = 1:length(B)-1
        C = find(xx<B(hh) & xx>B(hh+1)) ;
        if isempty(C)==0
            G =linspace(B(hh),B(hh+1),length(C)+2) ;
            xx(C) = G(2:end-1) ;
        end
    end
    
    %%% calculate the new Y coordinate
    yy =interp1(r0(:,1),r0(:,2),xx,'spline') ;
    %%% inizialize the new position vector
    r = [xx' yy' zeros(length(xx),1)] ;
    
    %%% SEARCH FOR THE RADII ARRAY
    A = r(:,1) ;
    B = r0(:,1) ;
    for kk = 1:length(B)-1
        C = find(A<=B(kk)) ;
        a(C+1) = a0(kk+1) ;
        clear C
    end
    %%% return to mm; 
    %%% the script plot_the_krill_shape is made for units
    %%% in mm because of the script Cylinder_A.m
     
    r = r*10^3 ;
    a = a(1:N+1)*10^3 ;
