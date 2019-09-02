function [coeff, TSestim, kLestim, TSestimerror, sigmaestimerror] = SDWBA_TS_function_coeff(kL, TS, pdegree)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%   [coeff,TSestim,kLestim,TSestimerror] = SDWBA_TS_function_coeff(kL,TS,pdegree)
%
%   Modification of the Stephane Conti 2005/06/03 SDWBATSfunctioncoeff.m 
%   implementation
%
% 
%   Estimate the coeff for the approximate function for TS versus kL, using a
%   polynomial of order pdegree (default value 6).
%        n = length(coeff) = pdegree+1+4
%        TS(kL) = (coeff(1)*(log10(coeff(2)*kL)./(coeff(2)*kL)).^(coeff(3))+coeff(4)+
%        coeff(5)*kL^(n-5)+...+coeff(end)
%   The results of the program are the function coefficients to apply coeff,
%   the estimated TS with corresponding kL vector, and the estimated TS error
%   between the function and the original vector TS versus original kL
%   values.
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



if nargin<3
    pdegree = 6;                        % sixth degree polynomial
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Define the core function
            
kLmaxfun = 40 ;    

ikLfun = min(find(floor(kL)>=kLmaxfun)) ;

if isempty(ikLfun)
[ma kLmaxfun] = max(TS)        ;
ikLfun = min(find(floor(kL)>=kLmaxfun)) ;
end
% this is an adjustment to the line 23
% previous Conti script in order to
% perform a more flexible and 
% in some case accurate fitting
% Lucio 18/08/2011

A0 = [-1 .001 .7 max(TS(1:ikLfun))] ;
fun = inline('(A(1)*(log10(A(2)*x)./(A(2)*x)).^(A(3))+A(4))','A','x') ;
[A, rfun, Jfun] = nlinfit(kL(1:ikLfun), TS(1:ikLfun).', fun, A0) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Define the polynomial
ikLmax = length(kL) ; 
kLestim = kL(1):.01:kL(ikLmax) ;
[p,s] = polyfit(kL(1:ikLmax).',TS(1:ikLmax)-real(fun(A,kL(1:ikLmax))).',pdegree) ;
[Pestim,delta] = polyval(p,kLestim,s) ;
[Pestimerror,deltaerror] = polyval(p,kL(1:ikLmax),s) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Estimate of the TS, and the error
TSestim = Pestim + real(fun(A,kLestim)) ;
sigma = 4*pi*10.^(TS/10) ;
sigmaestimerror = 4*pi*10.^((Pestimerror+fun(A,kL(1:ikLmax)))/10) ;
TSestimerror = 10*log10(sqrt(abs(sigma.'.^2./abs(sigmaestimerror).^2))) ;

coeff = [A p];


