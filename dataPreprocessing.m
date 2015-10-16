function preprocessedData = dataPreprocessing( data, low, high, filterorder, sampleRate, windowSize, downsamplingParam )
%   ����Ԥ����
%       1.Butterworth��ͨ�˲�
%       2.�⻬����
%       3.������
%
%   data��ά��[rowcol,channel,data]
%   low��lowpass
%   high��highpass
%   filterorder��filterorder
%   sampleRate��������
%   windowSize��smooth���ڴ�С
%   downsamplingParam������������

[channelNum, rowcolNum, dataLength] = size( data );
downsamplingDataLength = ( downsamplingParam.end - downsamplingParam.beg ) / downsamplingParam.step;
preprocessedData = zeros( channelNum, rowcolNum,  downsamplingDataLength );

%��ʼ���˲�����
filtercutoff = [low*2/samplingrate high*2/samplingrate]; 
[f_b, f_a] = butter(filterorder,filtercutoff);

for rowcol = 1 : rowcolNum
    for channel = 1 : channelNum
        
        %�˲�
        curData = filter(f_b,f_a, reshape( data( channel, rowcol, : ), 1, dataLength ) );   
        
        %�⻬��
        curData = smooth( curData, windowSize );       
        
        %������
        preprocessedData( channel, rowcol, : ) = curData( downsamplingParam.beg:downsamplingParam.end:downsamplingParam.step );
        
    end
end



