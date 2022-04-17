% A Matlab recursive program to print all n-digit
% numbers whose sum of digits equals to given sum
%Recursive function to print all n-digit numbers
% whose sum of digits equals to given sum
 
% n, sum --> value of inputs
% out --> output array
% index --> index of next digit to be filled in
%           output array
% This is mainly a wrapper over findNDigitNumsUtil.
% It explicitly handles leading digit
function output2 = findNDigitNums(n, sum)
    delete('matrixMoment_dontDelete.csv')
    writematrix(zeros(1, n), 'matrixMoment_dontDelete.csv');
    % output array to store N-digit numbers
    out = {};
    % fill 1st position by every digit from 1 to 9 and
    % calls findNDigitNumsUtil() for remaining positions
    for i = 1:9
        out{1} = num2str(i);
        findNDigitNumsUtil(n, sum - i, out, 1);
    end
    output2 = readmatrix('matrixMoment_dontDelete.csv');
    output2 = output2(2:end,:);
    delete('matrixMoment_dontDelete.csv')
end

function findNDigitNumsUtil(n, sum, out, index)
    % Base case
    if (index > n) || (sum < 0)
        return;
    end
    % If number becomes N-digit
    if (index == n)
        % if sum of its digits is equal to given sum,
        % print it
        if(sum == 0)
            output1 = readmatrix('matrixMoment_dontDelete.csv');
            output1 = cat(1, output1, cellfun(@(x)str2double(x), out));
            writematrix(output1, 'matrixMoment_dontDelete.csv');
            %disp(out)
        end
        return;
     end
 
    % Traverse through every digit. Note that
    % here we're considering leading 0's as digits
    for i = 0:9
        % append current digit to number
        out{index+1} = num2str(i);
 
        % recurse for next digit with reduced sum
        findNDigitNumsUtil(n, sum - i, out, index + 1);
     end
end
