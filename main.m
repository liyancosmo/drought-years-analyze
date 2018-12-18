% ѡ���ļ�
[filename, filesuffix] = select_file('ѡ���ļ�');

% ��������
data = load_data([filename, filesuffix]);

% �����ɺ���
result = analyze_drougths(data, 'windowsize', 5, 'cs', 2);

% ����������Ϊexcel��
summary_analyze(result, [filename, '.out', filesuffix]);

% ��ͼtimelineѡ��
%   'years': ʹ�������Ϊ������
%   'times': ʹ�ô�����Ϊ������
timeline = 'times';

% ��ͼlinestyleѡ��
%   '.':  ��ͬ��ɫ�ĵ�
%   '.b': ȫ��ɫ��
linestyle = '.';

% ��ͼMAR���ޣ���Ϊ Inf ��ʾ�������ޣ�
upperMAR = Inf;

% ÿ�����������������һ��ͼ
plot_analyze(result, filename, 'timeline', timeline, 'linestyle', linestyle, 'upperMAR', upperMAR);

% ���й��������������һ��ͼ
plot_analyze(result, filename, 'gather', true, 'timeline', timeline, 'linestyle', linestyle, 'upperMAR', upperMAR);