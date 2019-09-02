function TS=SimplifiedTSSDWBA(frequency,Length)
% TS=SimplifiedTSSDWBA(frequency,Length)
% Estimate the simplified version of the SDWBA TS using A and p in the
% workspace.
%
% Stephane Conti
% 2005/06/03

global A p ActualLength c
fun=inline('(A(1)*(log10(A(2)*x)./(A(2)*x)).^(A(3))+A(4))','A','x');
for ifreq=1:length(frequency)
    for iL=1:length(Length)
        TS(ifreq,iL)=polyval(p,2*pi*frequency(ifreq)/c*Length(iL))+real(fun(A,2*pi*frequency(ifreq)/c*Length(iL)))+20*log10(Length(iL)/ActualLength);
    end
end