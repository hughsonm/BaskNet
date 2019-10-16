function [AA] = PropFwdAutoBP(inVec, TT, nNeurons)

nLayers = length(nNeurons);
max_neurons = max([max(nNeurons),length(inVec)]);
AA = zeros(max_neurons+1, nLayers);
AA(1:length(inVec)+1,1) = [inVec;1];
for idx = 1:nLayers-1
    aa = AA(1:nNeurons(idx)+1,idx);
    theta = TT(1:nNeurons(idx+1)+1,1:nNeurons(idx)+1,idx);
    next_aa = CalcInnerLayer(theta, aa);
    bb = zeros(max_neurons+1,1);
    bb(1:length(next_aa),1) = next_aa;
    AA(:,idx+1) = bb;
end


end

