%指定串口服务器的IP及端口号
t = tcpip('localhost',31500);
%连接
fopen(t)
%发出采集信号
fwrite(t,'$00T')
%当有9个字符返回时,读出
% A = fread(t, 512);

while true
    pause(3);
    fwrite(t,'BCIID01CH00A' );

end


fclose(t)