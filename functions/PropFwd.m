function [AA] = PropFwd(inVec, TT, nNeurons)

nLayers = length(nNeurons);
max_len = length(TT(:,1,1));
AA = zeros(max_len, nLayers);
for idx = 1:nLayers
    if (idx == 1)
        theta = TT(1:nNeurons(idx)+1,1:length(inVec),idx);
        aa = CalcInnerLayer(theta, inVec);
    else
        theta = TT(1:nNeurons(idx)+1,1:nNeurons(idx-1)+1,idx);
        aa = CalcInnerLayer(theta, aa);
    end
    bb = zeros(max_len,1);
    bb(1:length(aa),1) = aa;
    AA(:,idx) = bb;
end


end

