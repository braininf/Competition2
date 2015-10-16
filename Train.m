
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%��������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%������Ϣ
rows = 6;
colomns = 6;
rowcol = rows + colomns;

%ȡ�̼�����ٺ��������
dataTime = 800;

%���ٺ�����
faceShowTime = 200;
%���ٺ�����
faceDisappearTime = 50;

%������
sampleRate = 256;

%ȫ����˸��ɺ���Ҫ�ɼ����ݶ��ٺ���
redundanceTime = ( dataTime - ( faceShowTime + faceDisappearTime ) );

%����ʱ�䣬������
sampleTime = ( faceShowTime + faceDisappearTime ) / 1000 * rowcol + redundanceTime/1000;


%���֮��ʼ��˸
startDelayTime = 2;


%�������������Ҫ���ж��ٴν���
swapTimes = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%�����豸
analogInput = analoginput('guadaq',1);

%����ͨ��
addchannel(analogInput,1:16);

%���òɼ�����
set(analogInput,'SampleRate',sampleRate,'SamplesPerTrigger',sampleTime*sampleRate);
set(ai,'AOAmplitude',2000,'AOFrequency',10,...
        'AOOffset',2047,'AOWaveShape','Sawtooth');

%ͼƬ·��
filepath = 'pic/';

%ͼƬ����
filenames = char('1.tif','2.tif','3.tif','4.tif','5.tif','6.tif','7.tif','8.tif','9.tif','10.tif','11.tif','12.tif');

%����ͼ��
axes;

%���������˸����
numberSequence = 1:rowcol;
numberSequence = randomSequence( numberSequence, swapTimes*10 );%֮����swapTimes����10����Ϊ�����ʼ�����и���һЩ

filename = '0.tif';
path=[filepath filename];
[img,map]=imread(path);
imshow(img);
pause( startDelayTime );

trainData = [];

for seq = 1 : 15
    ai = analogInput;
    start( ai );
    while strcmp(ai.running,'On')==1
        if strcmp( ai.running, 'On' ) ~= 1
            break;
        end
        
        %�����˸����
        numberSequence = randomSequence( numberSequence, swapTimes );
        %����ȫ�������˸һ��
        for i = 1 : rowcol
            filename = filenames( numberSequence(i), : );
            path=[filepath filename];
            [img,map]=imread(path);
            imshow(img);
            pause(faceShowTime/1000);
            filename = '0.tif';
            path=[filepath filename];
            [img,map]=imread(path);
            imshow(img);
            pause( faceDisappearTime/1000 );
        end
        pause( redundanceTime/1000 );
    end
    data=getdata(ai,ai.SamplesAvailable);
    
    %��data����ÿ����˸��
    devidedData = devidData( data, dataTime );
    
    %��data�������б������
    sortedData = sorteData( data, numberSequence );
    
    %����Ԥ����
    data = dataPreprocessing( sortedData );
    
    %���浽trainData
    trainData = [trainData, data ];

end


%����ѵ��



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

