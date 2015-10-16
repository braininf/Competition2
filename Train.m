
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%参数设置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%行列信息
rows = 6;
colomns = 6;
rowcol = rows + colomns;

%取刺激后多少毫秒的数据
dataTime = 800;

%多少毫秒亮
faceShowTime = 200;
%多少毫秒灭
faceDisappearTime = 50;

%采样率
sampleRate = 256;

%全部闪烁完成后还需要采集数据多少毫秒
redundanceTime = ( dataTime - ( faceShowTime + faceDisappearTime ) );

%采样时间，多少秒
sampleTime = ( faceShowTime + faceDisappearTime ) / 1000 * rowcol + redundanceTime/1000;


%多久之后开始闪烁
startDelayTime = 2;


%产生随机序列需要进行多少次交换
swapTimes = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%参数设置完毕%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%连接设备
analogInput = analoginput('guadaq',1);

%设置通道
addchannel(analogInput,1:16);

%设置采集参数
set(analogInput,'SampleRate',sampleRate,'SamplesPerTrigger',sampleTime*sampleRate);
set(ai,'AOAmplitude',2000,'AOFrequency',10,...
        'AOOffset',2047,'AOWaveShape','Sawtooth');

%图片路径
filepath = 'pic/';

%图片名称
filenames = char('1.tif','2.tif','3.tif','4.tif','5.tif','6.tif','7.tif','8.tif','9.tif','10.tif','11.tif','12.tif');

%绘制图表
axes;

%生成随机闪烁序列
numberSequence = 1:rowcol;
numberSequence = randomSequence( numberSequence, swapTimes*10 );%之所以swapTimes乘以10，是为了让最开始的序列更乱一些

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
        
        %随机闪烁次序
        numberSequence = randomSequence( numberSequence, swapTimes );
        %行列全部随机闪烁一次
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
    
    %将data按照每次闪烁拆开
    devidedData = devidData( data, dataTime );
    
    %将data按照行列编号排序
    sortedData = sorteData( data, numberSequence );
    
    %数据预处理
    data = dataPreprocessing( sortedData );
    
    %保存到trainData
    trainData = [trainData, data ];

end


%进行训练



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


