
ai = analoginput('guadaq',1);
addchannel(ai,[1,2]);
set(ai,'SampleRate',256,'SamplesPerTrigger',512);

set(ai.Channel(1),'BPIndex',48);
set(ai.Channel(2),'BPIndex',48);
set(ai.Channel(1),'BipolarChannel',2);
set(ai.Channel(2),'BipolarChannel',0);
start(ai)

while strcmp(ai.running,'On')==1
end

data = getdata(ai);
subplot(211)
plot(data(257:end,1)) 
set(gca,'YLim',[-0.002 0.002]), grid on
subplot(212)
plot(data(257:end,2));
set(gca,'YLim',[-0.002 0.002]), grid on

delete(ai);
clear ai
