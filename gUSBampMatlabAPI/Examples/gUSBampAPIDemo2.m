
ai = analoginput('guadaq',1);
addchannel(ai,[1:16]);
set(ai,'SampleRate',256,'SamplesPerTrigger',256);
set(ai,'GroupAToCommonGround','Enabled','GroupAToCommonReference','Enabled');
set(ai,'GroupBToCommonGround','Enabled','GroupBToCommonReference','Enabled');
set(ai,'GroupCToCommonGround','Enabled','GroupCToCommonReference','Enabled');
set(ai,'GroupDToCommonGround','Enabled','GroupDToCommonReference','Enabled');
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
