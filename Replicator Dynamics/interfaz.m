function varargout = interfaz(varargin)
% INTERFAZ MATLAB code for interfaz.fig
%      INTERFAZ, by itself, creates a new INTERFAZ or raises the existing
%      singleton*.
%
%      H = INTERFAZ returns the handle to a new INTERFAZ or the handle to
%      the existing singleton*.
%
%      INTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ.M with the given input arguments.
%
%      INTERFAZ('Property','Value',...) creates a new INTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES


% Edit the above text to modify the response to help interfaz

% Last Modified by GUIDE v2.5 12-Apr-2013 09:30:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaz_OutputFcn, ...
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

 
% mh = uimenu(h,'Label','My menu');
% set(fh,'MenuBar','figure');
% eh1 = uimenu(mh,'Label','Item 1');
% eh2 = uimenu(mh,'Label','Item 2','Checked','on');






% --- Executes just before interfaz is made visible.
function interfaz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfaz (see VARARGIN)

% Choose default command line output for interfaz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
clc;
clear all;

% UIWAIT makes interfaz wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = interfaz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
a = getappdata(handles.info)
%save('datos.mat','a')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)

set(handles.pushbutton8,'Enable','on');

    h = isappdata(handles.info,'version_simulador');
    i = isappdata(handles.info,'Path_vissim_model');
    j = isappdata(handles.info,'name_vissim_model_network');
    jj= isappdata(handles.info,'name_vissim_model_layout');
    k = isappdata(handles.info,'nsg');
    l = isappdata(handles.info,'cycle_time');
    m = isappdata(handles.info,'order');
    n = isappdata(handles.info,'minTao');
    p = isappdata(handles.info,'numControllers');
    q = isappdata(handles.info,'sensorAsignment');
    u = isappdata(handles.info,'numQueueCountersVissim');
    v = isappdata(handles.info,'yellowTime');
    w = isappdata(handles.info,'RATime');
    x = isappdata(handles.info,'total_time_simulation');
    
    
    if (h && i && j && jj && k && l && m && n && p && q && v && w && u && x)
        a = getappdata(handles.info,'version_simulador');
        b = getappdata(handles.info,'Path_vissim_model');
        c = getappdata(handles.info,'name_vissim_model_network');
        cc= getappdata(handles.info,'name_vissim_model_layout');
        d = getappdata(handles.info,'nsg');
        e = getappdata(handles.info,'cycle_time');
        f = getappdata(handles.info,'order');
        g = getappdata(handles.info,'minTao');
        o = getappdata(handles.info,'numControllers');
        t = getappdata(handles.info,'sensorAsignment');
        u = getappdata(handles.info,'numQueueCountersVissim');
        v = getappdata(handles.info,'yellowTime');
        w = getappdata(handles.info,'RATime');
        x = getappdata(handles.info,'total_time_simulation');


        % Learning % left 55
        for i = 1:1
            world = MainSimulation(a,b,c,cc,d,e,f,g,o,t,u,v,w,x);
            world.startSimulation();
            world.exit();
            i
        end
                
        setappdata(handles.info,'world',world);

    else

    msgbox('Please complete all fields before open VISSIM','Error','error')
        
    end



% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)

    pack;
    clc;
    version = '';
    
    %For 32 bits version
    if strcmp( get(get(handles.uipanel15,'SelectedObject'),'tag'), 'radiobutton50' )
        version = '100.32';
    elseif strcmp( get(get(handles.uipanel15,'SelectedObject'),'tag'), 'radiobutton51' )
        version = '900.32';    
    elseif strcmp( get(get(handles.uipanel15,'SelectedObject'),'tag'), 'radiobutton52' )
        version = '800.32';
    elseif strcmp( get(get(handles.uipanel15,'SelectedObject'),'tag'), 'radiobutton53' )
        version = '700.32';
    

        %For 64 bits version
    elseif strcmp( get(get(handles.uipanel15,'SelectedObject'),'tag'), 'radiobutton56' )
        version = '100.64';
    elseif strcmp( get(get(handles.uipanel15,'SelectedObject'),'tag'), 'radiobutton57' )
        version = '900.64';
    elseif strcmp( get(get(handles.uipanel15,'SelectedObject'),'tag'), 'radiobutton58' )
        version = '800.64';
    elseif strcmp( get(get(handles.uipanel15,'SelectedObject'),'tag'), 'radiobutton59' )
        version = '700.64';
    else
        error('Something is wrong in the version panel selector')
    end

    % Save the inf in the GUI database with the tag info defined in the GUIDE
    % as static text
    setappdata(handles.info,'version_simulador',version);

    [FileName,PathName] = uigetfile('*.inpx','Select the VISSIM network file');


    if( ~isnumeric(FileName) && ~isnumeric(PathName) )
    setappdata(handles.info,'Path_vissim_model',PathName);
    setappdata(handles.info,'name_vissim_model_network',FileName);

                %32 bits versions
                if     (strcmp(version,'430.32'))
                    ver = 'VISSIM.vissim-32.1';

                elseif (strcmp(version,'500.32'))
                    ver = 'VISSIM.vissim-32.500';

                elseif (strcmp(version,'510.32')) 
                    ver = 'VISSIM.vissim-32.510';                

                elseif (strcmp(version,'520.32'))
                    ver = 'VISSIM.vissim-32.520';

                elseif (strcmp(version,'530.32'))
                    ver = 'VISSIM.vissim-32.530';

                elseif (strcmp(version,'540.32'))
                    ver = 'VISSIM.vissim-32.540';


                %64 bits versions
                elseif (strcmp(version,'430.64'))
                    ver = 'VISSIM.vissim-64.1';

                elseif (strcmp(version,'500.64'))
                    ver = 'VISSIM.vissim-64.500';

                elseif (strcmp(version,'510.64')) 
                    ver = 'VISSIM.vissim-64.510';                

                elseif (strcmp(version,'520.64'))
                    ver = 'VISSIM.vissim-32.520';

                elseif (strcmp(version,'530.64'))
                    ver = 'VISSIM.vissim-64.530';

                elseif (strcmp(version,'100.64'))
                    ver = 'VISSIM.vissim-64.100';

                end

    Vissim = actxserver(ver);
