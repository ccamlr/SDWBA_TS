function TS_Simplified = Simplified_TS_SDWBA(session_name,freq, Length)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%   TS_Simplified = Simplified_TS_SDWBA(frequency,Length)
%   Estimate the simplified version of the SDWBA TS using the variable 
%   "coeff" in the workspace.
%
%   Modification of the Stephane Conti 2005/06/03 implementation
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

 
global c coeff ActualLength

load(session_name);
Length = Length * 10^-3 ;       % from mm in m
freq = freq * 10^3 ;

A1 = coeff(1:4) ;
p = coeff(5:end) ;
fun = inline('(A1(1)*(log10(A1(2)*x)./(A1(2)*x)).^(A1(3))+A1(4))','A1','x') ;
 A=A1(1); B=A1(2); C=A1(3); D=p(1); E=p(2); F=p(3); G=p(4); H=p(5); I=p(6); J=p(7)+A1(4);
for ifreq = 1:length(freq)
    for iL = 1:length(Length)
        %%% Calculation by fitting
        AA = polyval(p, 2*pi*freq(ifreq)/c*Length(iL)) ;
        AAA= real(fun(A1, 2*pi*freq(ifreq)/c*Length(iL))) ;
        TS_Simplified(ifreq,iL) = AA + AAA + 20*log10(Length(iL)/ActualLength) ;
        
%         %%% Calculation by formula Demer and Conti (2005)
          % it gives the same result !!!
%         x = 2*pi*freq(ifreq)/c * Length(iL) ;
%         TS_Simplified_poly = real(A*( log10(B*x)./(B*x) ).^C + D*x^6 + E*x^5 + F*x^4 + G*x^3 + H*x^2 + I*x + J + 20*log10(Length(iL)/ActualLength))
    end
end