function gUSBampAPISync4amps(command)

% This g.USBamp API example shows one simple way to implement synchronous
% data aquisition with four g.USBamps using g.USBamp MATLAB API with DAQ
% toolbox.
% This code is a basic implementation and no proper error handling is
% provided.
%
% Author: Lau
% Last modified: 11/07/2008
% (c) g.tec medical enineering GmbH

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
switch command
    case 'init'
        loc_init;
    case 'start'
        loc_start;
    case 'stop'
        loc_stop;
    case 'cleanup'
        loc_cleanup;
    case 'daq_cb'
        loc_daqcallback;
    otherwise
        error('invalid command');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loc_init

global ain;
daqreset;

a1 = analoginput('guadaq',11);
a2 = analoginput('guadaq',12);
a3 = analoginput('guadaq',13);
a4 = analoginput('guadaq',14);

ain = [a2 a3 a4 a1]; % master must be last device in array

ain.SlaveMode = 'on';
ain(end).SlaveMode = 'off'; % master device

for i=1:4
    addchannel(ain(i),[1:16]);
end

fs = 600; % note Calibration signal is available till fs = 600 Hz
ain.SampleRate = fs;
ain.BufferingConfig = [ceil(60e-3*fs) 100]; % set buffersize to 60 ms
ain.SamplesPerTrigger = inf;
ain.Mode = 'Calibration';

% use gUSBampShowFilter(fs) to find valid filter indices
for i = 1:4
    for k=1:16
        set(ain(i).Channel(k),'BPIndex',104);
    end
end


% data is logged to *.daq file use daqread to read data;
% there is one file for each amplifier
ain.LoggingMode = 'Disk&Memory';
for i=1:4
    ain(i).LogFileName = sprintf('mydaqfile%i.daq',i); 
end

% use callbackroutine of master device
ain(end).SamplesAcquiredFcnCount = ceil(fs/2); %  execute callback two times per second 
ain(end).SamplesAcquiredFcn = 'gUSBampAPISync4amps(''daq_cb'')'; 

disp('DAQ objects created and initialized'); 
disp('serials of selected devices:')
disp(ain.DeviceSerial);
fprintf('master is: %s\n',a1.DeviceSerial); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loc_start
global ain
start(ain);
disp('DAQ objects started'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loc_stop
global ain
stop(ain)
disp('DAQ objects stopped'); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loc_cleanup

global ain

delete(ain);
daqreset;
disp('DAQ objects deleted. DAQ toolbox reset.');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function loc_daqcallback

global ain


try 
    n = ain(end).SamplesAcquiredFcnCount;
    d = zeros(n,64);
    offset = zeros(size(d));
    for i=1:length(ain)
        d(:,(1:16)+(16*(i-1))) = getdata(ain(i),n);
    end
    % do some plot
    o = ones(n,1);
    c = [1:64]*0.01; % assuming 64 channels
    offset = o*c;
    d = d+offset;
    figure(1);
    plot(d);
    drawnow;
catch ME
    disp(ME.message);
end







