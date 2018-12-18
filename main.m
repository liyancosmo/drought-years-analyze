% �����ļ�������������ˣ��Ͳ��ᵯ��ѡ���ļ�
filename = 'datas/QTP.xlsx';

% ����ѡ���ļ���ʹ�����úõ��ļ���
select_file_title = 'ѡ���ļ�';
if exist('filename', 'var') && exist(filename, 'file')
    [filename, filesuffix] = split_filename(filename);
else
    [filename, filesuffix] = select_file('ѡ���ļ�');
end

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