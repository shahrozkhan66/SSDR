function allMoments = sthOrderGeometricMomentVector(designFileName, momentToEvaluate, isCentral, isScaled)

% sthOrderMomentVector: this function will evaluate a moment vector (M^s) 
%   containing all s-order moments M^s = m_pqr, where p,q,r = {1,2,3,....} 
%   such that s=p+q+r. For examples, for s=2 moemnt vector will be M^2 =
%   {m_200, m_020, m_002, m_110, m_011, m_101} contains (s+1)(s+2)/2 
%   components.
%
%   allMoments = sthOrderMomentVector(fileName, momentToEvaluate,isCentral,
%       isScaled)
%
%    INPUT:
%   
%      !designFileName - name of the stl file (To calculate moment(s), the 
%       shape should be composed of all triangulated mesh elements.)
%      !momentToEvaluate -  which order of moments to be evaluated
%      !isCentral - If isCentral = 1, then moment(s) will be central or
%       translation invariant (i.e., evaluated by place the object at its 
%       centeriod). In this case, all first order moments will be zero by 
%       defination.
%      !isScaled - if isScaled = 1, then moment(s) will be scaled 
%       invariant. In this case, Zeroth Order moment (i.e., the volume) 
%       will be m_000=1.
%
%    OUTPUT:
%   
%      allMoments - vector of all s^th order moments
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

for j=1:length(momentToEvaluate)
    temp = findNDigitNums(3, momentToEvaluate(j));
    for i = 1:size(temp,1)
        if (i==1)
            allOrder = unique(perms(temp(i,:)),'row');
        else
            allOrder = cat(1, allOrder, unique(perms(temp(i,:)),'row'));
        end
    end
    if (j==1)
        allOrderS = unique(allOrder, 'row');
    else
        allOrderS = cat(1, allOrderS, unique(allOrder, 'row'));
    end
end

momentName = {};
for i = 1:size(allOrderS,1)
    momentName{i} = ['m_' num2str(allOrderS(i,1)) num2str(allOrderS(i,2)) num2str(allOrderS(i,3))];
end

% Evaluating all moments of a certain order
allMoments = zeros(1, size(allOrderS,1));
for i = 1:size(allOrderS,1)
    allMoments(i) = sthOrderGeometricMoment(designFileName, allOrderS(i,1), allOrderS(i,2), allOrderS(i,3),isCentral, isScaled);
end
allMoments = array2table(allMoments);
allMoments.Properties.VariableNames = momentName;
end