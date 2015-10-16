
ai = analoginput('guadaq',1);
addchannel(ai,[1]);
set(ai,'SampleRate',256,'SamplesPerTrigger',10*256);
preview=10*256/10;
figure,p = plot(zeros(preview,1)); grid on
start(ai)

while ai.SamplesAcquired < preview
end
while ai.SamplesAcquired < 10 * 256
    data = peekdata(ai,preview);
    set(p,'ydata',data);
    drawnow;
end
data = getdata(ai);
plot(data), grid on

delete(ai);
clear ai