%     if Vissim.simulation.AttValue('ELAPSEDTIME') > 0
%         Vissim.Simulation.Stop   % Stop a simulation first
%     end




            Vissim.LoadNet([PathName,FileName]);
            [FileName,PathName] = uigetfile('*.layx','Select the VISSIM layout file');
            setappdata(handles.info,'name_vissim_model_layout',FileName);
            Vissim.LoadLayout([PathName,FileName]);
            nqc = Vissim.Net.QueueCounters.Count;
            nsc = Vissim.Net.SignalControllers.Count;
            set(handles.text34,'String', num2str(nqc))
            c = cell(nqc+1,1);
            sens = cell(nqc,1);
            for i = 1:nqc
                    c{i} = num2str(i);          
    %                sens{i} = Vissim.net.QueueCounters.GetQueueCounterByNumber(i);
            end
            c{nqc+1}= 'n/a';
            set(handles.popupmenu12,'String',c);
     %       setappdata(handles.info,'sensorsVissimInstance',sens);

            set(handles.text24,'String', num2str(nsc))

            % setting the popupmenu 13
            c = cell(nsc,1);
            names = cell(nsc,1);
            sc = zeros(nsc,1);
            sh =0;
            for i = 1:nsc
                c{i} = num2str(i);      
                names{i} = Vissim.net.SignalControllers.ItemByKey(i).AttValue('Name');
                sc(i)= Vissim.net.signalControllers.ItemByKey(i).SGs.Count;

                   for j = 1:sc(i)
                        sh=sh+  Vissim.net.SignalControllers.ItemByKey(i).SGs.ItemByKey(j).SigHeads.Count;
                   end


            end

            set(handles.popupmenu13,'String',c);
            nc = get(handles.popupmenu13,'Value');

            % Setting the name of controller
            set(handles.text36,'String',names{nc});
            % Setting the number of signal groups
            set(handles.text33,'String',sc(nc));

            % Setting the number of signal heads
            set(handles.text38,'String',sh);

            % Setting the number of links
            nlinks = Vissim.net.Links.Count;
            set(handles.text40,'String',nlinks);


            % Setting the number of Vehicle Inputs
            nvi= Vissim.net.VehicleInputs.count;
            vi = [];
            volume = [];
            nam = cell(1);

            for i = 1:nvi
                ass = 0;
                for j = 1: length(vi)
                    if str2double(Vissim.net.VehicleInputs.ItemByKey(i).AttValue('Name')) ==vi(j)
                    ass = 1;
                    end
                end
                if ass ==0
                    vi = [vi str2double(Vissim.net.VehicleInputs.ItemByKey(i).AttValue('Name'))];
                    volume=[volume  Vissim.net.VehicleInputs.ItemByKey(i).AttValue('Volume(1)') ];
                    nam{length(vi)} =  Vissim.net.VehicleInputs.ItemByKey(i).AttValue('Name');

                end
            end

            set(handles.text42,'String',length(vi));


            % setting the popupmenu 17
            c = cell(length(vi),1);
            for i = 1:length(vi)
                    c{i} = num2str(i);      
            end

            set(handles.popupmenu17,'String',c);




            % Setting the volume for Veh inputs 
            vim = get(handles.popupmenu17,'Value');
            set(handles.text46,'String',volume(vim) );

            % Setting for Veh imput selected Name
            numvi= get(handles.popupmenu17,'Value');
            set(handles.text49,'String', nam{numvi} );

            % Saving in the database
            setappdata(handles.info,'numControllersVissim',nsc);
            setappdata(handles.info,'numVehicleImputsVissim',length(vi));
            setappdata(handles.info,'numQueueCountersVissim',nqc);
            setappdata(handles.info,'numSignalHeadsVissim',sh);
            setappdata(handles.info,'numLinksVissim',nlinks);
            setappdata(handles.info,'volumeVehicleImputsVissim',volume);
            setappdata(handles.info,'nameVehicleImputsVissim',nam);
            setappdata(handles.info,'nameControllersVissim',names);
            setappdata(handles.info,'numSignalGroupsVissim',sc);

end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_5_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_6_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_7_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_9_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_10_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_8_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function pushbutton1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton24.
function radiobutton24_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton24


% --- Executes on button press in radiobutton23.
function radiobutton23_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton23


% --- Executes on button press in radiobutton22.
function radiobutton22_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton22


% --- Executes on button press in radiobutton21.
function radiobutton21_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton21


