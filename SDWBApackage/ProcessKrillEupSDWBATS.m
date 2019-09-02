% ProcessKrillEupSDWBATS.m
% Program to process the SDWBA model for
% Antartic Krill.
% 
% Stephane Conti
% 2005/06/03

%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calculate the realisations of the noise
if ~(exist('p','var')&exist('A','var'))
    clear all
end
warning off;
currentdir=pwd;
path(path,'Bin\');

ButtonName=questdlg('SDWBA Target Strength', ...
                       'SDWBA', ...
                       'Estimate TS','Orientation average','Exit','Estimate TS');
dirname=pwd;
file2save='SDWBATS';
fatness=1.4;
ActualLength=38.35*1e-3;
fileshape='GenericEsuperba_McGehee1998';
frequency='[30:5:200]*1e3';
c=1456;
theta='-90:269';
stdphase0=sqrt(2)/2;
freq0=120e3;
N0=14;
noise_realisations=100;
g0=1.0357;
h0=1.0279;

switch ButtonName,
    case 'Estimate TS',
         prompt={'Name of the file to save the results:',...
            'Directory to save the results:',...
            'Length of the animal L (m):',...
            'Name of the file for the shape of the animal:',... 
            'Fatness coefficient:',...
            'Frequency range (Hz):',...
            'Incident angle Theta (degrees):',...
            'SDWBA phase variability Phi_0 (radians):',...
            'SDWBA standard frequency f_0 (Hz):',...
            'SDWBA standard number of cylinders N_0:',...
            'Density contrast g:',...
            'Sound speed contrast h:',...
            'Sound speed c (m/s):',...
            'Number of phase variability realisations:'};
        name='Inputs for SDWBA Target Strength';
        numlines=1;
        defaultanswer={file2save,dirname,num2str(ActualLength),fileshape,num2str(fatness),frequency,theta,num2str(stdphase0),num2str(freq0),...
           num2str(N0),num2str(g0),num2str(h0),num2str(c),num2str(noise_realisations)};

        answer=inputdlg(prompt,name,numlines,defaultanswer);

        file2save=answer{1};
        dirname=answer{2};
        ActualLength=str2num(answer{3});
        fileshape=answer{4};
        fatness=str2num(answer{5});
        frequency=str2num(answer{6});
        phi=90+str2num(answer{7});
        stdphase0=str2num(answer{8});
        freq0=str2num(answer{9});
        N0=str2num(answer{10});
        g0=str2num(answer{11});
        h0=str2num(answer{12});
        c=str2num(answer{13});
        noise_realisations=str2num(answer{14});


        load(fileshape);
        a=a*fatness;
        scaling=max(r(:,1))/ActualLength;
        r=r/scaling;
        a=a/scaling;
        h=h0*ones(size(h));
        g=g0*ones(size(g));

        kL=2*pi*frequency/c*ActualLength;

        if ~exist(dirname,'dir')
            mkdir(dirname);
        end
        if ~exist(strcat(dirname,'\dataSDWBA'),'dir')
            mkdir(strcat(dirname,'\dataSDWBA'))
        end

        for irealisation=1:noise_realisations
            [BSTS,BSsigma,form_function]=BSTS_SDWBA(frequency,r,a,h,g,phi,[stdphase0 freq0 N0],c,[irealisation noise_realisations]);
            save(strcat(dirname,'\dataSDWBA\',sprintf('%s_%d',file2save,irealisation)),'N0','stdphase0','freq0','BSTS','BSsigma','frequency','phi','form_function','ActualLength','c')
        end
        BSsigmatot=zeros(size(BSsigma,1),size(BSsigma,2),noise_realisations);
        clear BSTS BSsigma

        for irealisation=1:noise_realisations
            load(strcat(dirname,'\dataSDWBA\',sprintf('%s_%d',file2save,irealisation)))
            BSsigmatot(:,:,irealisation)=BSsigma;
        end
        StandardDeviation=std(BSsigmatot,[],3);
        BSsigma=mean(BSsigmatot,3);
        BSTS=10*log10(BSsigma);
        save(strcat(dirname,'\',file2save),'N0','stdphase0','freq0','frequency','BSTS','BSsigma','phi','StandardDeviation','ActualLength','c');
        clear BSsigmatot StandardDeviation BSTS
        BSsigmatot=BSsigma;
        
        ProcessKrillEupSDWBATS;

    case 'Orientation average'
        % Orientation distribution
        global A p ActualLength c
        stdorientation=4;
        meanorientation=11;
        
        prompt={'Mean orientation (degrees):',...
            'Standard deviation (degrees):'};
        name='Orientation average';
        numlines=1;
        defaultanswer={num2str(meanorientation),num2str(stdorientation)};
        answer=inputdlg(prompt,name,numlines,defaultanswer);
        
        meanorientation=str2num(answer{1});
        stdorientation=str2num(answer{2});
        
        [FileName,PathName] = uigetfile('*.mat','Select the SDWBA result file',file2save);
        load(strcat(PathName,FileName));
        kL=2*pi*frequency/c*ActualLength;
        
        orientation=GaussianOrientation(phi,90-meanorientation,stdorientation);
        [sigma,TS]=AverageTSorientation(BSsigma,orientation,phi);
        [coeff,TSestim,kLestim,TSestimerror]=SDWBATSfunctioncoeff(kL,TS,6);
        A=coeff(1:4);
        p=coeff(5:end);
        fun=inline('(A(1)*(log10(A(2)*x)./(A(2)*x)).^(A(3))+A(4))','A','x');
        save(strcat(dirname,'\',sprintf('%s_N%.0f_%.0f',file2save,meanorientation,stdorientation)),'A','p','coeff','frequency','TS','sigma','phi','orientation','ActualLength','c','meanorientation','stdorientation');
        
        disp({'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%';
            sprintf('SDWBA TS function parameters N(%d,%d):',meanorientation,stdorientation);
            sprintf('A = %.8e',A(1));
            sprintf('B = %.8e',A(2));
            sprintf('C = %.8e',A(3));
            sprintf('D = %.8e',p(1));
            sprintf('E = %.8e',p(2));
            sprintf('F = %.8e',p(3));
            sprintf('G = %.8e',p(4));
            sprintf('H = %.8e',p(5));
            sprintf('I = %.8e',p(6));
            sprintf('J = %.8e',p(7)+A(4))});

        figure('color',[1 1 1])
        line(frequency*1e-3,TS,'linewidth',2,'color',[0 0 0])
        line(kLestim*1e-3/2/pi*c/ActualLength,TSestim,'linewidth',2,'color',[0 0 0],'linestyle',':')
        xlabel('Frequency (kHz)')
        ylabel('TS (dB)')
        box on;
        legend('SDWBA','<SDWBA>',0)
        title('Left click on the desired values - Right click to exit')
        BUTTON=1;
        point_recorded=0;
        while BUTTON==1
            point_recorded=1+point_recorded;
            [X,Y,BUTTON] = GINPUT(1);
            if BUTTON==1
                [toto,indices]=min(abs(frequency*1e-3-X));
                f(point_recorded)=frequency(indices);
                SDWBA(point_recorded)=TS(indices);
                SDWBAsimplified(point_recorded)=polyval(p,2*pi*frequency(indices)/c*ActualLength)+real(fun(A,2*pi*frequency(indices)/c*ActualLength));
                if point_recorded==1
                    disp({'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%';
                            sprintf('Values for SDWBA TS and simplified version, for N(%d,%d):',meanorientation,stdorientation)});
                end
                disp({sprintf('Frequency = %.3f kHz',f(point_recorded)*1e-3);
                    sprintf('TSSDWBA = %.2f dB',SDWBA(point_recorded));
                    sprintf('<TSSDWBA> = %.2f dB',SDWBAsimplified(point_recorded))});
            end           
        end
        
        ProcessKrillEupSDWBATS;
        
    case 'Exit'
        [FileName,PathName] = uigetfile('*.mat','Select the SDWBA result file',sprintf('%s_N%.0f_%.0f','SDWBATS',11,4));
        load(strcat(PathName,FileName));
        Length=ActualLength;
        disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
        disp(sprintf('You can estimate the simplified <TSSDWBA> for N(%d,%d) using:',meanorientation,stdorientation))
        disp('TS=SimplifiedTSSDWBA(frequency,Length);')
end