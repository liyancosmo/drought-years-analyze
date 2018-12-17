function [  ] = plot_analyze( result, dirname, varargin )
nvarargin = length(varargin);
gather = false;
useyears = false;
linestyle = '.';
upperMAD = Inf;
lowerMAD = 0;
upperMAR = Inf;
lowerMAR = 0;
for i = 1:nvarargin
    if ischar(varargin{i})
        if strcmpi(varargin{i}, 'gather')
            gather = true;
        elseif strcmpi(varargin{i}, 'linestyle')
            i = i + 1;
            linestyle = varargin{i};
        elseif strcmpi(varargin{i}, 'timeline')
            i = i + 1;
            timeline = varargin{i};
            if strcmpi(timeline, 'years')
                useyears = true;
            end
        elseif strcmpi(varargin{i}, 'upperMAD')
            i = i + 1;
            upperMAD = varargin{i};
        elseif strcmpi(varargin{i}, 'lowerMAD')
            i = i + 1;
            lowerMAD = varargin{i};
        elseif strcmpi(varargin{i}, 'upperMAR')
            i = i + 1;
            upperMAR = varargin{i};
        elseif strcmpi(varargin{i}, 'lowerMAR')
            i = i + 1;
            lowerMAR = varargin{i};
        end
    end
end

if ~exist(dirname, 'dir'); mkdir(dirname); end

% figure(s) for MAD
for i = 1:length(result)
    sheetname = result(i).sheet;
    data = result(i).result;
    ntrees = length(data);
    for j = 1:ntrees
        MAD = data(j).MAD;
        MAD(MAD > upperMAD) = nan;
        MAD(MAD < lowerMAD) = nan;
        if useyears; xser = data(j).years;
        else xser = 1:length(MAD); end
        plot(xser, MAD, linestyle);
        hold on;
    end
    if ~gather
        % if not gather, we stop figure here and save
        hold off;
        print(gcf, fullfile(dirname, [sheetname '.MAD.jpg']), '-djpeg');
        close(gcf);
    end
end
if gather
    % if gather, the figure will hold until here, and we save
    hold off;
    print(gcf, fullfile(dirname, 'all.MAD.jpg'), '-djpeg');
    close(gcf);
end

% figure(s) for MAR
for i = 1:length(result)
    sheetname = result(i).sheet;
    data = result(i).result;
    ntrees = length(data);
    for j = 1:ntrees
        MAR = data(j).MAR;
        MAR(MAR > upperMAR) = nan;
        MAR(MAR < lowerMAR) = nan;
        if useyears; xser = data(j).years;
        else xser = 1:length(MAR); end
        plot(xser, MAR, linestyle);
        hold on;
    end
    if ~gather
        % if not gather, we stop figure here and save
        hold off;
        print(gcf, fullfile(dirname, [sheetname '.MAR.jpg']), '-djpeg');
        close(gcf);
    end
end
if gather
    % if gather, the figure will hold until here, and we save
    hold off;
    print(gcf, fullfile(dirname, 'all.MAR.jpg'), '-djpeg');
    close(gcf);
end
end

