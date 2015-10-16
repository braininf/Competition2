
ai = analoginput('guadaq',1);
addchannel(ai,[1]);
set(ai,'SampleRate',256,'SamplesPerTrigger',256);
set(ai,'Mode','Calibration');
set(ai,'LogFileName','test','LoggingMode','Disk',...
    'LogToDiskMode','Overwrite');
start(ai)
while strcmp(ai.running,'On')==1
end
delete(ai);
clear ai

data=daqread('test');
plot(data);
xlabel('Samples');
ylabel('Signal [Volt]');
