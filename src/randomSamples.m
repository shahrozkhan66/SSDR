function samples = randomSamples(designSpace,numOfDesigns)

% randomSamples: This function randomly samples design from a give design
% space
% 
%   samples = randomSamples(designSpace,numOfDesigns)
%    INPUT:
%   
%      !designSpace - (k x 2) a matrix with lower and upper limits of a design space 
%       where k are the numebr of variables and first column are lower
%       limits and second column is upper limit.
%      !numOfDesigns - numeber of designs to be sampled 
%    OUTPUT:
%   
%      samples - (n x m) A matrix with n samples m variables 
%
% Copyright (C) 2022 Shahroz Khan (https://www.shahrozkhan.info/)
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.

%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.

samples = zeros(numOfDesigns, size(designSpace,1));
    for j = 1:size(designSpace,1)
        samples(:,j) = designSpace(j,1) + (designSpace(j,2)-designSpace(j,1)).*rand(numOfDesigns,1);
    end
end