% x�����ݣ�y�Ǳ�ǩ
% x��ά������Ϊ���������缫����������ʱ�䳤�ȣ���ÿ����˸��ÿ��������trial��
% y�����Ӧx������ά��ÿ��trial�ı�ǣ�1ΪĿ�꣬-1Ϊ��Ŀ��
% x�ĵ�����ά���ϣ�����Ŀ����������

%%  ѵ��
x = x(channels,:,:);  % channels Ϊ��Ҫ�ĵ�����������Ҫ�Լ�����
w = windsork;
w = trainw(w,x,0.1);  % w���±ߵ�n���ǲ���ʱ����Ҫ�õ��Ĳ���
x = applyw(w,x);
n = normalizen;
n = trainn(n,x,'z-score');
x = applyn(n,x);  % ���ϣ���������
tnan=isnan(x);
x(tnan)=100;  

n_channels = length(channels);
n_samples = size(x,2);
n_trials = size(x,3);
x = reshape(x,n_samples*n_channels,n_trials);

b = bayesldab(1);
b = trainbye(b,x,y);  % ����ѵ��ģ��b


%% ������

x = x(channels,:,:);
x = applyw(w,x);
x = applyn(n,x);
n_trials = size(x,3);
x = reshape(x,n_channels*n_samples,n_trials);
tnan=isnan(x);
x(tnan)=100;    %��ѵ��ʱһ������������
y = classifybye(b,x); % ��������
% �ó�����y����trial��score��scoreԽ�󣬶�ӦtrialԽ��������Ŀ��
% ͨ�������ǻ�Ѷ��ʵ���м������y���е��ӣ���ȡ���ȶ��Ľ��
% ���巽���ͼ���ϸ�ڣ����Բο���(jing jin)��ʦ�����¡�
