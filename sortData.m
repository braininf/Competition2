%����data˳�򣬰������б�Ŵ�С����
function sortedData = sortData( data, numberSequence )

[channelNum, rowcolNum, dataLength] = size( data );

%��ʼ��sortedData
sortedData = zeros( channelNum, rowcolNum, dataLength );

for i = 1 : channelNum
    sortedData(  :, numberSequence( i ), : ) = data( :, i, : );
end


