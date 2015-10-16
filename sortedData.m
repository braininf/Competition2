%调整data顺序，按照行列编号从小到大
function sortedData = sortedData( data, numberSequence )

[rowcolNum, channelNum, dataLength] = size( data );

%初始化sortedData
sortedData = zeros( rowcolNum, channelNum, dataLength );

for i = 1 : dataNum
    sortedData( numberSequence( i ), :, : ) = data( i, :, : );
end


