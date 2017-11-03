function varargout = MF_Tire_GUI_V2a(varargin)
% MF_Tire_GUI_V2a MATLAB code for MF_Tire_GUI_V2a.fig
%      MF_Tire_GUI_V2a, by itself, creates a new MF_Tire_GUI_V2a or raises the existing
%      singleton*.
%
%      H = MF_Tire_GUI_V2a returns the handle to a new MF_Tire_GUI_V2a or the handle to
%      the existing singleton*.
%
%      MF_Tire_GUI_V2a('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MF_Tire_GUI_V2a.M with the given input arguments.
%
%      MF_Tire_GUI_V2a('Property','Value',...) creates a new MF_Tire_GUI_V2a or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MF_Tire_GUI_V2a_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MF_Tire_GUI_V2a_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MF_Tire_GUI_V2a

% Last Modified by GUIDE v2.5 26-Aug-2015 11:38:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MF_Tire_GUI_V2a_OpeningFcn, ...
                   'gui_OutputFcn',  @MF_Tire_GUI_V2a_OutputFcn, ...
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


% --- Executes just before MF_Tire_GUI_V2a is made visible.
function MF_Tire_GUI_V2a_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MF_Tire_GUI_V2a (see VARARGIN)

% Choose default command line output for MF_Tire_GUI_V2a
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MF_Tire_GUI_V2a wait for user response (see UIRESUME)
% uiwait(handles.figure1);

load([pwd '\MF52_par0.mat'])
handles.Start_MF52Par= [Pcx1 Pdx1 Pdx2 Pex1 Pex2 Pex3 Pex4 Pkx1 Pkx2 Pkx3 Phx1 Phx2 Pvx1 Pvx2];
guidata(hObject,handles);


% --- Outputs from this function are returned to the command line.
function varargout = MF_Tire_GUI_V2a_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on slider movement.
function Pcx1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pcx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


a=num2str(get(handles.Pcx1_slider,'value'));
set(handles.Text_Pcx1,'String',a);


% --- Executes during object creation, after setting all properties.
function Pcx1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pcx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in Plot_Button.
function Plot_Button_Callback(hObject, eventdata, handles)
% hObject    handle to Plot_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Pac_MF52=get(handles.MF52_checkbox,'value');
Pac_96=get(handles.Pac96_checkbox,'value');
hold_on=get(handles.hold_checkbox,'value');

if (Pac_MF52+Pac_96==0)
    error('Please Choose one of the two Pacejka Models');
    set(handles.Error_text,'String','Error: Please Choose one of the two Pacejka Models');
else
    set(handles.Error_text,'String','');
    NominalForce=1125.65;
    %get variables from Edit Text boxes
    NormalForce=str2num(get(handles.NormalForce_editT,'string'));
    slipStart=str2num(get(handles.SlpStart_editT,'string'))/100;
    slipEnd=str2num(get(handles.SlpEnd_editT,'string'))/100;

    %get variables from Slider widgets
    Pcx1=get(handles.Pcx1_slider,'value');
    Pdx1=get(handles.Pdx1_slider,'value');
    Pdx2=get(handles.Pdx2_slider,'value');
    Pex1=get(handles.Pex1_slider,'value');
    Pex2=get(handles.Pex2_slider,'value');
    Pex3=get(handles.Pex3_slider,'value');
    Pex4=get(handles.Pex4_slider,'value');
    Pkx1=get(handles.Pkx1_slider,'value');
    Pkx2=get(handles.Pkx2_slider,'value');
    Pkx3=get(handles.Pkx3_slider,'value');
    Phx1=get(handles.Phx1_slider,'value');
    Phx2=get(handles.Phx2_slider,'value');
    Pvx1=get(handles.Pvx1_slider,'value');
    Pvx2=get(handles.Pvx2_slider,'value');

    MF_par= [Pcx1 Pdx1 Pdx2 Pex1 Pex2 Pex3 Pex4 Pkx1 Pkx2 Pkx3 Phx1 Phx2 Pvx1 Pvx2];
    K= slipStart:0.02:slipEnd;
    
    if Pac_MF52==1
        Shx=(Phx1 + Phx2 *(NormalForce/10000))*1;
        Kx= K*100+ Shx;
        [Fx0,MF_macro_par]= MF52_LongForce_calc(MF_par,Kx,NormalForce);
        slp4plot= Kx/100;
        handles.Current_TP_Design= MF_par;
        guidata(hObject,handles);
    else
        dfz=(NormalForce-NominalForce)/NominalForce;
        Shx=(Phx1 + Phx2 *dfz)*1;
        Kx= K+ Shx;
        [Fx0,MF_macro_par]= MF1996_LongForce_calc(MF_par,Kx,NormalForce,NominalForce);
        slp4plot= Kx;
        handles.Current_TP_Design= [];
        guidata(hObject,handles);
    end
    
    

    handles.figure1;
    plot(slp4plot,Fx0);
    grid on;
    ylabel('Longitudinal Force Fx (N)');
    xlabel('Slip Ratio ');
    
    if hold_on
        hold on;
    else
        hold off;
    end    

    set(handles.IstCx_text,'String',num2str(MF_macro_par.Cx));
    set(handles.IstDx_text,'String',num2str(MF_macro_par.Dx));
    set(handles.IstEx_text,'String',num2str(MF_macro_par.Ex));
    set(handles.IstBx_text,'String',num2str(MF_macro_par.Bx));
end

% --- Executes on button press in Debug_button.
function Debug_button_Callback(hObject, eventdata, handles)
% hObject    handle to Debug_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

keyboard;



function SlpStart_editT_Callback(hObject, eventdata, handles)
% hObject    handle to SlpStart_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SlpStart_editT as text
%        str2double(get(hObject,'String')) returns contents of SlpStart_editT as a double


% --- Executes during object creation, after setting all properties.
function SlpStart_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SlpStart_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function SlpEnd_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SlpEnd_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NormalForce_editT_Callback(hObject, eventdata, handles)
% hObject    handle to NormalForce_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NormalForce_editT as text
%        str2double(get(hObject,'String')) returns contents of NormalForce_editT as a double


% --- Executes during object creation, after setting all properties.
function NormalForce_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NormalForce_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function Pex2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pex2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pex2_slider,'value'));
set(handles.Text_Pex2,'String',a);



