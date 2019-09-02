function varargout = GUI_Orientation_SDWBA2010_TS(varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%   GUI_Orientation_SDWBA2010_TS.m
%   GUI program within the SDWBApackage2010 implemented to 
%   check the digitalized shape and resampling of the 
%   organism processed by the SDWBApackage2010
%   
%   The program shows the main parameters of the reference shape:
%   Numer of cylinders, AT length and fatness, as well as
%   the frequency and phase variability related to the 
%   comparison between empirical measurements andf predictions.
%
%   In addiction, it is possible to check the resampled shape
%   for frequency higher than the reference freq0 as processed by the
%   SDWBApackage2010
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

%
% GUI_ORIENTATION_SDWBA2010_TS MATLAB code for GUI_Orientation_SDWBA2010_TS.fig
%      GUI_ORIENTATION_SDWBA2010_TS, by itself, creates a new GUI_ORIENTATION_SDWBA2010_TS or raises the existing
%      singleton*.
%
%      H = GUI_ORIENTATION_SDWBA2010_TS returns the handle to a new GUI_ORIENTATION_SDWBA2010_TS or the handle to
%      the existing singleton*.
%
%      GUI_ORIENTATION_SDWBA2010_TS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ORIENTATION_SDWBA2010_TS.M with the given input arguments.
%
%      GUI_ORIENTATION_SDWBA2010_TS('Property','Value',...) creates a new GUI_ORIENTATION_SDWBA2010_TS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Orientation_SDWBA2010_TS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Orientation_SDWBA2010_TS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Orientation_SDWBA2010_TS

% Last Modified by GUIDE v2.5 17-Apr-2012 22:32:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Orientation_SDWBA2010_TS_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Orientation_SDWBA2010_TS_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before GUI_Orientation_SDWBA2010_TS is made visible.
function GUI_Orientation_SDWBA2010_TS_OpeningFcn(hObject, eventdata, handles)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Orientation_SDWBA2010_TS (see VARARGIN)

% Choose default command line output for GUI_Orientation_SDWBA2010_TS
handles.output = hObject;
warning off ;
path(path,'SDWBApackage2010\') ; path(path,'Bin\') ; path(path,'Auxiliary\') ;
path_sess = [pwd '\'] ;
file_sess = 'SDWBA_TS_fat40' ;
set(handles.edit_session,'String', [path_sess file_sess])
handles.session_path = path_sess ;
handles.session_name = file_sess ;
set(handles.edit_meanorientation,'String', '11')
set(handles.edit_stdorientation,'String', '4')
set(handles.axes2,'Visible','off')
cla;
legend OFF
set(handles.uipanel_Parameters,'Visible','off')
set(handles.uipanel_TS_calculation,'Visible','off')


% This sets up the initial plot - only do when we are invisible
% so window can get raised using GUI_Orientation_SDWBA2010_TS.

% if strcmp(get(hObject,'Visible'),'off')
%     fileshape = get(handles.file_shape,'String') ;
%     load(fileshape);
%     %%% imposing the fatness
%     a = a * (str2num(fat)*10^-2+1) ;
%     plot_the_krill_shape(r,a,f0,f0,stdph0);
% 
% %%% volume calculation
% V = Volume_Shape(r,a) ;
% set(handles.value_volume,'String', num2str(round(V*1000)/1000))
% end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Orientation_SDWBA2010_TS wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Orientation_SDWBA2010_TS_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in plot_bottom.
function A0 = plot_bottom_Callback(hObject, eventdata, handles)
% hObject    handle to plot_bottom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%% Setting input
if strcmp(get(handles.edit_session,'String'),['0';'0'])
   Browse_session_Callback(hObject, eventdata, handles)
end

Filename = get(handles.edit_session,'String') ; 
load(Filename);
if exist('ActualLength','var') & exist('BSsigma','var')

meanorientation = str2num(get(handles.edit_meanorientation,'String')) ;
stdorientation = str2num(get(handles.edit_stdorientation,'String')) ;

set(handles.uipanel_Parameters,'Visible','on')
Titolo_TS_Estimation = [' <SDWBA> TS estimation for N(' get(handles.edit_meanorientation,'String') ', ' get(handles.edit_stdorientation,'String') ') ' ] ; 
set(handles.uipanel_TS_calculation,'Title', Titolo_TS_Estimation) 
set(handles.uipanel_TS_calculation,'Visible','on')
set(handles.axes2,'Visible','on')
 
%%% Parameters
% set(handles.value_cylinders,'String', N0) 
set(handles.value_length,'String', ActualLength*10^3)
set(handles.value_density_contrast,'String', g0)
set(handles.value_velocity_contrast,'String', h0)

%%% setting values also considering the previous package variables names
if exist('Animal_shape_file'); set(handles.value_fileshape,'String', Animal_shape_file)
else; set(handles.value_fileshape,'String', fileshape); end

if exist('L0'); set(handles.value_reflength,'String', L0*10^3)
else; set(handles.value_reflength,'String', ActualLength*10^3);end

if exist('fatness_factor');set(handles.value_fatness,'String', round((fatness_factor-1)*100))
else;set(handles.value_fatness,'String', round((fatness-1)*100));end

set(handles.value_reffrequency,'String', freq0*10^-3)
set(handles.value_phase_variability,'String', round(stdphase0*10^4)/10^4)


%%% Calculation
if stdorientation == 0; stdorientation=eps; end
kL = 2*pi*frequency/c*ActualLength;
orientation = GaussianOrientation(phi, 90-meanorientation,stdorientation) ; 
[sigma, TS] = AverageTSorientation(BSsigma, orientation, phi) ;
[coeff, TSestim, kLestim, TSestimerror] = SDWBA_TS_function_coeff(kL, TS, 6) ;
delta_mean_error = round(mean(abs(TSestimerror)*100))/100 ;
coeff' 
%%% Plotting 
hold on
% changing color to the previous plots
H = findobj(gca,'Type','line') ;
set(H,'Color',[0.6 0.6 0.6],'MarkerEdgeColor',[0.6 0.6 0.6],'MarkerSize',1) 
H = findobj(gca,'Type','text') ;
set(H,'Color',[0.6 0.6 0.6]) 

hh(1) = line(frequency*1e-3,TS,'linewidth',1,'color',[0 0 0], 'Marker','.','MarkerSize',10,'MarkerEdgeColor','r') ; 
hh(2) = line(kLestim*1e-3/2/pi*c/ActualLength, TSestim,'linewidth',1,'color',[0 0 0],'linestyle',':') ;
hh(3) = plot(NaN,NaN,'w') ;
%%% plotting text
[mx,mxI] = max(TSestim);
Gauss_orient = ['N(' get(handles.edit_meanorientation,'String') ', ' get(handles.edit_stdorientation,'String') ')'];
ht = text(kLestim(mxI)*1e-3/2/pi*c/ActualLength, mx, Gauss_orient) ;
set(ht, 'FontSize',10, 'VerticalAlignment','bottom', 'HorizontalAlignment','center');

xlabel('Frequency (kHz)') ; ylabel('TS (dB)') ; box on ;
set(gca,'FontSize',12)
legend(hh, ['   SDWBA         ' Gauss_orient],' <SDWBA>', ['    mean error = ' num2str(delta_mean_error) ' dB'],'Location','Best')
hold off
else
 errordlg([ handles.session_name ' is not a Database!'],'SDWBApackage2010: warning!')   
end
guidata(hObject, handles);
 


 % --- Executes on button press in pushbutton_Cancel.
function pushbutton_Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Update handles structure
guidata(hObject, handles);
%delete(handles.figure1)
delete(gcbf)
 

 

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 

% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Update handles structure
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit_new_length as text
%        str2double(get(hObject,'String')) returns contents of edit_new_length as a double


% --- Executes during object creation, after setting all properties.
function edit_new_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 
% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 
% --- Executes during object creation, after setting all properties.
function edit_session_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

 

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Browse_session.
function Browse_session_Callback(hObject, eventdata, handles)
% hObject    handle to Browse_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.mat','SDWBApackage2010: Select folder and Database to be analyzed') ;
handles.session_path = PathName ;
handles.session_name = FileName(1:end-4) ;
set(handles.edit_session,'String', [PathName FileName]) ;
set(handles.axes2,'Visible','off') ;
cla;
legend OFF ;
set(handles.uipanel_Parameters,'Visible','off') ;
plot_bottom_Callback(hObject, eventdata, handles) ;
guidata(hObject, handles)

 
 

% --- Executes during object creation, after setting all properties.
function edit_meanorientation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_meanorientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes during object creation, after setting all properties.
function edit_stdorientation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stdorientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


 

% --- Executes during object creation, after setting all properties.
function edit_new_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global c coeff ActualLength L0

meanorientation = str2num(get(handles.edit_meanorientation,'String')) ;
stdorientation = str2num(get(handles.edit_stdorientation,'String')) ;
Filename = get(handles.edit_session,'String') ;
load(Filename);

kL = 2*pi*frequency/c*ActualLength;
orientation = GaussianOrientation(phi, 90-meanorientation,stdorientation);
[sigma, TS] = AverageTSorientation(BSsigma, orientation, phi);
[coeff, TSestim, kLestim, TSestimerror] = SDWBA_TS_function_coeff(kL, TS, 6);

new_length = str2num(get(handles.edit_new_length,'String')) * 10^-3 ;
new_freq = str2num(get(handles.edit_new_frequency,'String'))  ;

TS_Simplified = Calculate_Simplified_TS_SDWBA(new_freq * 10^3, new_length) 

delta_mean_error = round(mean(abs(TSestimerror)*100))/100 ;

set(handles.text_TS,'Visible','on')
set(handles.value_TS,'Visible','on')
set(handles.value_TS,'String', round(TS_Simplified*100)/100)
hold on
plot(new_freq,TS_Simplified,'ob')
hold off



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 

mean_orientation = str2num(get(handles.edit_meanorientation,'String')) ;
std_orientation = str2num(get(handles.edit_stdorientation,'String')) ;
Filename = get(handles.edit_session,'String') ;
load(Filename);


%%% Calculation
kL = 2*pi*frequency/c*ActualLength;
orientation = GaussianOrientation(phi, 90-mean_orientation,std_orientation);
[sigma, TS] = AverageTSorientation(BSsigma, orientation, phi);
[coeff, TSestim, kLestim, TSestimerror] = SDWBA_TS_function_coeff(kL, TS, 6);
delta_mean_error = round(mean(abs(TSestimerror)*100))/100 ;

A0 = coeff(1:4);
p = coeff(5:end);
A=A0(1); B=A0(2); C=A0(3); D=p(1); E=p(2); F=p(3); G=p(4); H=p(5); I=p(6); J=p(7)+A0(4); 
dirname = handles.session_path ;
filename = handles.session_name ; 
Processing_Date = datestr(now);
%%% Check if the results file already exist
AZZ = 1 ;
file2save = [sprintf('%s_N%.0f_%.0f',filename,mean_orientation,std_orientation)] ;

if exist([file2save '.mat'],'file')
    ButtonName = questdlg([file2save '.mat already exists! do you want replace it?'],...
        'SDWBApackage2010: saving','Replace','Cancel','default') ;
    switch ButtonName
        case 'Replace'
            AZZ = 1 ;
        case 'Cancel'
            AZZ = 0 ;
    end
end
  
if AZZ == 1
     
    %%% create the struct array COEFFICIENTS_Simply
    stri.string = char(['Simplified SDWBA TS polynomial coefficients'],['referred to L0=' num2str(L0*1000) ' mm with ' num2str(round((fatness_factor-1)*100)) '% fatness'],sprintf('for the distribution of orientations N(%d,%d):\r',mean_orientation,std_orientation),' ');
    varia = ['A';'B';'C';'D';'E';'F';'G';'H';'I';'J'] ;
for kkk = 1:10
    eval(['stri. ' varia(kkk,:) ' = ' varia(kkk,:) ';'])
    eval(['ec_re = real(' varia(kkk,:) ') ;'])
    eval(['ec_im = imag(' varia(kkk,:) ') ;'])
    if eval(['isreal(' varia(kkk,:) ')'])
      ecco = sprintf('% +5s %+.8e',[varia(kkk,:) ' ='],ec_re); 
    else
    ecco = sprintf('% +5s %+.8e  %+.8ei',[varia(kkk,:) ' ='], ec_re, ec_im) ;   
    end
    stri.string = char(stri.string,ecco) ;
    clear ec_re ec_im ecco
end
    COEFFICIENTS_Simply = stri ; 
    clear stri varia kkk

%%% saving and display    
freq_simply = kLestim/2/pi*c/ActualLength ;     % the frequencies used by the fitting process 
save(strcat(dirname,file2save),'COEFFICIENTS_Simply','A0','p','coeff','Animal_shape_file','frequency','TS','TSestim','freq_simply','phi','orientation','L0','h0','g0','fatness_factor','scaling_factor','N0','stdphase0','freq0','ActualLength','c','mean_orientation','std_orientation','Processing_Date','TSestimerror','delta_mean_error');
hea = '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%';

hhh = msgbox(char(['Results saved in:  ' file2save '.mat'],[' ';' '], hea(1,1:25),' ', COEFFICIENTS_Simply.string,[' ';' ']) , 'SDWBApackage2010: saving');

disp(char(' ', hea, ' ',COEFFICIENTS_Simply.string,' ' ,hea))

%         disp({'%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%';
%             sprintf('Simplified SDWBA TS polynomial coefficient for N(%d,%d):\r',mean_orientation,std_orientation);
%             sprintf('A = %+.8e  %+.8ei',real(A), imag(A));
%             sprintf('B = %+.8e  %+.8ei',real(B), imag(B));
%             sprintf('C = %+.8e  %+.8ei',real(C), imag(C));
%             sprintf('D = %+.8e', D);
%             sprintf('E = %+.8e', E);
%             sprintf('F = %+.8e', F);
%             sprintf('G = %+.8e', G);
%             sprintf('H = %+.8e', H);
%             sprintf('I = %+.8e', I);
%             sprintf('J = %+.8e  %+.8ei',real(J), imag(J))});
        
 
clear
end

 


% --- Executes during object creation, after setting all properties.
function uipanel_TS_calculation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_TS_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_TS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_TS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_meanorientation_Callback(hObject, eventdata, handles)
% hObject    handle to edit_meanorientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_meanorientation as text
%        str2double(get(hObject,'String')) returns contents of edit_meanorientation as a double



function edit_stdorientation_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stdorientation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stdorientation as text
%        str2double(get(hObject,'String')) returns contents of edit_stdorientation as a double



function edit_new_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_new_frequency as a double

 


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
