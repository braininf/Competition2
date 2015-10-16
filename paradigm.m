rows = 6;
colomns = 6;
rowcol = rows + colomns;

sampleRate = 256;
sampleTime = 3.5;     %������

%�����豸
analogInput = analoginput('guadaq',1);
set(analogInput,'SampleRate',sampleRate,'SamplesPerTrigger',sampleTime*sampleRate);
set(ai,'AOAmplitude',2000,'AOFrequency',10,...
        'AOOffset',2047,'AOWaveShape','Sawtooth');
addchannel(analogInput,1:16);


filepath = 'pic/';
filenames = char('1.tif','2.tif','3.tif','4.tif','5.tif','6.tif','7.tif','8.tif','9.tif','10.tif','11.tif','12.tif');
disp( filenames );
%����ͼ��

axes;

numberSequence = [1,2,3,4,5,6,7,8,9,10,11,12];

filename = '0.tif';
path=[filepath filename];
[img,map]=imread(path);
imshow(img);
pause( 3 );

meanAverageWave = [];

% for seq = 1 : 15
    ai = analogInput;
    start( ai );
    while strcmp(ai.running,'On')==1
        if strcmp( ai.running, 'On' ) ~= 1
            break;
        end
        %����ȫ�������˸һ�Σ���ʱ3000ms
        numberSequence = randomSequence( numberSequence, 20 );
        for i = 1 : rowcol
            filename = filenames( numberSequence(i), : );
            path=[filepath filename];
            [img,map]=imread(path);
            imshow(img);
            pause(0.2);
            filename = '0.tif';
            path=[filepath filename];
            [img,map]=imread(path);
            imshow(img);
            pause( 0.05 );
        end
        pause( 0.5 );
    end
    data=getdata(ai,ai.SamplesAvailable);
%     data=getdata( ai );%
    plot(data);
    xlabel('Samples');
    ylabel('Signal [Volt]');
%     trial = devideByFlash( data, numberSequence );%%TODO����data��֣�ÿ��˸��Ӧһ�����Σ����Ұ������б�Ŵ�С����
    
%     meanAverageWave = addWave( trial, meanAverageWave );%%%�������
% end


% meanAverageWave = averageWave( meanAverageWave );

% 
% showWaveForm( meanAverageWave, 4 );
% showWaveForm( meanAverageWave, 10 );
% showWaveForm( meanAverageWave, 1 );
%     
% 
% figure;
% plot(meanAverageWave);
% xlabel('Samples');
% ylabel('Signal [Volt]');


