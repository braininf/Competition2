%ָ�����ڷ�������IP���˿ں�
t = tcpip('localhost',31500);
%����
fopen(t)
%�����ɼ��ź�
fwrite(t,'$00T')
%����9���ַ�����ʱ,����
% A = fread(t, 512);

while true
    pause(3);
    fwrite(t,'BCIID01CH00A' );

end


fclose(t)