% --- Executes on button press in radiobutton20.
function radiobutton20_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton20


% --- Executes on button press in radiobutton19.
function radiobutton19_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton19


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)


% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
ResultadosGuide(PathName);


% --- Executes on button press in radiobutton46.
function radiobutton46_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton46


% --- Executes on button press in radiobutton47.
function radiobutton47_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton47


% --- Executes on button press in radiobutton48.
function radiobutton48_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton48 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton48


% --- Executes on button press in radiobutton49.
function radiobutton49_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton49 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton49


% --- Executes when selected object is changed in uipanel15.
function uipanel15_SelectionChangeFcn(hObject, eventdata, handles)




% hObject    handle to the selected object in uipanel15 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function uipanel15_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.m','Select the control file');

setappdata(handles.info,'Path_alg_Control',PathName);

%test.createControlUser(PathName);



function edit1_Callback(hObject, eventdata, handles)

a = get(handles.edit1,'String');
cycle = str2double(a);
if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit1,'String','');

else
    
    ar = get(handles.popupmenu16,'Value');
    b = getappdata(handles.info,'cycle_time');
    b(ar) = cycle;
    setappdata(handles.info,'cycle_time',b);
    
    
end

% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
a = get(handles.edit2,'String');
nsg = str2double(a);
if(isnan(nsg))
    msgbox('The value inserted is not valid','Error','error')
    set(handles.edit2,'String','');

else
    % First save the nsg in the GUI database
    nc = get(handles.popupmenu16,'Value');
    nsg_data =  getappdata(handles.info,'nsg');
    nsg_data(nc)=nsg;
    setappdata(handles.info,'nsg',nsg_data);
    
    %Second, fix the popup menu
    
        c= cell(nsg,1);
    for i = 1:nsg
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu3,'Value',1);
    set(handles.popupmenu3,'String',c);

    
    %third, I initialize order and mintao

    
    
    
    
order=   getappdata(handles.info,'order');
minTao=  getappdata(handles.info,'minTao');

for i = 1: nsg
    order{nc,i} = [1 2 4 5];
%    minTao{nc,i}=  [0 0 0 0];
end

    minTao{nc} = zeros(nsg,1);
    setappdata(handles.info,'order',order);
%%voy aqui
    setappdata(handles.info,'minTao',minTao); 
    as = get(handles.popupmenu3,'Value');
    ord = order{nc,as};
  
       %%%%% Nuevo
       % setting the popupmenus!
        set(handles.popupmenu4,'Value',ord(1));
        set(handles.popupmenu7,'Value',ord(2));
        set(handles.popupmenu8,'Value',ord(3));
        set(handles.popupmenu9,'Value',ord(4));

        % Setting the text6
        set(handles.edit6,'String',minTao{nc}(as));
% 
% for i =1:length(ord)
%     if ord(i) ==1
%         ordi{i} = 'RA';
%     elseif ord(i) ==2 
%         ordi{i} = 'V';
%     elseif ord(i) ==3
%         ordi{i} = 'Vi';
%     elseif ord(i) ==4
%         ordi{i} = 'A';
%     elseif ord(i) ==5
%         ordi{i} = 'R';
%     elseif ord(i) ==6
%         ordi{i} = 'n/a';
%     end
% end
%         set(handles.text13,'String',ordi{1});
%         set(handles.text14,'String',ordi{2});
%         set(handles.text15,'String',ordi{3});
%         set(handles.text16,'String',ordi{4});
% 
%         %Setting the editable texts        
%         set(handles.edit3,'String',minT(1));
%         set(handles.edit4,'String',minT(2));
%         set(handles.edit5,'String',minT(3));
%         set(handles.edit6,'String',minT(4));

end
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


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
  
ord =   getappdata(handles.info,'order');
minT =   getappdata(handles.info,'minTao');
val = get(handles.popupmenu3,'Value'); %% USed nsgroup!!
nc = get(handles.popupmenu16,'Value');%%% Used actual controller

        orde = ord{nc,val} ;
%        minTa = minT{nc,val};
   

       % setting the popupmenus!
        set(handles.popupmenu4,'Value',orde(1));
        set(handles.popupmenu7,'Value',orde(2));
        set(handles.popupmenu8,'Value',orde(3));
        set(handles.popupmenu9,'Value',orde(4));
        % Setting the static texts
        set(handles.edit6,'String',minT{nc}(val));
        
        
% 
% for i =1:length(orde)
%     if orde(i) ==1
%         ordi{i} = 'RA';
%     elseif orde(i) ==2 
%         ordi{i} = 'V';
%     elseif orde(i) ==3
%         ordi{i} = 'Vi';
%     elseif orde(i) ==4
%         ordi{i} = 'A';
%     elseif orde(i) ==5
%         ordi{i} = 'R';
%     elseif orde(i) ==6
%         ordi{i} = 'n/a';
%     end
% end
%         set(handles.text13,'String',ordi{1});
%         set(handles.text14,'String',ordi{2});
%         set(handles.text15,'String',ordi{3});
%         set(handles.text16,'String',ordi{4});






% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
    ord=get(handles.popupmenu4,'Value');
    nc = get(handles.popupmenu16,'Value');
    sig =get(handles.popupmenu7,'Value');
    nsg = get(handles.popupmenu3,'Value');

    