% --- Executes during object creation, after setting all properties.
function Pex2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pex2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pex1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pex1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pex1_slider,'value'));
set(handles.Text_Pex1,'String',a);


% --- Executes during object creation, after setting all properties.
function Pex1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pex1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pex3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pex3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pex3_slider,'value'));
set(handles.Text_Pex3,'String',a);


% --- Executes during object creation, after setting all properties.
function Pex3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pex3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pdx2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pdx2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pdx2_slider,'value'));
set(handles.Text_Pdx2,'String',a);


% --- Executes during object creation, after setting all properties.
function Pdx2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pdx2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pkx1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pkx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pkx1_slider,'value'));
set(handles.Text_Pkx1,'String',a);


% --- Executes during object creation, after setting all properties.
function Pkx1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pkx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pkx2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pkx2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pkx2_slider,'value'));
set(handles.Text_Pkx2,'String',a);


% --- Executes during object creation, after setting all properties.
function Pkx2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pkx2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pkx3_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pkx3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pkx3_slider,'value'));
set(handles.Text_Pkx3,'String',a);


% --- Executes during object creation, after setting all properties.
function Pkx3_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pkx3_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Phx1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Phx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Phx1_slider,'value'));
set(handles.Text_Phx1,'String',a);


% --- Executes during object creation, after setting all properties.
function Phx1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Phx2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Phx2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Phx2_slider,'value'));
set(handles.Text_Phx2,'String',a);


% --- Executes during object creation, after setting all properties.
function Phx2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Phx2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pvx1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pvx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pvx1_slider,'value'));
set(handles.Text_Pvx1,'String',a);


% --- Executes during object creation, after setting all properties.
function Pvx1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pvx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pdx1_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pdx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pdx1_slider,'value'));
set(handles.Text_Pdx1,'String',a);


% --- Executes during object creation, after setting all properties.
function Pdx1_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pdx1_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pvx2_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pvx2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pvx2_slider,'value'));
set(handles.Text_Pvx2,'String',a);


% --- Executes during object creation, after setting all properties.
function Pvx2_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pvx2_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Pex4_slider_Callback(hObject, eventdata, handles)
% hObject    handle to Pex4_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=num2str(get(handles.Pex4_slider,'value'));
set(handles.Text_Pex4,'String',a);


