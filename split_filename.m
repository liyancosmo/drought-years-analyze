function [ filename, filesuffix ] = split_filename( original_filename )
lastdot = strfind(original_filename, '.');
if isempty(lastdot)
    throw(MException('DroughtYearsAnalyze:select_file', 'Filename do not have a suffix'));
end
filesuffix = original_filename(lastdot:end);
filename = original_filename(1:lastdot-1);
end

