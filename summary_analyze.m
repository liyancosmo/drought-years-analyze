function [  ] = summary_analyze( result, filename )
for i = 1:length(result)
    sheetname = result(i).sheet;
    data = result(i).result;
    maxlen = 0;
    ntrees = length(data);
    for j = 1:ntrees; maxlen = max(length(data(j).years), maxlen); end
    sheettable = cell(5*ntrees, maxlen+1);
    for j = 1:size(sheettable,1); for k = 1:size(sheettable,2); sheettable{j,k} = ''; end; end
    for j = 1:ntrees
        idx1 = 5*(j-1)+1;
        sheettable{idx1,1} = strcat(data(j).name, ' Years');
        sheettable{idx1+1,1} = strcat(data(j).name, ' MAD');
        sheettable{idx1+2,1} = strcat(data(j).name, ' MAR');
        sheettable{idx1+3,1} = strcat(data(j).name, ' YFR');
        for k = 1:length(data(j).years)
            sheettable{idx1,k+1} = num2str(data(j).years(k));
            sheettable{idx1+1,k+1} = num2str(data(j).MAD(k));
            sheettable{idx1+2,k+1} = num2str(data(j).MAR(k));
            YFRval = data(j).YFR(k);
            if ~isnan(YFRval)
                YFRstr = num2str(YFRval);
                if data(j).FNR(k); YFRstr = strcat(YFRstr, '*'); end
                sheettable{idx1+3,k+1} = YFRstr;
            end
        end
    end
    xlswrite(filename, sheettable, sheetname);
end
end