if ord == sig

    msgbox('You can not set equal and consecutive light signals','Error','error')
    a = getappdata(handles.info,'order');
    
    set(handles.popupmenu4,'Value',a{nc,nsg}(1));
else
%         if ord ==1
%             ordi = 'RA';
%         elseif ord ==2 
%             ordi = 'V';
%         elseif ord ==3
%             ordi = 'Vi';
%         elseif ord ==4
%             ordi = 'A';
%         elseif ord ==5
%             ordi = 'R';
%         end
% 
%         % Setting the static text related
%         set(handles.text13,'String',ordi);
        res = getappdata(handles.info,'order');
        nsg = get(handles.popupmenu3,'Value');
        res{nc,nsg}(1)= ord;
        setappdata(handles.info,'order',res);
end


% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
    ord=get(handles.popupmenu7,'Value');
    nc = get(handles.popupmenu16,'Value');
    sig1=get(handles.popupmenu4,'Value');
    sig2=get(handles.popupmenu8,'Value');
    nsg = get(handles.popupmenu3,'Value');


    
    
    if ((ord == sig1) || (ord == sig2))

    msgbox('You can not set equal and consecutive light signals','Error','error')
    
    a = getappdata(handles.info,'order');
    
    set(handles.popupmenu7,'Value',a{nc,nsg}(2));
    
    else
    
%     
%     if ord ==1
%         ordi = 'RA';
%     elseif ord ==2 
%         ordi = 'V';
%     elseif ord ==3
%         ordi = 'Vi';
%     elseif ord ==4
%         ordi = 'A';
%     elseif ord ==5
%         ordi = 'R';
%     end
% 
%     % Setting the static text related
%     set(handles.text14,'String',ordi);
    res = getappdata(handles.info,'order');
    nsg = get(handles.popupmenu3,'Value');
    res{nc,nsg}(2)= ord;
    setappdata(handles.info,'order',res);
    end
    
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7


% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
    ord=get(handles.popupmenu8,'Value');
    nc = get(handles.popupmenu16,'Value');
    nsg = get(handles.popupmenu3,'Value');
    sig1=get(handles.popupmenu7,'Value');
    sig2=get(handles.popupmenu9,'Value');

    
    
    if ( ord == sig1 || ord == sig2 )

    msgbox('You can not set equal and consecutive light signals','Error','error')  
    a = getappdata(handles.info,'order');
    set(handles.popupmenu8,'Value',a{nc,nsg}(3));
else
    
% 
%     
%     
%     if ord ==1
%         ordi = 'RA';
%     elseif ord ==2 
%         ordi = 'V';
%     elseif ord ==3
%         ordi = 'Vi';
%     elseif ord ==4
%         ordi = 'A';
%     elseif ord ==5
%         ordi = 'R';
%     end
%     
%     % Setting the static text related
%     set(handles.text15,'String',ordi);
    res = getappdata(handles.info,'order');
    nsg = get(handles.popupmenu3,'Value');
    res{nc,nsg}(3)= ord;
    setappdata(handles.info,'order',res);
    end
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
    ord=get(handles.popupmenu9,'Value');
    nc = get(handles.popupmenu16,'Value');
    sig1=get(handles.popupmenu8,'Value');
    nsg = get(handles.popupmenu3,'Value');
    
    
    if ord == sig1 

    msgbox('You can not set equal and consecutive light signals','Error','error')
        set(handles.popupmenu4,'Value',ord)
            a = getappdata(handles.info,'order');
    
    set(handles.popupmenu9,'Value',a{nc,nsg}(4));
else

% 
%     
%     if ord ==1
%         ordi = 'RA';
%     elseif ord ==2 
%         ordi = 'V';
%     elseif ord ==3
%         ordi = 'Vi';
%     elseif ord ==4
%         ordi = 'A';
%     elseif ord ==5
%         ordi = 'R';
%     elseif ord ==6
%         ordi = 'n/a';        
%     end
% 
%     % Setting the static text related
%     set(handles.text16,'String',ordi);
    res = getappdata(handles.info,'order');
    nsg = get(handles.popupmenu3,'Value');
    res{nc,nsg}(4)= ord;
    setappdata(handles.info,'order',res);
    
    end
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
%global test;
a = get(handles.edit2,'String');
nsg = str2double(a);
if(isnan(nsg))
msgbox('The value inserted is not valid','Error','error')
else
    c= [];
    for i = 1:nsg
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu3,'String',c);
end
     
cycletime = get(handles.edit1,'String');
test.createSignalPlanInstance(nsg, cycletime)

% Get info from instance Signal Plan
as = get(handles.popupmenu3,'Value');

ord = [1 2 4 5];
minT = [2 2 2 2];
%ord = test.getOrderByNsg(as)
%minT = test.getMinTaoByNsg(as);

% setting the popupmenus!
        set(handles.popupmenu4,'Value',ord(1));
        set(handles.popupmenu7,'Value',ord(2));
        set(handles.popupmenu8,'Value',ord(3));
        set(handles.popupmenu9,'Value',ord(4));
% Setting the static texts

for i =1:length(ord)
    if ord(i) ==1
        ordi{i} = 'RA';
    elseif ord(i) ==2 
        ordi{i} = 'V';
    elseif ord(i) ==3
        ordi{i} = 'Vi';
    elseif ord(i) ==4
        ordi{i} = 'A';
    elseif ord(i) ==5
        ordi{i} = 'R';
    end
