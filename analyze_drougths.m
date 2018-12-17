function [ outdata ] = analyze_drougths( indata, varargin )
nvarargin = length(varargin);
windowsize = 4;
for i = 1:nvarargin
    if ischar(varargin{i})
        if strcmpi(varargin{i}, 'windowsize')
            i = i + 1;
            windowsize = varargin{i};
        end
    end
end

fprintf('Analyze Params:\n');
fprintf('   Window Size: %d\n', windowsize);

outdata = struct;
for i = 1:length(indata)
    data = indata(i).data;
    years = indata(i).years;
    ntrees = size(data,1);
    nyears = size(data,2);
    isdrought = detect_drought(data, 'varargin', varargin);
    outdata(i).sheet = indata(i).sheet;
    outdata(i).result = struct;
    for j = 1:ntrees
        isdroughtj = isdrought(j,:);
        MAD = nan(1,nyears); % mean value of the 4 years after drought
        MAR = nan(1,nyears); % MAD / value of the drought
        YFR = nan(1,nyears); % how many years for recorver
        FNR = false(1,nyears); % if it is not recovered until next drought
        for k = find(isdroughtj)
            CUR = data(j,k);
            if CUR <= 0.001; CUR = nan; end
            % MAD(k) = nanmean(data(j,k+1:end));
            MAD(k) = nan; if k < nyears; MAD(k) = nanmean(data(j,k+1:min(k+windowsize,nyears))); end
            MAR(k) = MAD(k) / CUR;
            FNRval = true;
            YFRval = 0;
            for kk = k+1:nyears
                YFRval = YFRval + 1;
                if isdrought(j,kk)
                    % if meet the next drought, break with unfound recover
                    break;
                end
                if data(j,kk) > 1
                    % if meet a year of TRW>1, break with recover
                    FNRval = false;
                    break;
                end
            end
            if YFRval == 0; YFRval = nan; end
            YFR(k) = YFRval;
            FNR(k) = FNRval;
        end
        outdata(i).result(j).name = indata(i).names{j};
        outdata(i).result(j).years = years(isdroughtj);
        outdata(i).result(j).MAD = MAD(isdroughtj);
        outdata(i).result(j).MAR = MAR(isdroughtj);
        outdata(i).result(j).YFR = YFR(isdroughtj);
        outdata(i).result(j).FNR = FNR(isdroughtj);
    end
end
end

