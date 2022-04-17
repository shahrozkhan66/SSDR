% This is the example to generate subspace in a typical setting when we
% only use design grid. 
clc
clear all
close all

addpath('./src')

load wingSamples


%------ Normalise the design grid to have unit variance.
normSamples = samples./sqrt(sum(var(samples)));


%------ Implimenting the Karhunen-Loève expansion
[KL_modes, KL_values] = KLE(normSamples, 0);


%------ calculating the variance retained as a cumulative sum of KL_values
varRetained = (cumsum(KL_values)/sum(KL_values))*100;
[~,n_comp] = max(varRetained >= 95);
disp(['Dimensionality of Subspace: ' num2str(n_comp)])


%------ seclecting the first "n_comp" KL_modes and KL_values
KL_modes = KL_modes(:, 1:n_comp);
KL_values = KL_values(1:n_comp);


%------ evaluating the bounding limits of the subspace
subspace = evlSubspaceLimits(samples, KL_modes, KL_values, 1);


%------ Creating designs from the subspace 
subspace_samples = randomSamples(subspace,10);
for i=1:size(subspace_samples,1)
    designFromSubspace(subspace_samples(i,:), KL_modes, samples)
    drawnow
end


%------Ploting first 3 KL_modes on the parent wing design
parentDesign = readmatrix('parentWing.csv');
%--- 1st KL_mode
figure
plotKLmode(parentDesign, reshape(KL_modes(1:size(samples,2), 1),[size(samples,2)/3,3]))
%---- 2nd KL_mode
figure
plotKLmode(parentDesign, reshape(KL_modes(1:size(samples,2), 2),[size(samples,2)/3,3]))
%---- 3rd KL_mode
figure
plotKLmode(parentDesign, reshape(KL_modes(1:size(samples,2), 3),[size(samples,2)/3,3]))