end
        set(handles.text13,'String',ordi{1});
        set(handles.text14,'String',ordi{2});
        set(handles.text15,'String',ordi{3});
        set(handles.text16,'String',ordi{4});

        %Setting the editable texts        
        set(handles.edit3,'String',minT(1));
        set(handles.edit4,'String',minT(2));
        set(handles.edit5,'String',minT(3));
        set(handles.edit6,'String',minT(4));
        
        


% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function edit3_Callback(hObject, eventdata, handles)

a = get(handles.edit3,'String');
cycle = str2double(a);
nc = get(handles.popupmenu16,'Value');

if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit3,'String','');

else
    
    %%%%%%%%%
    res = getappdata(handles.info,'minTao');
    nsg = get(handles.popupmenu3,'Value');
    res{nc,nsg}(1)= cycle;
    setappdata(handles.info,'minTao',res);
    
end

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

a = get(handles.edit4,'String');
cycle = str2double(a);
nc = get(handles.popupmenu16,'Value');


if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit4,'String','');

else
    
    %%%%%%%%%
    res = getappdata(handles.info,'minTao');
    nsg = get(handles.popupmenu3,'Value');
    res{nc,nsg}(2)= cycle;
    setappdata(handles.info,'minTao',res);
end
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



function edit5_Callback(hObject, eventdata, handles)

a = get(handles.edit5,'String');
cycle = str2double(a);
nc = get(handles.popupmenu16,'Value');
    
if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit5,'String','');

else
    
    %%%%%%%%%
    res = getappdata(handles.info,'minTao');
    nsg = get(handles.popupmenu3,'Value');
    res{nc,nsg}(3)= cycle;
    setappdata(handles.info,'minTao',res);
end  
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)

a = get(handles.edit6,'String');
cycle = str2double(a);
nc = get(handles.popupmenu16,'Value');
    
if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit6,'String','');

else
    
    %%%%%%%%%
    res = getappdata(handles.info,'minTao');
    nsg = get(handles.popupmenu3,'Value');
    res{nc}(nsg) = cycle;
    setappdata(handles.info,'minTao',res);
    
end
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


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over popupmenu4.
function popupmenu4_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton1.
function pushbutton1_ButtonDownFcn(hObject, eventdata, handles)

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit7_Callback(hObject, eventdata, handles)

a = get(handles.edit7,'String');
cycle = str2double(a);
if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit7,'String','');

else
    
    setappdata(handles.info,'total_time_simulation',cycle);
    
end
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
a = get(handles.edit8,'String');
cycle = str2double(a);
if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit8,'String','');
else
    
    setappdata(handles.info,'numControllers',cycle);
    
   
    %Second, fix the popup menu 
 nc= getappdata(handles.info,'numControllers');
   
        c= [];
    for i = 1:nc
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu10,'Value',1);
    set(handles.popupmenu16,'Value',1);
        
    set(handles.popupmenu10,'String',c);
    set(handles.popupmenu16,'String',c);

%%%%%%%%%%%%%%%%%%%%%%%%%

%Now we initialize the cycle time and nsg
    for i = 1:nc
        
        nsg(i) = 1;  
        cycleTime(i) = 0;
    end
    
    setappdata(handles.info,'nsg',nsg);
    setappdata(handles.info,'cycle_time',cycleTime);

    
    % Now we initialize the  minTao and order
    
      con = str2double(get(handles.edit8,'String'));
  
    order =  cell(con, 1);
    minTao = cell(con, 1);
    
    for j = 1: con
        for i = 1:nsg
            order{j,i} = [1 2 4 5];
            minTao{j} =  [0 0 0 0];
        end  
    end
    
       setappdata(handles.info,'order',order);
       setappdata(handles.info,'minTao',minTao);

    
       % Now I set the popupmenu11
nsg = getappdata(handles.info,'nsg');
bb = get(handles.popupmenu16,'Value');
    
    c= [];
    for i = 1:nsg(bb)
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu11,'Value',1);    
    set(handles.popupmenu11,'String',c);
    set(handles.edit6,'String',minTao{bb}(1));
    
end



% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


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


% --- Executes on selection change in popupmenu10.
function popupmenu10_Callback(hObject, eventdata, handles)

% getting the number of controller
nc= get(handles.popupmenu10,'Value');
set(handles.popupmenu11,'Value',1);
% getting the signal groups
nsg = getappdata(handles.info,'nsg');


% Setting the popupmenu11 (Signal Group selector)
c = cell(nsg(nc),1);


for i = 1 : nsg(nc)    
    c{i}= num2str(i);
end

set(handles.popupmenu11,'String',c);

% reading the queue counter assignment
% sensorAsignment(nc,nsg) ok?
    %a = nsg(nc);
if ~isappdata(handles.info,'sensorAsignment') 
    qc = getappdata(handles.info,'numQueueCountersVissim'); 

    ntc = getappdata(handles.info,'numControllers');    
    
   
        bb = 1;
        for i = 1:ntc
           for j = 1 :nsg(i)
            
               if bb<= qc
               sensor(i,j) = bb;
               bb= bb+1;
               else
                   sensor(i,j)= qc+1;
               end    
           end
        end  
        setappdata(handles.info,'sensorAsignment',sensor);    
end

