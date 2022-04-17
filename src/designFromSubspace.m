function designFromSubspace(designToGen, KL_modes, samples)

% designFromSubspace: This function shows a design generated from the
% subsapce
%
%   !! Only be used for Wing Case !!
%   !! For your case changes in lines 36-38 will be required
%
%   designFromSubspace(designToGen, KL_modes, samples)
%
%    INPUT:
%   
%      !designToGen - (1 x k) a latent variable vector from the subspace
%       limits and second column is upper limit.
%      !KL_modes - output of KLE function with only first k column with caputre 95% of the variance
%      !samples - A n x m matrix, where n are designs and m is the design
%      grid in x,y,z coordinates (These samples will be same used to apply KLE). 
%
%    OUTPUT:
%   
%      Show design 
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

    normSamples = samples./sqrt(sum(var(samples)));
    mu = mean(normSamples);
    design3D = bsxfun(@plus, designToGen * KL_modes', mu)*sqrt(sum(var(samples)));
    design3D = reshape(design3D,[],3);
    points_x = reshape(design3D(:,1),[25,90]);
    points_y = reshape(design3D(:,2),[25,90]);
    points_z = reshape(design3D(:,3),[25,90]);
    %-- Surface Plot 
    mesh(points_x,points_y,points_z);
    shading interp
    set(gca,'YTickLabel',[]);
    set(gca,'XTickLabel',[]);
    axis equal off
end