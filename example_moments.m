clc
clear all
close all

addpath('./src')

figure
%To visualise the design
TR = stlread('wing_0.stl');
triplot(TR)
drawnow
%--- from version 2022a and onwards
% gm = importGeometry('Torus.stl');
% pdegplot(gm)
% drawnow


% If isCentral = 1, then moment(s) will be central or translation invariant 
% (i.e., evaluated by place the object at its centeriod). 
%In this case, all first order moments will be zero by defination
isCentral = 1;
% if isScaled = 1, then moment(s) will be scaled invariant.
% In this case, Zeroth Order moment (i.e., the volume) will be m_000=1.
isScaled = 1;


% To calculate moment(s), the shape should be composed of all triangulated
% mesh elements. !!Important!!
p=2; q=0; r=0; % In this case the order of the moment will be s=p+q+r
moment = sthOrderGeometricMoment('wing_0.stl', p,q,r,isCentral,isScaled); %This will evaluate a single m_pqr moment with order s=p+q+r 
disp(['m_' num2str(p) num2str(q) num2str(r) ' = ' num2str(moment)])


% this function will evaluate a moment vector (M^s) containing all s-order
% moments M^s = m_pqr, where p,q,r = {1,2,3,....} such that s=p+q+r
% For examples, for s=2 moemnt vector will be M^2 ={m_200, m_020, m_002, m_110, m_011, m_101}
% contains (s+1)(s+2)/2 components. In case of s=2, M^2 contains 6
% components.
s = 2; % order of the moment vector 
moments = sthOrderGeometricMomentVector('wing_0.stl', s,isCentral,isScaled);
disp(moments)