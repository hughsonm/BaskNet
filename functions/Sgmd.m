function [ pp ] = Sgmd(zz)
%Sgmd The Sigmoid Function
%   S(z) = 1/(1+exp(-z)) is a smoother step function.
    pp = 1.0 ./ (1.0 + exp(-zz));
end

