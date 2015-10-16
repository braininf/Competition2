%调整data顺序，按照行列编号从小到大
function sortedData = sortData( data, numberSequence )

[channelNum, rowcolNum, dataLength] = size( data );

%初始化sortedData
sortedData = zeros( channelNum, rowcolNum, dataLength );

for i = 1 : channelNum
    sortedData(  :, numberSequence( i ), : ) = data( :, i, : );
end


