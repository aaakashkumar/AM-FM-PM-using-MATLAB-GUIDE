function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 21-Apr-2018 19:30:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Create the data to plot.
% vm = get(handles.editam,'Value');
% fm = get(handles.editac,'Value');
% handles.vm = vm;
% handles.fm = fm;
% m = vm * sin(2 * pi * fm * t);
% n = vm * cos(2 * pi * fm * t);
% handles.m = m;
% handles.n = n;
t = 0:0.001:1;
handles.t =t;

% Set the current data value.
% handles.current_data = handles.m;

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Amplitude Modulation

t = 0:0.001:1; 
handles.t = t;

am = str2double(get(handles.editam, 'String'));
fm = str2double(get(handles.editfm, 'String'));
ac = str2double(get(handles.editac, 'String'));
fc = str2double(get(handles.editfc, 'String'));

handles.am = am;
handles.fm = fm;
handles.ac = ac;
handles.fc = fc;

m = handles.am * sin(2 * pi * handles.fm * handles.t);
c = handles.ac * cos(2 * pi * handles.fc * handles.t);
s = c + (m.*cos(2 * pi * fc * t));
d = s.*cos(2 * pi * handles.fc * handles.t);
fs = 1000;
[b,a] = butter(10,fc*2/fs);
f = filter(b,a,d);

handles.m = m;
handles.c = c;
handles.s = s;
handles.d = d;
handles.f = f;

current_data = m;
handles.current_data = current_data;

% Determine the selected data set.
str = get(handles.popupmenu1, 'String');
val = get(handles.popupmenu1,'Value');

% Set current data to the selected data set.
switch str{val}
    case 'Message Signal' % User selects Message
        current_data = handles.m;
        handles.current_data = current_data;
    case 'Carrier Signal' % User selects Carrier Signal
        current_data = handles.c;
        handles.current_data = current_data;
    case 'Modulated Signal' % User selects Modulated Signal
        current_data = handles.s;
        handles.current_data = current_data;
    case 'Demodulated Signal (Without Filter)' % User selects Demodulated Signal (Without Filter)
        current_data = handles.d;
        handles.current_data = current_data;
    case 'Demodulated Signal (With Filter)' % User selects Demodulated Signal (With Filter)
        current_data = handles.f;
        handles.current_data = current_data;
    otherwise
        f = warndlg('The option youve selected is not available for this modulation','Error');
        current_data = 0;
end

% axes(handles.axes1);
plot(handles.t,handles.current_data,'r');
xlabel("Time");
ylabel("Amplitude");
% grid on;



function editam_Callback(hObject, eventdata, handles)
% hObject    handle to editam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editam as text
%        str2double(get(hObject,'String')) returns contents of editam as a double


% --- Executes during object creation, after setting all properties.
function editam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editac_Callback(hObject, eventdata, handles)
% hObject    handle to editac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editac as text
%        str2double(get(hObject,'String')) returns contents of editac as a double


% --- Executes during object creation, after setting all properties.
function editac_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Determine the selected data set.
% str = get(hObject, 'String');
% val = get(hObject,'Value');
% % Set current data to the selected data set.
% switch str{val};
% case 'Sine Wave' % User selects peaks.
%    handles.current_data = handles.m;
% case 'Cos Wave' % User selects membrane.
%    handles.current_data = handles.n;
% end
% % Save the handles structure.
% guidata(hObject,handles)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editfm_Callback(hObject, eventdata, handles)
% hObject    handle to editfm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editfm as text
%        str2double(get(hObject,'String')) returns contents of editfm as a double


% --- Executes during object creation, after setting all properties.
function editfm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editfm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editfc_Callback(hObject, eventdata, handles)
% hObject    handle to editfc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editfc as text
%        str2double(get(hObject,'String')) returns contents of editfc as a double


% --- Executes during object creation, after setting all properties.
function editfc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editfc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Frequency Modulation

t = 0:0.001:1; 
handles.t = t;

am = str2double(get(handles.editam, 'String'));
fm = str2double(get(handles.editfm, 'String'));
ac = str2double(get(handles.editac, 'String'));
fc = str2double(get(handles.editfc, 'String'));
beta = str2double(get(handles.editbfm, 'String'));

handles.am = am;
handles.fm = fm;
handles.ac = ac;
handles.fc = fc;
handles.beta = beta;

m = handles.am * sin(2 * pi * handles.fm * handles.t);
c = handles.ac * cos(2 * pi * handles.fc * handles.t);
s = ac * cos((2 * pi * handles.fc * handles.t) + (handles.beta * sin(2 * pi * fm * t)));
d = diff(s);
d1 = [0,d];
v = abs(d1);
[b,a] = butter(10, 0.05);
u = filter(b,a,v);

