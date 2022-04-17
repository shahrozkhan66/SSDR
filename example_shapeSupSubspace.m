% This is the example to generate subspace using the shape signature vector 
% where the shape signature vector is composed of desgin grid and second
% order moemnt vector (M^2)
clc
clear all
close all

addpath('./src')

load wingSamples
load wingMoments


%------ Normalise the design grid and and moments to have unit variance. In
%this case sum of KL_values of will be 2 (1 for design grid and 1 for moemnts)
% Normalising deign grid
normSamples = samples./sqrt(sum(var(samples)));
% Normalising moments 
secondOrderWingMoments = wingMoments(:,2:7);
normSecondOrderWingMoments = secondOrderWingMoments./sqrt(sum(var(secondOrderWingMoments)));


%------ Getting discretisation of Shape Signature Vector (SSV)
SSV = cat(2, normSamples, normSecondOrderWingMoments);


%------ Implimenting the Karhunen-Loève expansion
[KL_modes, KL_values] = KLE(SSV, 0);


%------ calculating the variance retained as a cumulative sum of KL_values
varRetained = (cumsum(KL_values)/sum(KL_values))*100;
[~,n_comp] = max(varRetained >= 95);
disp(['Dimensionality of Subspace: ' num2str(n_comp)])


%------ seclecting the first "n_comp" KL_modes and KL_values
%------ Incase of shape supervised we will only select rows of each KL_mode
%equal to the size of number of samples. That is why "1:size(samples,2)" is
%added below
KL_modes = KL_modes(1:size(samples,2), 1:n_comp);
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
axis equal off
%---- 2nd KL_mode
figure
plotKLmode(parentDesign, reshape(KL_modes(1:size(samples,2), 2),[size(samples,2)/3,3]))
axis equal off
%---- 3rd KL_mode
figure
plotKLmode(parentDesign, reshape(KL_modes(1:size(samples,2), 3),[size(samples,2)/3,3]))
axis equal off