% --- Executes during object creation, after setting all properties.
function Pex4_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Pex4_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function Cx_editT_Callback(hObject, eventdata, handles)
% hObject    handle to Cx_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Cx_editT as text
%        str2double(get(hObject,'String')) returns contents of Cx_editT as a double


% --- Executes during object creation, after setting all properties.
function Cx_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Cx_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Dx_editT_Callback(hObject, eventdata, handles)
% hObject    handle to Dx_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Dx_editT as text
%        str2double(get(hObject,'String')) returns contents of Dx_editT as a double


% --- Executes during object creation, after setting all properties.
function Dx_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Dx_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ex_editT_Callback(hObject, eventdata, handles)
% hObject    handle to Ex_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ex_editT as text
%        str2double(get(hObject,'String')) returns contents of Ex_editT as a double


% --- Executes during object creation, after setting all properties.
function Ex_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ex_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Bx_editT_Callback(hObject, eventdata, handles)
% hObject    handle to Bx_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Bx_editT as text
%        str2double(get(hObject,'String')) returns contents of Bx_editT as a double


% --- Executes during object creation, after setting all properties.
function Bx_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Bx_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in MF52_checkbox.
function MF52_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to MF52_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of MF52_checkbox

set(handles.Pac96_checkbox,'value',0);

set(handles.Pcx1_slider,'value',1.5);
set(handles.Pex2_slider,'value',0);
set(handles.Pex4_slider,'value',0);
set(handles.Pkx3_slider,'value',0);
set(handles.Phx2_slider,'value',0);

set(handles.Pdx1_slider,'max',3000);
set(handles.Pdx1_slider,'min',1000);
set(handles.Pdx1_slider,'value',2300);
a=num2str(get(handles.Pdx1_slider,'value'));
set(handles.Text_Pdx1,'String',a);

set(handles.Pdx2_slider,'max',80);
set(handles.Pdx2_slider,'min',-80);
set(handles.Pdx2_slider,'value',-0.256);
a=num2str(get(handles.Pdx2_slider,'value'));
set(handles.Text_Pdx2,'String',a);

set(handles.Pex1_slider,'max',1);
set(handles.Pex1_slider,'min',-20);
set(handles.Pex1_slider,'value',-2);
a=num2str(get(handles.Pex1_slider,'value'));
set(handles.Text_Pex1,'String',a);

set(handles.Pex3_slider,'max',0.1);
set(handles.Pex3_slider,'min',-0.1);
set(handles.Pex3_slider,'value',0);
a=num2str(get(handles.Pex3_slider,'value'));
set(handles.Text_Pex3,'String',a);

set(handles.Pkx1_slider,'max',500);
set(handles.Pkx1_slider,'min',100);
set(handles.Pkx1_slider,'value',300);
a=num2str(get(handles.Pkx1_slider,'value'));
set(handles.Text_Pkx1,'String',a);

set(handles.Pkx2_slider,'max',20);
set(handles.Pkx2_slider,'min',-20);
set(handles.Pkx2_slider,'value',0);
a=num2str(get(handles.Pkx2_slider,'value'));
set(handles.Text_Pkx2,'String',a);

set(handles.Phx1_slider,'max',5);
set(handles.Phx1_slider,'min',-5);
set(handles.Phx1_slider,'value',0);
a=num2str(get(handles.Phx1_slider,'value'));
set(handles.Text_Phx1,'String',a);

set(handles.Pvx2_slider,'max',100);
set(handles.Pvx2_slider,'min',-100);
set(handles.Pvx2_slider,'value',0);
a=num2str(get(handles.Pvx2_slider,'value'));
set(handles.Text_Pvx2,'String',a);

set(handles.Pvx1_slider,'max',10);
set(handles.Pvx1_slider,'min',-10);
set(handles.Pvx1_slider,'value',0);
a=num2str(get(handles.Pvx2_slider,'value'));
set(handles.Text_Pvx2,'String',a);

handles.figure1;
cla;


% --- Executes on button press in Pac96_checkbox.
function Pac96_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to Pac96_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Pac96_checkbox
set(handles.MF52_checkbox,'value',0);

