% x是数据，y是标签
% x的维度依次为，导联（电极），点数（时间长度），每个闪烁（每个样本，trial）
% y代表对应x的三个维度每个trial的标记，1为目标，-1为非目标
% x的第三个维度上，根据目标次序整理好

%%  训练
x = x(channels,:,:);  % channels 为需要的导联数量，需要自己设置
w = windsork;
w = trainw(w,x,0.1);  % w和下边的n都是测试时候需要用到的参数
x = applyw(w,x);
n = normalizen;
n = trainn(n,x,'z-score');
x = applyn(n,x);  % 以上，整理特征
tnan=isnan(x);
x(tnan)=100;  

n_channels = length(channels);
n_samples = size(x,2);
n_trials = size(x,3);
x = reshape(x,n_samples*n_channels,n_trials);

b = bayesldab(1);
b = trainbye(b,x,y);  % 产生训练模型b


%% 做测试

x = x(channels,:,:);
x = applyw(w,x);
x = applyn(n,x);
n_trials = size(x,3);
x = reshape(x,n_channels*n_samples,n_trials);
tnan=isnan(x);
x(tnan)=100;    %和训练时一样，整理数据
y = classifybye(b,x); % 测试数据
% 得出来的y代表trial的score，score越大，对应trial越可能有是目标
% 通常，我们会把多次实验中计算出的y经行叠加，以取得稳定的结果
% 具体方法和技术细节，可以参考金晶(jing jin)老师的文章。
