
ai = analoginput('guadaq',1);
addchannel(ai,[1]);
set(ai,'SampleRate',256,'SamplesPerTrigger',256);
set(ai,'AOAmplitude',2000,'AOFrequency',10,...
        'AOOffset',2047,'AOWaveShape','Sawtooth');
set(ai.Channel(1),'BPIndex',-1);
set(ai.Channel(1),'NotchIndex',-1);
set(ai,'Mode','Calibration');
start(ai)
while strcmp(ai.running,'On')==1
end
data=getdata(ai,ai.SamplesAvailable);
plot(data);
xlabel('Samples');
ylabel('Signal [Volt]');
delete(ai);
clear ai
