function varargout = stellateConverter(varargin)
% STELLATECONVERTER M-file for stellateConverter.fig
%      STELLATECONVERTER, by itself, creates a new STELLATECONVERTER or raises the existing
%      singleton*.
%
%      H = STELLATECONVERTER returns the handle to a new STELLATECONVERTER or the handle to
%      the existing singleton*.
%
%      STELLATECONVERTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STELLATECONVERTER.M with the given input arguments.
%
%      STELLATECONVERTER('Property','Value',...) creates a new STELLATECONVERTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stellateConverter_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stellateConverter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Copyright 2002-2003 The MathWorks, Inc.

% Edit the above text to modify the response to help stellateConverter

% Last Modified by GUIDE v2.5 01-Jul-2010 17:48:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @stellateConverter_OpeningFcn, ...
    'gui_OutputFcn',  @stellateConverter_OutputFcn, ...
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


% --- Executes just before stellateConverter is made visible.
function stellateConverter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stellateConverter (see VARARGIN)

% Choose default command line output for stellateConverter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stellateConverter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stellateConverter_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectfiles_button.
function selectfiles_button_Callback(hObject, eventdata, handles)
[input_file,pathname] = uigetfile( ...
    {'*.SIG', 'Stellate (*.SIG)'; ...
    '*.*', 'All Files (*.*)'}, ...
    'Select files', ...
    'MultiSelect', 'on');

%if file selection is cancelled, pathname should be zero
%and nothing should happen
if pathname == 0
    return
end
cd(pathname);

%gets the current data file names inside the listbox
inputFileNames = get(handles.select_listbox,'String');

%if they only select one file, then the data will not be a cell
%if more than one file selected at once,
%then the data is stored inside a cell
if iscell(input_file) == 0

    %add the most recent data file selected to the cell containing
    %all the data file names
    inputFileNames{end+1} = fullfile(pathname,input_file);

    %else, data will be in cell format
else
    %stores full file path into inputFileNames
    for n = 1:length(input_file)
        %notice the use of {}, because we are dealing with a cell here!
        inputFileNames{end+1} = fullfile(pathname,input_file{n});
    end
end

%updates the gui to display all filenames in the listbox
set(handles.select_listbox,'String',inputFileNames);
handles.files = inputFileNames;

%make sure first file is always selected so it doesn't go out of range
%the GUI will break if this value is out of range
set(handles.select_listbox,'Value',1);
input_file = get(handles.select_listbox, 'String');
montage = mGetMtgList(input_file{1});
channels = mGetChanLabel(input_file{1}, montage{1});
mFileClose
set(handles.channels_listbox, 'String', channels);

% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in select_listbox.
function select_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to select_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns select_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from select_listbox


