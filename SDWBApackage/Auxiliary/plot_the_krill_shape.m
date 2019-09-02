
function [N,stdphase] = plot_the_krill_shape(r0,a0,freq0,frequency,stdphase0)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%   plot_the_krill_shape.m
%   Program to plot the digitalized shape of an organism
%   for the SDWBA model
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

N0 = length(a0)-1 ;
N = ceil(N0*frequency/freq0) ;           % definition of Cilinders number Conti and Demer (2006) eq. 8 pag 930
if N<=N0                                 % for Cilinder_shape-frequency less than the reference number
    r = r0 *10^3 ;
    a = a0 *10^3 ;
    stdphase = stdphase0 ;
    N = N0 ;
else
    %%%% NEW standard deviation of stochastic phase
    stdphase = stdphase0*N0/N ;
    %%%% NEW resampling
    [r,a] = Shape_resampling_2010(r0,a0,N) ;
end


%%% Plotting in mm

 
colore=0.3*ones(1,3);
FaceAlp=0.6;

for k=1:length(a)-1
    [Cylinder(k) EndPlate1 EndPlate2] = Cylinder_A(r(k,:),r(k+1,:),a(k+1),1000,colore,1,0) ;
    % shading interp
    set(Cylinder(k),'FaceAlpha',FaceAlp,'FaceColor',[colore]);      % Trasparency
    set(EndPlate1,'FaceAlpha',FaceAlp,'FaceColor',[colore]+0.6);    % Trasparency
    set(EndPlate2,'FaceColor','none');                              % Trasparency
    set(Cylinder(k),'Marker','.','MarkerEdgeColor','w','MarkerSize',2)
    
end

HH = plot3(r(:,1),r(:,2),r(:,3),'w.-') ;
set(HH,'LineWidth',2.5,'MarkerSize',14)
set(gca,'FontSize',12)
axis equal
grid on

end
