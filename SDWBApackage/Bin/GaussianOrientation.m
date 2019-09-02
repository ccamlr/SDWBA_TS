function orientation=GaussianOrientation(phi,phi0,stdphi);
% orientation=GaussianOrientation(phi,phi0,stdphi);
% Defines a wrapped around gaussian distribution of orientations for the
% vector phi in degrees, mean phi0 and standard deviation stdphi.
%
% Stephane Conti
% 2005/05/24

orientation=exp(-(phi-phi0).^2/2/stdphi^2)+exp(-(phi+360-phi0).^2/2/stdphi^2)+exp(-(phi-360-phi0).^2/2/stdphi^2);
orientation=orientation/sum(orientation*mean(diff(phi)));