handles.m = m;
handles.c = c;
handles.s = s;
handles.v = v;
handles.u = u;

current_data = m;
handles.current_data = current_data;

% Determine the selected data set.
str = get(handles.popupmenu1, 'String');
val = get(handles.popupmenu1,'Value');

% Set current data to the selected data set.
switch str{val}
    case 'Message Signal' % User selects Message
        current_data = handles.m;
        handles.current_data = current_data;
    case 'Carrier Signal' % User selects Carrier Signal
        current_data = handles.c;
        handles.current_data = current_data;
    case 'Modulated Signal' % User selects Modulated Signal
        current_data = handles.s;
        handles.current_data = current_data;
    case 'Demodulated Signal (Without Filter)' % Demodulated Signal (Without Filter)
        current_data = handles.v;
        handles.current_data = current_data;
    case 'Demodulated Signal (With Filter)' % Demodulated Signal (With Filter)
        current_data = handles.u;
        handles.current_data = current_data;
    otherwise
        f = warndlg('The option youve selected is not available for this modulation','Error');
        current_data = 0;
end

% axes(handles.axes1);
plot(handles.t,handles.current_data,'r');
xlabel("Time");
ylabel("Amplitude");
% grid on;



function editbfm_Callback(hObject, eventdata, handles)
% hObject    handle to editbfm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editbfm as text
%        str2double(get(hObject,'String')) returns contents of editbfm as a double


% --- Executes during object creation, after setting all properties.
function editbfm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbfm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editbpm_Callback(hObject, eventdata, handles)
% hObject    handle to editbpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editbpm as text
%        str2double(get(hObject,'String')) returns contents of editbpm as a double


% --- Executes during object creation, after setting all properties.
function editbpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editbpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Phase Modulation

t = 0:0.001:1; 
handles.t = t;

am = str2double(get(handles.editam, 'String'));
fm = str2double(get(handles.editfm, 'String'));
ac = str2double(get(handles.editac, 'String'));
fc = str2double(get(handles.editfc, 'String'));
beta_fm = str2double(get(handles.editbfm, 'String'));
beta_pm = str2double(get(handles.editbpm, 'String'));

handles.am = am;
handles.fm = fm;
handles.ac = ac;
handles.fc = fc;
handles.beta_fm = beta_fm;
handles.beta_pm = beta_pm;

m = handles.am * sin(2 * pi * handles.fm * handles.t);
c = handles.ac * cos(2 * pi * handles.fc * handles.t);
s_fm = ac*cos((2*pi*fc*t)+(beta_fm*sin(2*pi*fm*t)));
s_pm = ac*cos((2*pi*fc*t)+(beta_pm*cos(2*pi*fm*t)));
fs = 2 * handles.fc
rx = awgn(s_pm,10,'measured');
phasedev = pi / 2;
y = pmdemod(rx,handles.fc,fs,phasedev);


fs=1000;
l=length(m);
t1=linspace(-fs/2,fs/2,l);


handles.m = m;
handles.c = c;
handles.s_fm = s_fm;
handles.s_pm = s_pm;
handles.y = y;

current_data = m;
handles.current_data = current_data;

% Determine the selected data set.
str = get(handles.popupmenu1, 'String');
val = get(handles.popupmenu1,'Value');

% Set current data to the selected data set.
switch str{val}
    case 'Message Signal' % User selects Message
        current_data = handles.m;
        handles.current_data = current_data;
    case 'Carrier Signal' % User selects Carrier Signal
        current_data = handles.c;
        handles.current_data = current_data;
    case 'Modulated Signal' % User selects Modulated Signal
        current_data = handles.s_fm;
        handles.current_data = current_data;
    case 'Phase Modulated Signal' % User selects Phase Modulated Signal
        current_data = handles.s_pm;
        handles.current_data = current_data;
    case 'Demodulated Signal (Without Filter)' % Demodulated Signal (Without Filter)
        current_data = handles.y;
        handles.current_data = current_data;
    case 'Demodulated Signal (With Filter)' % Demodulated Signal (With Filter)
        current_data = handles.y;
        handles.current_data = current_data;
    otherwise
        f = warndlg('The option youve selected is not available for this modulation','Error');
        current_data = 0;
end

% axes(handles.axes1);
plot(handles.t,handles.current_data,'r');
xlabel("Time");
ylabel("Amplitude");


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
