function [sigma,TS]=AverageTSorientation(sigma,orientation,phi);
% [sigma,TS]=AverageTSorientation(sigma,orientation,phi);
% Average the back scattering cross section over the orientation
% distribution.
% sigma is a matrix (frequency x orientation)
% orientation is a vector (1 x orientation)
% phi is a vector (1 x orientation)
%
% Stephane Conti
% 2005/05/24

sigma=sum(sigma.*(ones(size(sigma,1),1)*orientation)*mean(diff(phi)),2);
TS=10*log10(sigma);