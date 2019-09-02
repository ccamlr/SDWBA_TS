function [coeff,TSestim,kLestim,TSestimerror]=SDWBATSfunctioncoeff(kL,TS,pdegree)
% [coeff,TSestim,kLestim,TSestimerror]=SDWBATSfunctioncoeff=(kL,TS,pdegree)
% Estimate the coeff for the approximate function for TS versus kL, using a
% polynomial of order pdegree (default value 6).
%       n=length(coeff)=pdegree+1+4
%       TS(kL)=(coeff(1)*(log10(coeff(2)*kL)./(coeff(2)*kL)).^(coeff(3))+coeff(4)+
%       coeff(5)*kL^(n-5)+...+coeff(end)
% The results of the program are the function coefficients to apply coeff,
% the estimated TS with corresponding kL vector, and the estimated TS error
% between the function and the original vector TS versus original kL
% values.
%
% Stephane Conti
% 2005/05/24

if nargin<3
    pdegree=6;
end

%%%%%%%%%%%%%%%%%%%%
% Define the core function
kLmaxfun=40;
ikLfun=min(find(floor(kL)>=kLmaxfun));
A0=[-1 .001 .7 max(TS(1:ikLfun))];
fun=inline('(A(1)*(log10(A(2)*x)./(A(2)*x)).^(A(3))+A(4))','A','x');
[A,rfun,Jfun]=nlinfit(kL(1:ikLfun),TS(1:ikLfun).',fun,A0);

%%%%%%%%%%%%%%%%%%%%
% Define the polynomial
ikLmax=length(kL); 
kLestim=kL(1):.01:kL(ikLmax);
[p,s]=polyfit(kL(1:ikLmax).',TS(1:ikLmax)-real(fun(A,kL(1:ikLmax))).',pdegree);
[Pestim,delta]=polyval(p,kLestim,s);
[Pestimerror,deltaerror]=polyval(p,kL(1:ikLmax),s);

%%%%%%%%%%%%%%%%%%%%
% Estimate of the TS, and the error
TSestim=Pestim+real(fun(A,kLestim));
sigma=4*pi*10.^(TS/10);
sigmaestimerror=4*pi*10.^((Pestimerror+fun(A,kL(1:ikLmax)))/10);
TSestimerror=10*log10(sqrt(abs(sigma.'.^2./abs(sigmaestimerror).^2)));

coeff=[A p];