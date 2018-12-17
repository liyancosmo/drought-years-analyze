function [ data ] = load_data( filename )
% <OUT> data: a 1xS struct where S is number of sheets
%             fields:
%                 sheet: the sheet name (string)
%                 names: the names of the trees (Nx1 cell)
%                 years: the years series (1xT vector)
%                 data: TRW data (NxT matrix)

% [~,sheetnames] = xlsfinfo(filename);
tabledata = importdata(filename);
sheetnames = fieldnames(tabledata.data);
data = struct;
for isheet = 1:length(sheetnames)
    sheetname = sheetnames{isheet};
    if isfield(tabledata, 'colheaders') && isfield(tabledata.colheaders, sheetname)
        headers = transpose(tabledata.colheaders.(sheetname));
        sheetdata = transpose(tabledata.data.(sheetname));
    elseif isfield(tabledata, 'rowheaders') && isfield(tabledata.rowheaders, sheetname)
        headers = tabledata.rowheaders.(sheetname);
        sheetdata = tabledata.data.(sheetname);
    else
        continue;
    end
    for i = 1:length(headers)
        headers{i} = strtrim(headers{i});
    end
    yearrow = [];
    for i = 1:length(headers)
        if strcmpi(headers{i}, 'year')
            yearrow = i;
            break;
        end
    end
    if isempty(yearrow)
        continue;
    end
    nonyearrows = (1:length(headers))~=yearrow;
%     st = struct;
    data(isheet).sheet = sheetname;
    data(isheet).names = headers(nonyearrows);
    data(isheet).years = sheetdata(yearrow,:);
    data(isheet).data = sheetdata(nonyearrows,:);
%     data{isheet} = st;
end
end

