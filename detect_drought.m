function [ isdrought ] = detect_drought( data, varargin )
% detect drought years
% options:
%     cs: coefficient of standard deviation

cs = 1;
for i = 1:length(varargin)
    if ischar(varargin{i}) && strcmpi(varargin{i}, 'varargin')
        varargin = [varargin,varargin{i+1}];
    end
end
for i = 1:length(varargin)
    if ischar(varargin{i})
        if strcmpi(varargin{i}, 'cs')
            i= i+1; cs = varargin{i};
        end
    end
end

ntrees = size(data,1);
nyears = size(data,2);
meanv = repmat(nanmean(data, 2), [1,nyears]);
stdv = repmat(nanmean((data-meanv).^2, 2).^0.5, [1,nyears]);
thv = meanv - stdv * cs;
isdrought = int32(data < thv);
isdrought = ((isdrought - [isdrought(:,2:end),zeros([ntrees,1])]) > 0);
end

