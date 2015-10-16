function devidedData = devidDataByFlash( data, dataTime, sampleRate, rowcol, flashTime )

%   参数说明：
%   data：需要进行拆分的数据
%   dataTime：取刺激后多少ms的数据
%   sampleRate：采样率
%   rowcol：一共有多少行列，也就是拆成多少份
%   flashTime：亮的时间+灭的时间，也就是闪烁一次的时间

dataLength = dataTime / 1000 * sampleRate;
[channelNum, dataTotalLength] = size( data );
devidedData = zeros( channelNum, rowcol, datalength );

flashLength = flashTime / 1000 * sampleRate;

for i = 1 : rowcol
    for j = 1 : channelNum
        dataBeg = (i-1)*flashLength;
        dataEnd = dataBeg + dataLength;
        devidedData( j, i, : ) = data( j, dataBeg:dataEnd );
    end
end



