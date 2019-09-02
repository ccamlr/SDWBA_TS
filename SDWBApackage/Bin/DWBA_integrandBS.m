function integrand = DWBA_integrandBS(s);
% 10/25/2001
% Program to calculate the function to integrate for the DWBA model.
% Case of the back scattering TS only.
% Subprogram of BSTS_DWBA, refer to this program for the variables.

% Stephane Conti 10/25/2001
global k1 r1 r2 a1 a2 betatilt g1 g2 h1 h2 theta

rposx = s.*(r2(1,1)-r1(1,1))+r1(1,1);
rposy = s.*(r2(1,2)-r1(1,2))+r1(1,2);
rposz = s.*(r2(1,3)-r1(1,3))+r1(1,3);
rpos = [rposx;rposy;rposz];
a = s.*(a2-a1)+a1;
g = s.*(g2-g1)+g1;
h = s.*(h2-h1)+h1;
gamgam = 1./(g.*h.^2)+1./g-2;
if (abs(abs(betatilt)-pi/2)<1e-10)
    bessy = norm(k1).*a;
else
    bessy = besselj(1,2*norm(k1).*a./h*cos(betatilt))/cos(betatilt);
end
integrand = norm(k1)/4*gamgam.*exp(2*i*k1.'*rpos./h).*a.*bessy*norm(r2-r1);