set(handles.Pcx1_slider,'value',1.5);
set(handles.Pex2_slider,'value',-0.36673);
set(handles.Pex4_slider,'value',-0.05543);
set(handles.Pkx3_slider,'value',-0.45644);
set(handles.Phx2_slider,'value',-0.00179);

set(handles.Pdx1_slider,'max',4);
set(handles.Pdx1_slider,'min',1);
set(handles.Pdx1_slider,'value',2.22960);
a=num2str(get(handles.Pdx1_slider,'value'));
set(handles.Text_Pdx1,'String',a);

set(handles.Pdx2_slider,'max',1);
set(handles.Pdx2_slider,'min',-1);
set(handles.Pdx2_slider,'value',-0.26506);
a=num2str(get(handles.Pdx2_slider,'value'));
set(handles.Text_Pdx2,'String',a);

set(handles.Pex1_slider,'max',1);
set(handles.Pex1_slider,'min',-1);
set(handles.Pex1_slider,'value',0.34731);
a=num2str(get(handles.Pex1_slider,'value'));
set(handles.Text_Pex1,'String',a);

set(handles.Pex3_slider,'max',1);
set(handles.Pex3_slider,'min',-1);
set(handles.Pex3_slider,'value',-0.2813);
a=num2str(get(handles.Pex3_slider,'value'));
set(handles.Text_Pex3,'String',a);

set(handles.Pkx1_slider,'max',80);
set(handles.Pkx1_slider,'min',-80);
set(handles.Pkx1_slider,'value',46.06520);
a=num2str(get(handles.Pkx1_slider,'value'));
set(handles.Text_Pkx1,'String',a);

set(handles.Pkx2_slider,'max',70);
set(handles.Pkx2_slider,'min',-70);
set(handles.Pkx2_slider,'value',-29.4306);
a=num2str(get(handles.Pkx2_slider,'value'));
set(handles.Text_Pkx2,'String',a);

set(handles.Phx1_slider,'max',1);
set(handles.Phx1_slider,'min',-1);
set(handles.Phx1_slider,'value',-0.00087);
a=num2str(get(handles.Phx1_slider,'value'));
set(handles.Text_Phx1,'String',a);

set(handles.Pvx2_slider,'max',1);
set(handles.Pvx2_slider,'min',-1);
set(handles.Pvx2_slider,'value',-0.04174);
a=num2str(get(handles.Pvx2_slider,'value'));
set(handles.Text_Pvx2,'String',a);

set(handles.Pvx1_slider,'max',1);
set(handles.Pvx1_slider,'min',-1);
set(handles.Pvx1_slider,'value',0.00295);
a=num2str(get(handles.Pvx2_slider,'value'));
set(handles.Text_Pvx2,'String',a);

handles.figure1;
cla;

% --- Executes on button press in TirePlotter_GUI_button.
function TirePlotter_GUI_button_Callback(hObject, eventdata, handles)
% hObject    handle to TirePlotter_GUI_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.TireFitter_Panel,'Visible','off');
set(handles.TirePlotter_Panel,'Visible','on');
handles.figure1;
cla;

% --- Executes on button press in TireFitter_GUI_button.
function TireFitter_GUI_button_Callback(hObject, eventdata, handles)
% hObject    handle to TireFitter_GUI_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.TirePlotter_Panel,'Visible','off');
set(handles.TireFitter_Panel,'Visible','on');
handles.figure1;
cla;

% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit37_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit37 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function MeasurementDataPath_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MeasurementDataPath_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in BrowseFile_Button.
function BrowseFile_Button_Callback(hObject, eventdata, handles)
% hObject    handle to BrowseFile_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Error_text_Fitter,'String','')
[FileName,PathName]= uigetfile('*.mat','Select a ".mat" File');
set(handles.MeasurementDataPath_editT,'String',[PathName FileName]);


% --- Executes on button press in MeasurementDataPlot_Button.
function MeasurementDataPlot_Button_Callback(hObject, eventdata, handles)
% hObject    handle to MeasurementDataPlot_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MeasurementFilePath= get(handles.MeasurementDataPath_editT,'String');
if exist(MeasurementFilePath)
    load(MeasurementFilePath);    
    if exist('NormalLoad')
        set(handles.Error_text_Fitter,'String',' ')
        handles.Fitter.NormalLoad= NormalLoad;
        handles.Fitter.Fx= Fx;
        handles.Fitter.xdata= xdata;
        guidata(hObject,handles);
    else
        error_text= 'Variable "Normal Load" not defined';
        warning(error_text)
        set(handles.Error_text_Fitter,'String',error_text);
    end
    handles.figure1;
    cla;
    plot(xdata,Fx,'r.')