sensor = getappdata(handles.info,'sensorAsignment');
b = get(handles.popupmenu11,'Value');
set(handles.popupmenu12,'Value',sensor(nc,b));













% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu10 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu10


% --- Executes during object creation, after setting all properties.
function popupmenu10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu11.
function popupmenu11_Callback(hObject, eventdata, handles)

% getting the number of controller
nc= get(handles.popupmenu10,'Value');
%set(handles.popupmenu11,'Value',1);
% getting the signal groups
nsg = getappdata(handles.info,'nsg');


if ~isappdata(handles.info,'sensorAsignment') 
    qc = getappdata(handles.info,'numQueueCountersVissim'); 

    ntc = getappdata(handles.info,'numControllers');    
    
   
        bb = 1;
        for i = 1:ntc
           for j = 1 :nsg(i)
            
               if bb<= qc
               sensor(i,j) = bb;
               bb= bb+1;
               else
                   sensor(i,j)= qc+1;
               end    
           end
        end  
        setappdata(handles.info,'sensorAsignment',sensor);    
end

qc = getappdata(handles.info,'sensorAsignment');
nc = get(handles.popupmenu10,'Value');
nsg = get(handles.popupmenu11,'Value');
set(handles.popupmenu12,'Value',qc(nc,nsg));



% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu11 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu11


% --- Executes during object creation, after setting all properties.
function popupmenu11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu12.
function popupmenu12_Callback(hObject, eventdata, handles)
% getting the number of controller
nc= get(handles.popupmenu10,'Value');
% getting the signal groups
nsg = getappdata(handles.info,'nsg');

if ~isappdata(handles.info,'sensorAsignment') 
    qc = getappdata(handles.info,'numQueueCountersVissim'); 

    ntc = getappdata(handles.info,'numControllers');    
    
   
        bb = 1;
        for i = 1:ntc
           for j = 1 :nsg(i)
            
               if bb<= qc
               sensor(i,j) = bb;
               bb= bb+1;
               else
                   sensor(i,j)= qc+1;
               end    
           end
        end  
        setappdata(handles.info,'sensorAsignment',sensor);    
end


val = get(handles.popupmenu12,'Value');
sensor = getappdata(handles.info,'sensorAsignment');
nc = get(handles.popupmenu10,'Value');
nsg = get(handles.popupmenu11,'Value');
sensor(nc,nsg) = val;
setappdata(handles.info,'sensorAsignment',sensor);
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu12 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu12


% --- Executes during object creation, after setting all properties.
function popupmenu12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu13.
function popupmenu13_Callback(hObject, eventdata, handles)
names =getappdata(handles.info,'nameControllersVissim');
nsg = getappdata(handles.info,'numSignalGroupsVissim');
nc = get(handles.popupmenu13,'Value');

set(handles.text36,'String', names{nc});
set(handles.text33,'String', nsg(nc));

%%%%%%%%% voy aquí fix the popup menu interaction! de ambos casos!



% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu13


% --- Executes during object creation, after setting all properties.
function popupmenu13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
drawSignalPlan()
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit9_Callback(hObject, eventdata, handles)
a = get(handles.edit9,'String');
ID = str2double(a);
if(isnan(ID) || ID>5)
msgbox('The value inserted is not valid','Error','error')
set(handles.edit9,'String','');
else
    % First save the performance indixes in the GUI database
    setappdata(handles.info,'numPerfomanceIndices',ID);
    
    %Second, fix the popup menu 14
    
        c= [];
    for i = 1:ID
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu14,'String',c);
    
end


    %works well :) 

    %remove previous data
  if     isappdata(handles.info,'PI_Types')    
         rmappdata(handles.info,'PI_Types');
  end
    
    type = cell(ID,1);
    
    %%%%%%%%%%%%%Modify to add other perpormance indexes!!!!!!!!!!!!!!!
    % 1 represents Queue Counters 2- 3- 4- 5-
    for i = 1:ID
        type{i} = i;
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Here I save the types or performance indexes in the database
    
       setappdata(handles.info,'PI_Types',type);
       as = get(handles.popupmenu14,'Value');
       typ= type{as};
       % setting the popupmenus!
        set(handles.popupmenu15,'Value',typ);


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu14.
function popupmenu14_Callback(hObject, eventdata, handles)
 
typ =   getappdata(handles.info,'PI_Types');
val = get(handles.popupmenu14,'Value');

for i = 1: length(get(handles.popupmenu14,'String'))
    if val == i
        type= typ{i} ;
        %Finish the loop!
        i=  length(get(handles.popupmenu14,'String'));
    end
end


       % setting the popupmenu!
        set(handles.popupmenu15,'Value',type);

        

% --- Executes during object creation, after setting all properties.
function popupmenu14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu15.
function popupmenu15_Callback(hObject, eventdata, handles)
    ord=get(handles.popupmenu15,'Value');

    
    % Setting the static text related
    res = getappdata(handles.info,'PI_Types');
    nsg = get(handles.popupmenu14,'Value');
    res{nsg}= ord;
    setappdata(handles.info,'PI_Types',res);


% --- Executes during object creation, after setting all properties.
function popupmenu15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu16.
function popupmenu16_Callback(hObject, eventdata, handles)

cycle = getappdata(handles.info,'cycle_time');
nc = get(handles.popupmenu16,'Value');
value = cycle(nc);
set(handles.edit1,'String',value);

