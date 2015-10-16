%%%%%%%%%%%%%%%%%%%%%%%%%%%%%输入字符%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%训练字符
inputChar = char( 'QWERTYUIOPASDFGHJKLZXCVBNM1234567890,._~');
[inputCharNum,inputCharLen] = size( inputChar );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%范式参数%%%%%%%%%%%%%%%%%%%%%%

%范式矩阵
paradigmMatrix = char( 'ABCDEF','GHIJKL','MNOPQR','STUVWX','YZ1234','56789_' ); 
[rows, columns] = size( paradigmMatrix );
rowcol = rows + colomns;

faceShowTime = 200;         %多少毫秒亮
faceDisappearTime = 50;     %多少毫秒灭
flashTime = faceShowTime + faceDisappearTime;   %总共时间

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp( size( paradigmMatrix ) );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%参数设置%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%采样率
sampleRate = 250;

%取刺激后多少毫秒的数据
dataTime = 800;
dataLength = dataTime/1000*sampleRate;%数据长度

%降采样参数设置
downsamplingParam.beg = 0;              %起始点
downsamplingParam.end = dataLength;     %结束点
downsamplingParam.step = 4;             %隔几个采一个

%全部闪烁完成后还需要采集数据多少毫秒
redundanceTime = ( dataTime - ( faceShowTime + faceDisappearTime ) );

%采样时间，多少秒
sampleTime = ( faceShowTime + faceDisappearTime ) / 1000 * rowcol + redundanceTime/1000;

%程序开始后多少秒后开始闪烁
startDelayTime = 2;

%产生随机序列需要进行多少次交换
swapTimes = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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

for c = 1 : inputCharLen    %循环输入字符
    curChar = inputChar( c );%获取当前需要输入的字符
    %TODO: ~~~~~~~~~~~~~~~~~显示在屏幕上~~~~~~~~~~~~~~~~~
    
    
    
end

for seq = 1 : 15
    %随机闪烁次序
    numberSequence = randomSequence( numberSequence, swapTimes );
    ai = analogInput;
    start( ai );
    while strcmp(ai.running,'On')==1
        if strcmp( ai.running, 'On' ) ~= 1
            break;
        end
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
    data = data';%对采集到的数据进行转置
    
    %将data按照每次闪烁拆开
    data = devidDataByFlash( data, dataTime, sampleRate, rowcol, flashTime );  %三维矩阵[channel,rowcol,data]
    
    %将data按照行列编号排序
    data = sortData( data, numberSequence );
    
    %数据预处理
    data = dataPreprocessing( data );
    
    %保存到trainData
    trainData(:, seq, :, : ) = data;
    delete(ai);
    clear ai
end


%进行训练


%保存训练结果


