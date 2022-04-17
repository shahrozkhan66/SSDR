function moment = sthOrderGeometricMoment(designFileName, p, q, r, isCentral, isScaled)
% !!!Important!!!
% These function use "parfor loop". If you dont have that plugin then
% simply change "parfor" to "for" at line 47 and 60.
%
%
% sthOrderMoment: evaluate a s^th order geometric moment, where s=p+q+r 
%
%   moment = sthOrderMoment(designFileName, p, q, r, isCentral, isScaled)
%
%    INPUT:
%   
%      !designFileName - name of the stl file (To calculate moment(s), the 
%       shape should be composed of all triangulated mesh elements.)
%      !p, q, r -  which moment to evaluate 
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
%      moment - it gives m_pqr moment of order s=q+p+r
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

warning('off','all')
s = p+q+r; % the order of the moment(s)
S_out = matrixForMoment(p, q, r);
%reading the design
[TR,~,~,~] = stlread(designFileName);
moment = 0;

m_000 = 0; m_100 = 0; m_010 = 0; m_001 = 0;
parfor i = 1:size(TR,1)
    A = [TR.Points(TR.ConnectivityList(i,1),:);TR.Points(TR.ConnectivityList(i,2),:);TR.Points(TR.ConnectivityList(i,3),:)];
    a1 = A(1,1); a2 = A(1,2); a3 = A(1,3);
    b1 = A(2,1); b2 = A(2,2); b3 = A(2,3);
    c1 = A(3,1); c2 = A(3,2); c3 = A(3,3);
    m_000 = m_000 + 1/6*det(A);
    m_100 = m_100 + 1/24*det(A)*(a1+b1+c1);
    m_010 = m_010 + 1/24*det(A)*(a2+b2+c2);
    m_001 = m_001 + 1/24*det(A)*(a3+b3+c3);
end

centriod = [m_100/m_000, m_010/m_000, m_001/m_000];

parfor l = 1:size(TR,1)
    A = [TR.Points(TR.ConnectivityList(l,1),:);TR.Points(TR.ConnectivityList(l,2),:);TR.Points(TR.ConnectivityList(l,3),:)];
    if (isequal(isCentral,1))
        A = A - centriod;
    end
    A = A';
    % -- First Term
    term1 = det(A)*factorial(p)*factorial(q)*factorial(r)/factorial(s + 3);
    % -- Second Term
    term2 = 0;
    for i = 1:size(S_out,3)
        K = S_out(:,:,i);
        numerator = factorial(K(1,1)+K(2,1)+K(3,1))*factorial(K(1,2)+K(2,2)+K(3,2))*factorial(K(1,3)+K(2,3)+K(3,3));
        denominator = factorial(K(1,1))*factorial(K(1,2))*factorial(K(1,3))...
            *factorial(K(2,1))*factorial(K(2,2))*factorial(K(2,3))...
            *factorial(K(3,1))*factorial(K(3,2))*factorial(K(3,3));
        exterm_right_term = A(1,1)^K(1,1)*A(1,2)^K(1,2)*A(1,3)^K(1,3)...
            *A(2,1)^K(2,1)*A(2,2)^K(2,2)*A(2,3)^K(2,3)...
            *A(3,1)^K(3,1)*A(3,2)^K(3,2)*A(3,3)^K(3,3);
        term2 = term2 + ((numerator/denominator)*exterm_right_term);
    end
    moment = moment + (term1*term2);
end
if(isequal(isScaled,1))
    moment = moment/(m_000^(1+((s)/3)));
end
end
