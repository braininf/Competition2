%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�����ַ�%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%ѵ���ַ�
inputChar = char( 'QWERTYUIOPASDFGHJKLZXCVBNM1234567890,._~');
[inputCharNum,inputCharLen] = size( inputChar );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%��ʽ����%%%%%%%%%%%%%%%%%%%%%%

%��ʽ����
paradigmMatrix = char( 'ABCDEF','GHIJKL','MNOPQR','STUVWX','YZ1234','56789_' ); 
[rows, columns] = size( paradigmMatrix );
rowcol = rows + colomns;

faceShowTime = 200;         %���ٺ�����
faceDisappearTime = 50;     %���ٺ�����
flashTime = faceShowTime + faceDisappearTime;   %�ܹ�ʱ��

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp( size( paradigmMatrix ) );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%��������%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%������
sampleRate = 250;

%ȡ�̼�����ٺ��������
dataTime = 800;
dataLength = dataTime/1000*sampleRate;%���ݳ���

%��������������
downsamplingParam.beg = 0;              %��ʼ��
downsamplingParam.end = dataLength;     %������
downsamplingParam.step = 4;             %��������һ��

%ȫ����˸��ɺ���Ҫ�ɼ����ݶ��ٺ���
redundanceTime = ( dataTime - ( faceShowTime + faceDisappearTime ) );

%����ʱ�䣬������
sampleTime = ( faceShowTime + faceDisappearTime ) / 1000 * rowcol + redundanceTime/1000;

%����ʼ��������ʼ��˸
startDelayTime = 2;

%�������������Ҫ���ж��ٴν���
swapTimes = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

for c = 1 : inputCharLen    %ѭ�������ַ�
    curChar = inputChar( c );%��ȡ��ǰ��Ҫ������ַ�
    %TODO: ~~~~~~~~~~~~~~~~~��ʾ����Ļ��~~~~~~~~~~~~~~~~~
    
    
    
end

for seq = 1 : 15
    %�����˸����
    numberSequence = randomSequence( numberSequence, swapTimes );
    ai = analogInput;
    start( ai );
    while strcmp(ai.running,'On')==1
        if strcmp( ai.running, 'On' ) ~= 1
            break;
        end
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
    data = data';%�Բɼ��������ݽ���ת��
    
    %��data����ÿ����˸��
    data = devidDataByFlash( data, dataTime, sampleRate, rowcol, flashTime );  %��ά����[channel,rowcol,data]
    
    %��data�������б������
    data = sortData( data, numberSequence );
    
    %����Ԥ����
    data = dataPreprocessing( data );
    
    %���浽trainData
    trainData(:, seq, :, : ) = data;
    delete(ai);
    clear ai
end


%����ѵ��


%����ѵ�����


