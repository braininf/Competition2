function devidedData = devidDataByFlash( data, dataTime, sampleRate, rowcol, flashTime )

%   ����˵����
%   data����Ҫ���в�ֵ�����
%   dataTime��ȡ�̼������ms������
%   sampleRate��������
%   rowcol��һ���ж������У�Ҳ���ǲ�ɶ��ٷ�
%   flashTime������ʱ��+���ʱ�䣬Ҳ������˸һ�ε�ʱ��

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



