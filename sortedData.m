%����data˳�򣬰������б�Ŵ�С����
function sortedData = sortedData( data, numberSequence )

[rowcolNum, channelNum, dataLength] = size( data );

%��ʼ��sortedData
sortedData = zeros( rowcolNum, channelNum, dataLength );

for i = 1 : dataNum
    sortedData( numberSequence( i ), :, : ) = data( i, :, : );
end


