function [KL_modes, KL_values] = KLE(samples)

% Karhunen-Loève expansion (KLE): This function impliments KLE/PCA on a
% given dataset
% !! Important !! this function uses matlab's "gpuArray" for performance
% Calling Sequence:
% 
%   [KL_modes, KL_values] = KLE(samples)
%   
%    INPUT:
%   
%      !samples - A n x m matrix, where n are designs and m is the design
%      !grid in x,y,z coordinates. 
%   
%    OUTPUT:
%   
%      KL_modes - m x m matrix with each column is the i^th eigenvector
%      KL_values - 1 x m vector of eigenvalues
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

%centering
centeredSamples = bsxfun(@minus, samples, mean(samples));
N = size(samples,1);

%Covariance Matrix
covMatrix = (centeredSamples'*centeredSamples)./(N-1);%cov(normSamplesWei);%
gpuCovMatrix = gpuArray(covMatrix);

%EigenDecomposition
[KL_modes, KL_values] = eig(gpuCovMatrix);
KL_modes = real(gather(KL_modes));
[ KL_values, KL_values_index] = sort(real(diag(gather(KL_values))));
KL_values_index = flip(KL_values_index);
KL_values = flip(KL_values);
KL_modes = KL_modes(:, KL_values_index);
end