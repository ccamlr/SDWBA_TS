function varargout = GUI_Estimation_SDWBA2010_TS(varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%   GUI_Estimation_SDWBA2010_TS.m
%   GUI program within the SDWBApackage2010 implemented to 
%   A window interface will show up and the different parameters 
%   for the model can be changed from the default values. 
%   These are stored in the script Default_parameters.m included 
%   in the "bin" folder.
%   By placing the pointer on one item shows a tooltip related 
%   to the parameter.

%   The window interface is the main formal difference between 
%   this package and the SDWBApackage20050603. 
%   It is composed of four panels. Read the file ReadmeSDWBApackage2010.txt
%   for more information.
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




% GUI_ESTIMATION_SDWBA2010_TS MATLAB code for GUI_Estimation_SDWBA2010_TS.fig
%      GUI_ESTIMATION_SDWBA2010_TS, by itself, creates a new GUI_ESTIMATION_SDWBA2010_TS or raises the existing
%      singleton*.
%
%      H = GUI_ESTIMATION_SDWBA2010_TS returns the handle to a new GUI_ESTIMATION_SDWBA2010_TS or the handle to
%      the existing singleton*.
%
%      GUI_ESTIMATION_SDWBA2010_TS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_ESTIMATION_SDWBA2010_TS.M with the given input arguments.
%
%      GUI_ESTIMATION_SDWBA2010_TS('Property','Value',...) creates a new GUI_ESTIMATION_SDWBA2010_TS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Estimation_SDWBA2010_TS_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Estimation_SDWBA2010_TS_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Estimation_SDWBA2010_TS

% Last Modified by GUIDE v2.5 20-Jun-2011 15:54:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Estimation_SDWBA2010_TS_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Estimation_SDWBA2010_TS_OutputFcn, ...
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

 

% --- Executes just before GUI_Estimation_SDWBA2010_TS is made visible.
function GUI_Estimation_SDWBA2010_TS_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Estimation_SDWBA2010_TS (see VARARGIN)

% Choose default command line output for GUI_Estimation_SDWBA2010_TS
handles.output = hObject;
            % data = guidata(hObject)
            % n = fieldnames(handles)
% Update handles structure
guidata(hObject, handles); 
path(path,'Bin\') ; path(path,'Auxiliary\') ;
Default_parameters

%%% Saving
set(handles.value_session,'String',file2save)
set(handles.value_saving_folder,'String',dirname)
  
%%% Key Parameters
set(handles.AT_length_value,'String',ActualLength)
set(handles.density_contrast_value,'String',g0)
set(handles.sound_speed_contrast_value,'String',h0)
set(handles.seawater_sound_speed_value,'String',c)

%%% Basic Parameters
set(handles.animal_shape_file_value,'String',fileshape)

load(fileshape)
N0 = length(a)-1;
set(handles.number_of_cylinders_value,'String',N0)
set(handles.reference_length_value,'String',L0)
set(handles.fatness_coefficient_value,'String',fatness)
set(handles.reference_frequency_value,'String',freq0)
set(handles.phase_variability_value,'String', stdphase0)  

handles.animal_shape_path = [pwd '\'] ;

%%% Operational Parameters
if  strcmp(radiobuttom_frequency_range(1:2), 'on')
set(handles.button_frequency_range,'Value',1,'ForegroundColor',[0 0 0])
set(handles.button_frequency_discrete,'Value',0,'ForegroundColor',[0.502 0.502 0.502])
set(handles.frequency_range_value_min,'String',frequency_min,'ForegroundColor','b')
set(handles.frequency_range_value_step,'String',frequency_step,'ForegroundColor','b')
set(handles.frequency_range_value_max,'String',frequency_max,'ForegroundColor','b')
set(handles.value_discrete_frequency,'String',discrete_frequency,'ForegroundColor',[0.502 0.502 0.502])
else
set(handles.button_frequency_range,'Value',0,'ForegroundColor',[0.502 0.502 0.502])
set(handles.button_frequency_discrete,'Value',1,'ForegroundColor','b')
set(handles.frequency_range_value_min,'String',frequency_min,'ForegroundColor',[0.502 0.502 0.502])
set(handles.frequency_range_value_step,'String',frequency_step,'ForegroundColor',[0.502 0.502 0.502])
set(handles.frequency_range_value_max,'String',frequency_max,'ForegroundColor',[0.502 0.502 0.502])
set(handles.value_discrete_frequency,'String',discrete_frequency,'ForegroundColor','b')
end    

if  strcmp(radiobuttom_incidence_range(1:2), 'on')
set(handles.button_incidence_range,'Value',1,'ForegroundColor',[0 0 0])
set(handles.button_incidence_discrete,'Value',0,'ForegroundColor',[0.502 0.502 0.502])
set(handles.incidence_angles_value_min,'String',theta_min,'ForegroundColor','b')
set(handles.incidence_angles_value_step,'String',theta_step,'ForegroundColor','b')
set(handles.incidence_angles_value_max,'String',theta_max,'ForegroundColor','b')
set(handles.value_discrete_incidence,'String',discrete_incidence,'ForegroundColor',[0.502 0.502 0.502])
else
    set(handles.button_incidence_range,'Value',0,'ForegroundColor',[0.502 0.502 0.502])
set(handles.button_incidence_discrete,'Value',1,'ForegroundColor',[0 0 0])
set(handles.incidence_angles_value_min,'String',theta_min,'ForegroundColor',[0.502 0.502 0.502])
set(handles.incidence_angles_value_step,'String',theta_step,'ForegroundColor',[0.502 0.502 0.502])
set(handles.incidence_angles_value_max,'String',theta_max,'ForegroundColor',[0.502 0.502 0.502])
set(handles.value_discrete_incidence,'String',discrete_incidence,'ForegroundColor','b')
end
set(handles.stochastic_realizations_value,'String',noise_realisations)

guidata(hObject, handles) ;

% UIWAIT makes GUI_Estimation_SDWBA2010_TS wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Executes during object creation, after setting all properties.
function key_parameters_CreateFcn(hObject, eventdata, handles)
name_Panel_1 = 'Key Parameters' ;
set(hObject,'Title', name_Panel_1)
% hObject    handle to key_parameters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Estimation_SDWBA2010_TS_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function AT_length_value_Callback(hObject, eventdata, handles)
% hObject    handle to AT_length_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AT_length_value as text
%        str2double(get(hObject,'String')) returns contents of AT_length_value as a double


% --- Executes during object creation, after setting all properties.
function AT_length_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AT_length_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function density_contrast_value_Callback(hObject, eventdata, handles)
% hObject    handle to density_contrast_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of density_contrast_value as text
%        str2double(get(hObject,'String')) returns contents of density_contrast_value as a double


% --- Executes during object creation, after setting all properties.
function density_contrast_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to density_contrast_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sound_speed_contrast_value_Callback(hObject, eventdata, handles)
% hObject    handle to sound_speed_contrast_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sound_speed_contrast_value as text
%        str2double(get(hObject,'String')) returns contents of sound_speed_contrast_value as a double


% --- Executes during object creation, after setting all properties.
function sound_speed_contrast_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sound_speed_contrast_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function seawater_sound_speed_value_Callback(hObject, eventdata, handles)
% hObject    handle to seawater_sound_speed_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of seawater_sound_speed_value as text
%        str2double(get(hObject,'String')) returns contents of seawater_sound_speed_value as a double


% --- Executes during object creation, after setting all properties.
function seawater_sound_speed_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to seawater_sound_speed_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function animal_shape_file_value_Callback(hObject, eventdata, handles)
% hObject    handle to animal_shape_file_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of animal_shape_file_value as text
%        str2double(get(hObject,'String')) returns contents of animal_shape_file_value as a double


% --- Executes during object creation, after setting all properties.
function animal_shape_file_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to animal_shape_file_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
handles.animal_shape_path = [pwd '\'] ;
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles);




function reference_length_value_Callback(hObject, eventdata, handles)
% hObject    handle to reference_length_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reference_length_value as text
%        str2double(get(hObject,'String')) returns contents of reference_length_value as a double


% --- Executes during object creation, after setting all properties.
function reference_length_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reference_length_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function number_of_cylinders_value_Callback(hObject, eventdata, handles)
% hObject    handle to number_of_cylinders_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of number_of_cylinders_value as text
%        str2double(get(hObject,'String')) returns contents of number_of_cylinders_value as a double


% --- Executes during object creation, after setting all properties.
function number_of_cylinders_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_of_cylinders_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fatness_coefficient_value_Callback(hObject, eventdata, handles)
% hObject    handle to fatness_coefficient_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fatness_coefficient_value as text
%        str2double(get(hObject,'String')) returns contents of fatness_coefficient_value as a double


% --- Executes during object creation, after setting all properties.
function fatness_coefficient_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fatness_coefficient_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function reference_frequency_value_Callback(hObject, eventdata, handles)
% hObject    handle to reference_frequency_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of reference_frequency_value as text
%        str2double(get(hObject,'String')) returns contents of reference_frequency_value as a double


% --- Executes during object creation, after setting all properties.
function reference_frequency_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to reference_frequency_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function phase_variability_value_Callback(hObject, eventdata, handles)
% hObject    handle to phase_variability_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of phase_variability_value as text
%        str2double(get(hObject,'String')) returns contents of phase_variability_value as a double


% --- Executes during object creation, after setting all properties.
function phase_variability_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phase_variability_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in animal_shape_file_browse.
function animal_shape_file_browse_Callback(hObject, eventdata, handles)
% hObject    handle to animal_shape_file_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName] = uigetfile('*.mat','Select folder and the .mat krill shape file') ;
handles.animal_shape_path = PathName ;
FileName = FileName(1:end-4);
set(handles.animal_shape_file_value,'String',FileName);
load([PathName FileName])
N0 = length(a)-1;
set(handles.number_of_cylinders_value,'String',N0)

HH = [handles.AT_length_value; handles.reference_length_value; handles.fatness_coefficient_value; handles.reference_frequency_value] ;
set(HH,'String','')

guidata(hObject, handles); 
 


function stochastic_realizations_value_Callback(hObject, eventdata, handles)
% hObject    handle to stochastic_realizations_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stochastic_realizations_value as text
%        str2double(get(hObject,'String')) returns contents of stochastic_realizations_value as a double


% --- Executes during object creation, after setting all properties.
function stochastic_realizations_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stochastic_realizations_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function incidence_angles_value_min_Callback(hObject, eventdata, handles)
% hObject    handle to incidence_angles_value_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of incidence_angles_value_min as text
%        str2double(get(hObject,'String')) returns contents of incidence_angles_value_min as a double


% --- Executes during object creation, after setting all properties.
function incidence_angles_value_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to incidence_angles_value_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function incidence_angles_value_step_Callback(hObject, eventdata, handles)
% hObject    handle to incidence_angles_value_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of incidence_angles_value_step as text
%        str2double(get(hObject,'String')) returns contents of incidence_angles_value_step as a double


% --- Executes during object creation, after setting all properties.
function incidence_angles_value_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to incidence_angles_value_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function incidence_angles_value_max_Callback(hObject, eventdata, handles)
% hObject    handle to incidence_angles_value_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of incidence_angles_value_max as text
%        str2double(get(hObject,'String')) returns contents of incidence_angles_value_max as a double


% --- Executes during object creation, after setting all properties.
function incidence_angles_value_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to incidence_angles_value_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequency_range_value_min_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_range_value_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency_range_value_min as text
%        str2double(get(hObject,'String')) returns contents of frequency_range_value_min as a double


% --- Executes during object creation, after setting all properties.
function frequency_range_value_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_range_value_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequency_range_value_step_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_range_value_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency_range_value_step as text
%        str2double(get(hObject,'String')) returns contents of frequency_range_value_step as a double


% --- Executes during object creation, after setting all properties.
function frequency_range_value_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_range_value_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequency_range_value_max_Callback(hObject, eventdata, handles)
% hObject    handle to frequency_range_value_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequency_range_value_max as text
%        str2double(get(hObject,'String')) returns contents of frequency_range_value_max as a double


% --- Executes during object creation, after setting all properties.
function frequency_range_value_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequency_range_value_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_the_shape.
function check_the_shape_Callback(hObject, eventdata, handles)
% hObject    handle to check_the_shape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pathname = handles.animal_shape_path ;
fileshape = get(handles.animal_shape_file_value,'String') ;
L0 = get(handles.reference_length_value,'String') ;
N0 = get(handles.number_of_cylinders_value,'String') ;
fat = get(handles.fatness_coefficient_value,'String') ;
f0 = get(handles.reference_frequency_value,'String') ;
stdph0 = eval(get(handles.phase_variability_value,'String')) ;
Check_the_digitalized_shape(fileshape,L0,N0,fat,f0,stdph0,pathname)

% --- Executes on key press with focus on animal_shape_file_value and none of its controls.
function animal_shape_file_value_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to animal_shape_file_value (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Update handles structure
guidata(hObject, handles);
%delete(handles.figure1)
delete(gcbf)


% --- Executes on button press in pushbutton_OK.
function pushbutton_OK_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_OK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%%%%%%%%%%%%%%%%%%%%%%%%  INPUT  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
currentdir = pwd;
 
%%% Storaging
file2save = get(handles.value_session,'String') ;
dirname = get(handles.value_saving_folder,'String') ;

%%% Key Parameters
ActualLength = str2num(get(handles.AT_length_value,'String')) * 1e-3  ;             % VIP! Length in (m)
g0 = str2num(get(handles.density_contrast_value,'String')) ;
h0 = str2num(get(handles.sound_speed_contrast_value,'String')) ;
c = str2num(get(handles.seawater_sound_speed_value,'String')) ;

%%% Basic Parameters
Animal_shape_path = handles.animal_shape_path ;
Animal_shape_file = get(handles.animal_shape_file_value,'String') ;
fileshape = [Animal_shape_path Animal_shape_file] ;
load(fileshape)

N0 = length(a)-1 ;
L0 = str2num(get(handles.reference_length_value,'String')) * 1e-3 ;                 % VIP! Length in (m)
fatness_factor = str2num(get(handles.fatness_coefficient_value,'String'))*10^-2+1 ; % from percent to factor
freq0 = str2num(get(handles.reference_frequency_value,'String'))*1e3 ;              % VIP! Frequency in (Hz)
stdphase0 = eval(get(handles.phase_variability_value,'String')) ;
 
%%% Operational Parameters
% Frequency
if  get(handles.button_frequency_range,'Value')
    mi = get(handles.frequency_range_value_min,'String') ;
    step = get(handles.frequency_range_value_step,'String') ;
    ma = get(handles.frequency_range_value_max,'String') ;
    eval(['frequency = [' mi ':' step ':' ma ']*1e3 ;'])
else
    eval(['frequency = ' get(handles.value_discrete_frequency,'String') '*1e3 ;'])
end
 
% Incidence Angle
if  get(handles.button_incidence_range,'Value')
    mi = get(handles.incidence_angles_value_min,'String') ;
    step = get(handles.incidence_angles_value_step,'String') ;
    ma = get(handles.incidence_angles_value_max,'String') ;
    eval(['phi = [' mi ':' step ':' ma '] ;'])
else
    eval(['phi = ' get(handles.value_discrete_frequency,'String') ';'])
end

noise_realisations = str2num(get(handles.stochastic_realizations_value,'String')) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
AZZ = 1 ;
 
if exist([file2save '.mat'],'file')
    ButtonName = questdlg(['Database ' file2save '.mat already exists! do you want replace it?'],...
        'SDWBApackage2010: saving', 'Replace', 'Cancel', 'default') ;
    switch ButtonName
        case 'Replace'
            AZZ = 1 ;
        case 'Cancel'
            AZZ = 0 ;
            GUI_Estimation_SDWBA2010_TS
    end
end
  
if AZZ == 1

phi = 90 + phi ;
kL = 2*pi*frequency / c * ActualLength ;        % wave number
a = a * fatness_factor ;                        % fatness correction

%%% Scaling
scaling_factor = ActualLength/L0 ;                     
r = r * scaling_factor ;
a = a * scaling_factor ;


%%% Create the data folder 
if ~exist(dirname,'dir')
    mkdir(dirname);
end

if ~exist(strcat(dirname,'\dataSDWBA'),'dir')
    mkdir(strcat(dirname,'\dataSDWBA'))
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Processing loop based on number of stochastic realizations

for irealisation = 1:noise_realisations
    [BSTS,BSsigma,form_function,Stdphase_vs_freq,Cylinders_vs_freq] = BSTS_SDWBA_2010(frequency,r,a,h0,g0,phi,[stdphase0 freq0 N0],c,[irealisation noise_realisations],file2save);
     %% Saving the iteration
    save(strcat(dirname,'\dataSDWBA\',sprintf('%s_%d',file2save,irealisation)),'Animal_shape_file','L0','ActualLength','fatness_factor','N0','stdphase0','freq0','g0','h0','scaling_factor','noise_realisations','BSTS','BSsigma','frequency','phi','form_function','ActualLength','c','Stdphase_vs_freq','Cylinders_vs_freq')
end
BSsigmatot = zeros(size(BSsigma,1),size(BSsigma,2),noise_realisations);
clear BSTS BSsigma

for irealisation = 1:noise_realisations
    load(strcat(dirname,'\dataSDWBA\',sprintf('%s_%d',file2save,irealisation)))
    BSsigmatot(:,:,irealisation) = BSsigma;
end
BSsigma_StandardDeviation = std(BSsigmatot,[],3);
BSsigma = mean(BSsigmatot,3);
BSTS = 10*log10(BSsigma) ;
Processing_Date = datestr(now);
save(strcat(dirname,'\',file2save),'file2save','Animal_shape_file','Processing_Date','L0','fatness_factor','N0','stdphase0','freq0','g0','h0','scaling_factor','noise_realisations','frequency','BSTS','BSsigma','phi','BSsigma_StandardDeviation','ActualLength','c','a','r','Stdphase_vs_freq','Cylinders_vs_freq');
end
clear
 


% --- Executes on button press in pushbutton_reset.
function pushbutton_reset_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 GUI_Estimation_SDWBA2010_TS_OpeningFcn(hObject, [], handles, [])





function value_session_Callback(hObject, eventdata, handles)
% hObject    handle to value_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_session as text
%        str2double(get(hObject,'String')) returns contents of value_session as a double


% --- Executes during object creation, after setting all properties.
function value_session_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_session (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function value_saving_folder_Callback(hObject, eventdata, handles)
% hObject    handle to value_saving_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_saving_folder as text
%        str2double(get(hObject,'String')) returns contents of value_saving_folder as a double


% --- Executes during object creation, after setting all properties.
function value_saving_folder_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_saving_folder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in saving_directory_browse.
function saving_directory_browse_Callback(hObject, eventdata, handles)
% hObject    handle to saving_directory_browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
set(handles.value_saving_folder,'String',folder_name)
guidata(hObject, handles);


 



function value_discrete_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to value_discrete_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_discrete_frequency as text
%        str2double(get(hObject,'String')) returns contents of value_discrete_frequency as a double


% --- Executes during object creation, after setting all properties.
function value_discrete_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_discrete_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 


% --- Executes when selected object is changed in uipanel_frequency.
function uipanel_frequency_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_frequency 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.button_frequency_range)
    set(handles.button_frequency_range,'ForegroundColor',[0 0 0])
    set(handles.frequency_range_value_min,'ForegroundColor','b')
    set(handles.frequency_range_value_max,'ForegroundColor','b')
    set(handles.frequency_range_value_step,'ForegroundColor','b')
    set(handles.text14,'ForegroundColor','b')
    set(handles.text15,'ForegroundColor','b')
  
    set(handles.button_frequency_discrete,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.value_discrete_frequency,'ForegroundColor',[0.502 0.502 0.502])     
else
    set(handles.button_frequency_discrete,'ForegroundColor',[0 0 0])
    set(handles.value_discrete_frequency,'ForegroundColor','b')      
    
    set(handles.button_frequency_range,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.frequency_range_value_min,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.frequency_range_value_max,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.frequency_range_value_step,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.text14,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.text15,'ForegroundColor',[0.502 0.502 0.502])
    
end
    
    



function value_discrete_incidence_Callback(hObject, eventdata, handles)
% hObject    handle to value_discrete_incidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of value_discrete_incidence as text
%        str2double(get(hObject,'String')) returns contents of value_discrete_incidence as a double


% --- Executes during object creation, after setting all properties.
function value_discrete_incidence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to value_discrete_incidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in uipanel_angle_of_incidence.
function uipanel_angle_of_incidence_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel_angle_of_incidence 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
if (hObject == handles.button_incidence_range)
    set(handles.button_incidence_range,'ForegroundColor',[0 0 0])
    set(handles.incidence_angles_value_min,'ForegroundColor','b')
    set(handles.incidence_angles_value_max,'ForegroundColor','b')
    set(handles.incidence_angles_value_step,'ForegroundColor','b')
    set(handles.text16,'ForegroundColor','b')
    set(handles.text17,'ForegroundColor','b')
  
    set(handles.button_incidence_discrete,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.value_discrete_incidence,'ForegroundColor',[0.502 0.502 0.502])     
else
    set(handles.button_incidence_discrete,'ForegroundColor',[0 0 0])
    set(handles.value_discrete_incidence,'ForegroundColor','b')      
    
    set(handles.button_incidence_range,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.incidence_angles_value_min,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.incidence_angles_value_max,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.incidence_angles_value_step,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.text16,'ForegroundColor',[0.502 0.502 0.502])
    set(handles.text17,'ForegroundColor',[0.502 0.502 0.502])
    
end