else
    error_text= 'File Does not Exist';
    set(handles.Error_text_Fitter,'String',error_text);
    warning(error_text);   
end


% --- Executes on button press in StartFitting_Button.
function StartFitting_Button_Callback(hObject, eventdata, handles)
% hObject    handle to StartFitting_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if isfield(handles,'Fitter')
    if get(handles.DefaultSettings_checkbox,'Value')
        optim_opts= optimset('MaxFunEvals',1e3,'MaxIter',...
                        1e3,'TolFun',1e1,'TolX',1e1);
    else        
        optim_opts= optimset('TolX',get(handles.TolX_editT,'String'),...
                    'TolFun',get(handles.TolFun_editT,'String'),...
                    'MaxIter',get(handles.MaxIter_editT,'String'),...
                    'MaxFunEval',get(handles.MaxFunEval_editT,'String'),...
                    'PlotFcns',get(handles.PlotFcns_editT,'String'));
    end
    if get(handles.PlotOpt_checkbox,'Value')
        optim_opts= optimset('OutputFcn',@optimplotfval2);
        handles.Fitter.plot_flag= 1;
    end
    set(handles.Error_text_Fitter,'ForegroundColor',[0 1 0]);
    set(handles.Error_text_Fitter,'String','Tire is being Fitted');
    
    handles.Fitter.axes= handles.Main_axes;
    guidata(hObject,handles);
    
    if get(handles.Import_TP_Design_CB,'Value')
        if isfield(handles,'Current_TP_Design')
            if ~isempty(handles.Current_TP_Design)
                handles.startDesign= handles.Current_TP_Design;
            else
                warn_txt= 'Import Failed. Continuing to import a random design';
                warning(warn_txt);
                set(handles.Error_text_Fitter,'String',warn_txt);
                handles.startDesign= handles.Start_MF52Par;
            end
        end
    else
        handles.startDesign= handles.Start_MF52Par;
    end
    guidata(hObject,handles);
    
    opt_par= fminsearch(@(par0) opt_fun(par0,handles.Fitter),...
        handles.startDesign,optim_opts);
    if get(handles.saveOptPar_checkbox,'Value')
        saveas(opt_par,[pwd '\OptimisedParameterSet.mat']);
    end
    set(handles.Error_text_Fitter,'ForegroundColor',[0 1 0]);
    set(handles.Error_text_Fitter,'String','Tire Fitting Complete');
else
    error_txt= 'Measurement Data not loaded!!';
    warning(error_txt);
    set(handles.Error_text_Fitter,'String',error_txt);
end

% --- Executes during object creation, after setting all properties.
function TolX_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TolX_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function TolFun_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TolFun_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function MaxIter_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxIter_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function MaxFunEval_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxFunEval_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function PlotFcns_editT_CreateFcn(hObject, eventdata, handles)
% hObject    handle to PlotFcns_editT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DefaultSettings_checkbox.
function DefaultSettings_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to DefaultSettings_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DefaultSettings_checkbox
if ~get(hObject,'Value')
    set(handles.TolX_editT,'Enable','on')
    set(handles.TolFun_editT,'Enable','on')
    set(handles.MaxFunEval_editT,'Enable','on')
    set(handles.MaxIter_editT,'Enable','on')
    set(handles.TolX_text,'Enable','on')
    set(handles.TolFun_text,'Enable','on')
    set(handles.MaxFunEval_text,'Enable','on')
    set(handles.MaxIter_text,'Enable','on')
else
    set(handles.TolX_editT,'Enable','off')
    set(handles.TolFun_editT,'Enable','off')
    set(handles.MaxFunEval_editT,'Enable','off')
    set(handles.MaxIter_editT,'Enable','off')
    set(handles.TolX_text,'Enable','off')
    set(handles.TolFun_text,'Enable','off')
    set(handles.MaxFunEval_text,'Enable','off')
    set(handles.MaxIter_text,'Enable','off')
end
    
