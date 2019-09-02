function varargout = Check_the_digitalized_shape(varargin)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   SDWBApackage2010, version 1.0
%
%
%   Check_the_digitalized_shape.m
%   GUI program within the SDWBApackage2010 implemented to 
%   check the digitalized shape of the organism processed by the
%   SDWBApackage2010
%   
%   First, the program shows the main parameters 
%   of the reference shape:
%   Numer of cylinders, AT length and fatness, as well as
%   the frequency and phase variability related to the 
%   comparison between empirical measurements andf predictions.
%
%   In addiction, it is possible to check the resampled shape
%   for frequency higher than the reference as processed by the
%   SDWBApackage2010
%
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
% CHECK_THE_DIGITALIZED_SHAPE MATLAB code for Check_the_digitalized_shape.fig
%      CHECK_THE_DIGITALIZED_SHAPE, by itself, creates a new CHECK_THE_DIGITALIZED_SHAPE or raises the existing
%      singleton*.
%
%      H = CHECK_THE_DIGITALIZED_SHAPE returns the handle to a new CHECK_THE_DIGITALIZED_SHAPE or the handle to
%      the existing singleton*.
%
%      CHECK_THE_DIGITALIZED_SHAPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CHECK_THE_DIGITALIZED_SHAPE.M with the given input arguments.
%
%      CHECK_THE_DIGITALIZED_SHAPE('Property','Value',...) creates a new CHECK_THE_DIGITALIZED_SHAPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Check_the_digitalized_shape_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Check_the_digitalized_shape_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Check_the_digitalized_shape

% Last Modified by GUIDE v2.5 17-Aug-2011 12:43:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Check_the_digitalized_shape_OpeningFcn, ...
                   'gui_OutputFcn',  @Check_the_digitalized_shape_OutputFcn, ...
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

% --- Executes just before Check_the_digitalized_shape is made visible.
function Check_the_digitalized_shape_OpeningFcn(hObject, eventdata, handles, fileshape,L0,N0,fat,f0,stdph0,pathname)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Check_the_digitalized_shape (see VARARGIN)

% Choose default command line output for Check_the_digitalized_shape
handles.output = hObject;
warning off ;

path(path,'Bin\') ; path(path,'Auxiliary\') ;

handles.pathname = pathname ; 
set(handles.file_shape,'String', [pathname fileshape '.mat']) 
set(handles.value_cylinders,'String', N0) 
set(handles.value_length,'String', L0)
set(handles.value_fatness,'String', fat)
set(handles.value_frequency,'String', f0)
set(handles.value_standard_phase,'String', round(stdph0*10^4)/10^4)

% This sets up the initial plot - only do when we are invisible
% so window can get raised using Check_the_digitalized_shape.

if strcmp(get(hObject,'Visible'),'off')
    fileshape = get(handles.file_shape,'String') ;
    load(fileshape);
    %%% imposing the fatness
    a = a * (str2num(fat)*10^-2+1) ;
    plot_the_krill_shape(r,a,f0,f0,stdph0);

%%% volume calculation
V = Volume_Shape(r,a) ;
set(handles.value_volume,'String', num2str(round(V*1000)/1000))
end
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Check_the_digitalized_shape wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Check_the_digitalized_shape_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in plot_bottom.
function plot_bottom_Callback(hObject, eventdata, handles,fileshape,L0,fat,f0,stdph0,pathname)
% hObject    handle to plot_bottom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
cla;

set(handles.text_new_cylinders,'Visible', 'on')
set(handles.text_new_phase_variability,'Visible', 'on')
set(handles.text_new_volume,'Visible', 'on')
set(handles.value_new_cylinders,'Visible', 'on')
set(handles.value_new_phase_variability,'Visible', 'on')
set(handles.value_new_volume,'Visible', 'on')

fileshape = get(handles.file_shape,'String') ;
load(fileshape);
fat = str2num(get(handles.value_fatness,'String')) ;
a=a*(fat*10^-2+1);
f = str2num(get(handles.edit_new_frequency,'String')) *10^3 ;
ff0 = str2num(get(handles.value_frequency,'String')) *10^3 ;

f0 = str2num(get(handles.value_frequency,'String')) *10^3 ;
stdph0 = eval(get(handles.value_standard_phase,'String')) ;

[new_N,new_stdph] = plot_the_krill_shape(r,a,f0,f,stdph0);
set(handles.value_new_cylinders,'String',num2str(new_N))
set(handles.value_new_phase_variability,'String',num2str(round(new_stdph*10^4)/10^4))

V = Volume_Shape(r,a) ;
set(handles.value_new_volume,'String', num2str(round(V*1000)/1000))







% --- Executes on button press in pushbutton_Cancel.
function pushbutton_Cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Update handles structure
guidata(hObject, handles);
%delete(handles.figure1)
delete(gcbf)



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


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



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


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



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


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



function edit_new_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Update handles structure
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of edit_new_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_new_frequency as a double


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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


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
function file_shape_CreateFcn(hObject, eventdata, handles)
% hObject    handle to file_shape (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text_new_cylinders_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_new_cylinders (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on key press with focus on plot_bottom and none of its controls.
function plot_bottom_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to plot_bottom (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
