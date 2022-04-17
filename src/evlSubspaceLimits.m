function subspace = evlSubspaceLimits(samples, KL_modes, KL_values, whichMethod)

% evlSubspaceLimits: This function calculates the bounding limits for the
% subspace
% 
%   subspace = evlSubspaceLimits(samples, KL_modes, KL_values, whichMethod)
%   
%    INPUT:
%   
%      !samples - A n x m matrix, where n are designs and m is the design
%      grid in x,y,z coordinates (These samples will be same used to apply KLE). 
%      !KL_modes - output of KLE function with only first k column with caputre 95% of the variance
%      !KL_values - output of KLE function with only first k values 
%      !whichMethod - if whichMethod =1, then subspace limits will be maximum 
%       and minimum values in the lower-dimensionl representation of samples. 
%       If whichMethod =2, then subspace limits will be taken as 3 standard 
%       deviation of KL_values. Both methods are use in literature.
%    OUTPUT:
%   
%      subspace - Lower and upper limits of all the latent variables
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

if (whichMethod==1)
    normSamples = samples./sqrt(sum(var(samples)));
    mu = mean(normSamples);
    alpha = bsxfun(@minus,normSamples,mu)*KL_modes;
    lowerLimit =  min(alpha,[],1);
    upperLimit =  max(alpha,[],1);
    subspace = [lowerLimit' upperLimit'];
elseif(whichMethod==2)
    subspace = [-sqrt(3*KL_values) sqrt(3*KL_values)];
else
    msgbox("No bounding limit method is specified","Bounding Limits");
end
end