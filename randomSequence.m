function  sequence = randomSequence( inputSequence, randomTimes )
% inputSequence : 输入序列
% randomTimes : 进行多少次随机交换

[row,col]= size( inputSequence );

for i = 1 : col
    idx1 = round(rand(1,1)*(col-1))+1;
    idx2 = round(rand(1,1)*(col-1))+1;
    tmp = inputSequence( idx1 );
    inputSequence( idx1 ) = inputSequence( idx2 );
    inputSequence( idx2) = tmp;
end

sequence = inputSequence;