% Set nsg
nsg = getappdata(handles.info,'nsg');
set(handles.edit2,'String',nsg(nc));

    %Second, fix the popup menu
        c= [];
    for i = 1:nsg(nc)        
        c{i} = num2str(i);  
    end
    set(handles.popupmenu3,'Value',1);  
    set(handles.popupmenu3,'String',c);





ord =   getappdata(handles.info,'order');
minT =   getappdata(handles.info,'minTao');
val = get(handles.popupmenu3,'Value');
nc = get(handles.popupmenu16,'Value');%%USED
%%% USed nsg(nc)= number of signal groups!!

        orde = ord{nc,val};
        minTa = minT{nc};

       % setting the popupmenus!
        set(handles.popupmenu4,'Value',orde(1));
        set(handles.popupmenu7,'Value',orde(2));
        set(handles.popupmenu8,'Value',orde(3));
        set(handles.popupmenu9,'Value',orde(4));
        
        %%%% Setting the Ingreen
        
        set(handles.edit6,'String', minTa(val));
        
        
        
        
% Setting the static texts
% 
% for i =1:length(orde)
%     if orde(i) ==1
%         ordi{i} = 'RA';
%     elseif orde(i) ==2 
%         ordi{i} = 'V';
%     elseif orde(i) ==3
%         ordi{i} = 'Vi';
%     elseif orde(i) ==4
%         ordi{i} = 'A';
%     elseif orde(i) ==5
%         ordi{i} = 'R';
%     elseif orde(i) ==6
%         ordi{i} = 'n/a';
%     end
% end
%         set(handles.text13,'String',ordi{1});
%         set(handles.text14,'String',ordi{2});
%         set(handles.text15,'String',ordi{3});
%         set(handles.text16,'String',ordi{4});

        %Setting the editable texts        
%         set(handles.edit3,'String',minTa(1));
%         set(handles.edit4,'String',minTa(2));
%         set(handles.edit5,'String',minTa(3));
%         set(handles.edit6,'String',minTa(4));

        

% --- Executes during object creation, after setting all properties.
function popupmenu16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu17.
function popupmenu17_Callback(hObject, eventdata, handles)
volume=getappdata(handles.info,'volumeVehicleImputsVissim');
nam = getappdata(handles.info,'nameVehicleImputsVissim');
nc = get(handles.popupmenu17,'Value');

set(handles.text46,'String', volume(nc));
set(handles.text49,'String', nam{nc});
% hObject    handle to popupmenu17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu17 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu17


% --- Executes during object creation, after setting all properties.
function popupmenu17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit10_Callback(hObject, eventdata, handles)
a = get(handles.edit10,'String');
cycle = str2double(a);
if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit10,'String','');

else
    
    setappdata(handles.info,'yellowTime',cycle);
    
end
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)

a = get(handles.edit11,'String');
cycle = str2double(a);
if(isnan(cycle))
msgbox('The value inserted is not valid','Error','error')
set(handles.edit11,'String','');

else
    
    setappdata(handles.info,'RATime',cycle);
    
end
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
   a = getappdata(handles.info);
   [filename, pathname] = uiputfile('*.mat', 'Save the actual data as');
        save(filename,'a');

% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
[filename pathname]= uigetfile('*.mat','Select data to load');
 a = pwd;
 cd(pathname);
 data = load (filename);

if ~isempty(data.a.version_simulador)
    setappdata(handles.info,'version_simulador',data.a.version_simulador)
end
if ~isempty(data.a.Path_vissim_model)
    setappdata(handles.info,'Path_vissim_model',data.a.Path_vissim_model)
end
if ~isempty(data.a.numControllersVissim)
    setappdata(handles.info,'numControllersVissim',data.a.numControllersVissim)
    set(handles.text24,'String',data.a.numControllersVissim)
        c= [];
    for i = 1:data.a.numControllersVissim
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu13,'Value',1);
    set(handles.popupmenu13,'String',c);

end
if ~isempty(data.a.name_vissim_model)
    setappdata(handles.info,'name_vissim_model_network',data.a.name_vissim_model)
end
if ~isempty(data.a.numVehicleImputsVissim)
    setappdata(handles.info,'numVehicleImputsVissim',data.a.numVehicleImputsVissim)
    set(handles.text42,'String',data.a.numVehicleImputsVissim)
        c= [];
    for i = 1:data.a.numVehicleImputsVissim
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu17,'Value',1);
    set(handles.popupmenu17,'String',c);
    set(handles.text49,'String',data.a.nameVehicleImputsVissim(1));
end
if ~isempty(data.a.numQueueCountersVissim)
    setappdata(handles.info,'numQueueCountersVissim',data.a.numQueueCountersVissim)
        c= [];
    for i = 1:data.a.numQueueCountersVissim
        
        c{i} = num2str(i);  
    
    end
    c{i+1}= 'n/a';
    set(handles.popupmenu12,'Value',1);
    set(handles.popupmenu12,'String',c);
    set(handles.text34,'String',data.a.numQueueCountersVissim);
end
if ~isempty(data.a.sensorAsignment)
    setappdata(handles.info,'sensorAsignment',data.a.sensorAsignment)
    as = data.a.sensorAsignment(1,1);
    set(handles.popupmenu12,'Value',as);