% --- Executes during object creation, after setting all properties.
function select_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to select_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
handles.ratNum = get(hObject,'String');
guidata(hObject, handles);

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
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
handles.startFile = get(hObject,'String');
guidata(hObject, handles);

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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
save_directory = uigetdir('C:\');
set(handles.outputdir_text, 'String', save_directory);
guidata(hObject, handles);

% --- Executes on selection change in channels_listbox.
function channels_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to channels_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns channels_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channels_listbox


% --- Executes during object creation, after setting all properties.
function channels_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channels_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%% Doing the Conversions
% Test if ready to go
toConvert = get(handles.select_listbox, 'String');

list = get(handles.select_listbox,'String');
ch = get(handles.channels_listbox, 'String');
assoc = get(handles.associated_listbox,  'String');
num = get(handles.edit1, 'String');


x = isempty(list) + isempty(ch) + isempty(assoc) + isempty(num);

if x~=0
    ButtonName = questdlg('I cannot read your mind. Give me some info', ...
        'I am with Stupid', ...
        'ok', 'ok');
    return
end

dates = [];

for i = 1:length(toConvert)
    fileDate = mGetRecStartTime(toConvert{i});
    dates(i) =  str2num(sprintf('%s%s%s%s', fileDate(6:7), fileDate(9:10), fileDate(1:4), fileDate(12:13)));
end

if ~(issorted(dates))
    ButtonName = questdlg('The dates are not in chronological order. Fix it?', ...
        'Out of Order', ...
        'Yes', 'No', 'Yes');

    switch ButtonName,
        case 'Yes',
            [B,IX] = sort(dates);
            toConvert = toConvert(IX);
        case 'No',
    end


end

%progressbar(0);

% Get everything
handles.channelNum = [];
channelString = get(handles.associated_listbox,'String');
for i = 1:length(handles.channelsConvert)
    mat = regexp(channelString{i}, '\d+', 'match');
    handles.channelNum(i) = str2num(mat{1});
end

% Start Up a Log File
ratNumber = get(handles.edit1, 'String');
ratNumber = str2num(ratNumber);

fileNumber = get(handles.edit2, 'String');
fileNumber = str2num(fileNumber);


montage = mGetMtgList(toConvert{1});
montage = montage{1};

%Start up Log file
logFile = sprintf('Rat_%d.txt', ratNumber);
fid_log = fopen(logFile, 'a+');
fprintf(fid_log, 'Converting Rat %d on %s\n', ratNumber, date);
fprintf(fid_log, 'Channels Extracted:\t');
fprintf(fid_log, '%d \t', handles.channelNum);
fprintf(fid_log, '\n');
fprintf(fid_log, 'File\tNumber of Samples\tSample Freq\t\tStart Time\t\t\t\tOriginal File\t\t\t\t\t\t\t\tNew File\n');


%Start Conversion


for i = 1:length(toConvert)

    set(handles.workingFile, 'String', toConvert{i});
    guidata(hObject, handles);

    [NumRecs, NumSamps, NumSecs] = mGetFileLength(toConvert{i});
    [TrueSampFreq] = mGetTrueSampFreq(toConvert{i});
    [RecordingStartTime] = mGetRecStartTime(toConvert{i});
    convertFilename = sprintf('Rat%.3dch%.2dF%.4d.bin', ratNumber, 1, fileNumber);
    fprintf(fid_log, '%d\t%d\t\t%d\t\t\t%s\t\t%s\t\t%s\n',fileNumber, NumSamps, TrueSampFreq, RecordingStartTime, toConvert{i}, convertFilename);

    % Create and open files for writting
    fid = [];
    for k = 1:length(handles.channelNum)
        fileName = sprintf('Rat%.3dch%.2dF%.4d.bin', ratNumber, handles.channelNum(k), fileNumber);
        fid(k) = fopen(fileName, 'a+');
    end

    fileNumber = fileNumber + 1;

    % Convert Data
    duration = 600000;

    try
        for j = 1:ceil(NumSamps/duration);
            set(handles.percentdone, 'String', num2str(j/ceil(NumSamps/duration)))
            guidata(hObject, handles);
            refresh(stellateConverter);

            if j~=ceil(NumSamps/duration)
                startSamp = (j-1)*duration;
                endSamp = j*duration - 1;

            else
                startSamp = (j-1)*duration;
                duration = mod(NumSamps, duration);
            end
            [EegData, SampRate] = mGetDataSamp(toConvert{i}, startSamp, duration, montage);

            for n = 1:length(handles.channelNum)
                fwrite(fid(n), -1*EegData(:, n), 'int16');
            end

            clear('EegData')

        end
    catch
        errmsg = lasterr
        mFileClose
        fclose all
    end
    refresh(stellateConverter);
    %progressbar(i/length(toConvert));

end
fclose all;

mFileClose;

ButtonName = questdlg('All Done', ...
    'All Done', ...
    'ok', 'ok');

% --- Executes on button press in add_button.
function add_button_Callback(hObject, eventdata, handles)
inputFileNames = get(handles.channels_listbox,'String');

%get the values for the selected file names
option = get(handles.channels_listbox,'Value');

%is there is nothing to delete, nothing happens
if (isempty(option) == 1 || option(1) == 0 || isempty(inputFileNames))
    return
end

%erases the contents of highlighted item in data array
move_channels = inputFileNames(option);
associated_channels = get(handles.associated_listbox,'String');
associated_channels = [associated_channels; move_channels];
set(handles.associated_listbox,'String', associated_channels);
inputFileNames(option) = [];

%updates the gui, erasing the selected item from the listbox

if option(end) > length(inputFileNames)
    set(handles.channels_listbox,'Value',length(inputFileNames));
end

set(handles.channels_listbox,'String',inputFileNames);

handles.channelsConvert = associated_channels;

input_file = get(handles.select_listbox, 'String');

if length(input_file) > 1
    for i = 1:(length(input_file)-1)
        a = mGetMtgList(input_file{i});
        b = mGetMtgList(input_file{i+1});
        if size(a{1}) == size(b{1})
            if a{1} ~= b{1}
                set(handles.channelcheck_text, 'String', 'Montages Are Not Equal. Procede With Caution.')
            else
                set(handles.channelcheck_text, 'String', 'Montages Check Out')
            end
        else
            set(handles.channelcheck_text, 'String', 'Montages Are Not Equal. Procede With Caution.')
        end
    end
end








% Update handles structure
guidata(hObject, handles);

% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in associated_listbox.
function associated_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to associated_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns associated_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from associated_listbox


% --- Executes during object creation, after setting all properties.
function associated_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to associated_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in checkCH.
function checkCH_Callback(hObject, eventdata, handles)
% hObject    handle to checkCH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in clear_button.
function clear_button_Callback(hObject, eventdata, handles)
% hObject    handle to clear_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.select_listbox,'String', '');
set(handles.channels_listbox, 'String', '');
set(handles.associated_listbox,  'String', '');
set(handles.edit1, 'String', '');
guidata(hObject, handles);

