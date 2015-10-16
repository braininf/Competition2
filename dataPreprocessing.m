function preprocessedData = dataPreprocessing( data, low, high, filterorder, sampleRate, windowSize, downsamplingParam )
%   数据预处理
%       1.Butterworth带通滤波
%       2.光滑处理
%       3.降采样
%
%   data：维数[rowcol,channel,data]
%   low：lowpass
%   high：highpass
%   filterorder：filterorder
%   sampleRate：采样率
%   windowSize：smooth窗口大小
%   downsamplingParam：降采样参数

[channelNum, rowcolNum, dataLength] = size( data );
downsamplingDataLength = ( downsamplingParam.end - downsamplingParam.beg ) / downsamplingParam.step;
preprocessedData = zeros( channelNum, rowcolNum,  downsamplingDataLength );

%初始化滤波参数
filtercutoff = [low*2/samplingrate high*2/samplingrate]; 
[f_b, f_a] = butter(filterorder,filtercutoff);

for rowcol = 1 : rowcolNum
    for channel = 1 : channelNum
        
        %滤波
        curData = filter(f_b,f_a, reshape( data( channel, rowcol, : ), 1, dataLength ) );   
        
        %光滑化
        curData = smooth( curData, windowSize );       
        
        %降采样
        preprocessedData( channel, rowcol, : ) = curData( downsamplingParam.beg:downsamplingParam.end:downsamplingParam.step );
        
    end
end