end
if ~isempty(data.a.numSignalHeadsVissim)
    setappdata(handles.info,'numSignalHeadsVissim',data.a.numSignalHeadsVissim)
    set(handles.text38,'String',data.a.numSignalHeadsVissim)
end
if ~isempty(data.a.numLinksVissim)
    setappdata(handles.info,'numLinksVissim',data.a.numLinksVissim)
    set(handles.text40,'String',data.a.numLinksVissim)
end
if ~isempty(data.a.volumeVehicleImputsVissim)
    setappdata(handles.info,'volumeVehicleImputsVissim',data.a.volumeVehicleImputsVissim)
end
if ~isempty(data.a.nameVehicleImputsVissim)
    setappdata(handles.info,'nameVehicleImputsVissim',data.a.nameVehicleImputsVissim)
end
if ~isempty(data.a.nameControllersVissim)
    setappdata(handles.info,'nameControllersVissim',data.a.nameControllersVissim)
end
if ~isempty(data.a.numSignalGroupsVissim)
    setappdata(handles.info,'numSignalGroupsVissim',data.a.numSignalGroupsVissim)
    set(handles.text40,'String',data.a.numSignalGroupsVissim)    
end
if ~isempty(data.a.Path_alg_Control)
    setappdata(handles.info,'Path_alg_Control',data.a.Path_alg_Control)
end
if ~isempty(data.a.numPerfomanceIndices)
    setappdata(handles.info,'numPerfomanceIndices',data.a.numPerfomanceIndices)
    ID = getappdata(handles.info,'numPerfomanceIndices');
    set(handles.edit9,'String',ID);

        c= [];
    for i = 1:ID
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu14,'Value',1);
    set(handles.popupmenu14,'String',c);

end
if ~isempty(data.a.PI_Types)
    setappdata(handles.info,'PI_Types',data.a.PI_Types)
end
if ~isempty(data.a.numControllers)
    setappdata(handles.info,'numControllers',data.a.numControllers)
set(handles.edit8,'String',data.a.numControllers);
c= [];
    for i = 1:data.a.numControllers
        
        c{i} = num2str(i);  
    
    end
    set(handles.popupmenu10,'Value',1);
    set(handles.popupmenu16,'Value',1);
        
    set(handles.popupmenu10,'String',c);
    set(handles.popupmenu16,'String',c);


end
if ~isempty(data.a.nsg)
    setappdata(handles.info,'nsg',data.a.nsg)
end
if ~isempty(data.a.cycle_time)
    setappdata(handles.info,'cycle_time',data.a.cycle_time)
    cycle = getappdata(handles.info,'cycle_time');
    nc = get(handles.popupmenu16,'Value');
    value = cycle(nc);
    set(handles.edit1,'String',value);

end
if ~isempty(data.a.order)
    setappdata(handles.info,'order',data.a.order)
end
if ~isempty(data.a.minTao)
    setappdata(handles.info,'minTao',data.a.minTao)
    minTao = data.a.minTao;
    bb = get(handles.popupmenu16,'Value');
    set(handles.edit6,'String',minTao{bb}(1));
end
if ~isempty(data.a.total_time_simulation)
    setappdata(handles.info,'total_time_simulation',data.a.total_time_simulation)
    set(handles.edit7,'String',data.a.total_time_simulation);
end
if ~isempty(data.a.yellowTime)
    setappdata(handles.info,'yellowTime',data.a.yellowTime)
    set(handles.edit10,'String',data.a.yellowTime);
end
if ~isempty(data.a.RATime)
    setappdata(handles.info,'RATime',data.a.RATime)
    set(handles.edit11,'String',data.a.RATime);
end
  cd(a);
  
 
  
if(isappdata(handles.info,'minTao') && isappdata(handles.info,'nsg')...
        && isappdata(handles.info,'order'))
    
    minTao = getappdata(handles.info,'minTao');

               % Now I set the popupmenu11
    nsg = getappdata(handles.info,'nsg');
    bb = get(handles.popupmenu16,'Value');

        c= [];
        for i = 1:nsg(bb)

            c{i} = num2str(i);  

        end
        set(handles.popupmenu11,'Value',1);    
        set(handles.popupmenu11,'String',c);
        set(handles.edit6,'String',minTao{bb}(1));


    % Set nsg
    nsg = getappdata(handles.info,'nsg');
    set(handles.edit2,'String',nsg(nc));

        %Second, fix the popup menu
            c= [];
        for i = 1:nsg(nc)        
            c{i} = num2str(i);  
        end
        set(handles.popupmenu3,'Value',1);  
        set(handles.popupmenu3,'String',c);





    ord =   getappdata(handles.info,'order');
    minT =   getappdata(handles.info,'minTao');
    val = get(handles.popupmenu3,'Value');
    nc = get(handles.popupmenu16,'Value');%%USED
    %%% USed nsg(nc)= number of signal groups!!

            orde = ord{nc,val};
            minTa = minT{nc};

           % setting the popupmenus!
            set(handles.popupmenu4,'Value',orde(1));
            set(handles.popupmenu7,'Value',orde(2));
            set(handles.popupmenu8,'Value',orde(3));
            set(handles.popupmenu9,'Value',orde(4));

            %%%% Setting the Ingreen

            set(handles.edit6,'String', minTa(val));
end

% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu18.
function popupmenu18_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu18 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu18


% --- Executes during object creation, after setting all properties.
function popupmenu18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
