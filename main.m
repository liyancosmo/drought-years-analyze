% 选择文件
[filename, filesuffix] = select_file('选择文件');

% 加载数据
data = load_data([filename, filesuffix]);

% 分析干旱年
result = analyze_drougths(data, 'windowsize', 5, 'cs', 2);

% 保存分析结果为excel表
summary_analyze(result, [filename, '.out', filesuffix]);

% 画图timeline选项
%   'years': 使用年份作为横坐标
%   'times': 使用次数作为横坐标
timeline = 'times';

% 画图linestyle选项
%   '.':  不同颜色的点
%   '.b': 全蓝色点
linestyle = '.';

% 画图MAR上限（设为 Inf 表示不设上限）
upperMAR = Inf;

% 每个工作表的所有树画一张图
plot_analyze(result, filename, 'timeline', timeline, 'linestyle', linestyle, 'upperMAR', upperMAR);

% 所有工作表的所有树画一张图
plot_analyze(result, filename, 'gather', true, 'timeline', timeline, 'linestyle', linestyle, 'upperMAR', upperMAR);