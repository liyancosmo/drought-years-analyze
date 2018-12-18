function [ filename, filesuffix ] = select_file( title )
if exist('default_filename.mat', 'file'); load('default_filename.mat'); end
if ~exist('default_filename', 'var'); default_filename = ''; end
filterstr = '*.xlsx;*.xls';
% filterstrsplit = strsplit(filterstr, ';');
[filename, filedir, filterindex] = uigetfile(filterstr, title, default_filename);
if filterindex == 0
    throw(MException('DroughtYearsAnalyze:select_file', 'Didn''t select any file'));
end
filename = fullfile(filedir, filename);
default_filename = filename;
save('default_filename.mat', 'default_filename');
lastdot = strfind(filename, '.');
filesuffix = filename(lastdot:end);
filename = filename(1:lastdot-1);
end

