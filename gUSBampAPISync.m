
a1 = analoginput('guadaq',1);
a2 = analoginput('guadaq',2);
Serial1 = a1.DeviceSerial
Serial2 = a2.DeviceSerial

set(a2,'SlaveMode','on');

addchannel(a1,[1:16]);
addchannel(a2,[1:16]);
set(a1,'SampleRate',256,'SamplesPerTrigger',512);
set(a2,'SampleRate',256,'SamplesPerTrigger',512);
set(a1,'Mode','Calibration');
set(a2,'Mode','Calibration');

for i=1:16
    set(a1.Channel(i),'BPIndex',48);
    set(a2.Channel(i),'BPIndex',48);
end
start(a2)
start(a1)

while strcmp(a1.running,'On')==1
end

data1 = getdata(a1);
data2 = getdata(a2);

subplot(211);
plot(data1(257:end,:));
ylabel(Serial1)
subplot(212);
plot(data2(257:end,:));
ylabel(Serial2)

delete(a1);
clear a1
delete(a2);
clear a2
