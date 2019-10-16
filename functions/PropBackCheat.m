function [newTT] = PropBackCheat(TT,AA,nNeurons,xi,yi,rate)

% Cheat by knowing there are two layers, 2 neurons in the first layer and
% one neuron in the second layer.

nLayers = length(nNeurons);

finalA = AA(1:nNeurons(end),nLayers);
del = (finalA) .* (1-finalA) * (finalA - yi);

newTT = zeros(size(TT));


aVec = AA(:, 1);
for jj = 1:3
    stp = rate * del * aVec(jj);
    newTT(1, jj, 2) = TT(1,jj,2) - stp;
end

theta2 = TT(1:1,1:3,2);
theta1 = TT(1:3,1:3,1);
for ii = 1:2
    for jj = 1:3
        stp = rate*del*theta2(1, ii)*aVec(ii)*(1-aVec(ii))*xi(jj);
        newTT(ii,jj,1) = TT(ii,jj,1)-stp;
    end
end


%
% for idx = nLayers:-1:1
%     % Go backwards through the layers
%     % Note: the thetas in the first row of theta can be ignored,
%     % except for the final layer.
%     if(idx == nLayers)
%         %Last Layer
%         theta = TT(nNeurons(idx),nNeurons(idx-1)+1,idx);
%         %Update each th in this layer
%         [rows,cols] = size(theta);
%         for ii = 1:rows
%             for jj = 1:cols
%                 newTT(ii,jj,idx) = TT(ii,jj,idx) - rate*del*AA(ii,idx-1);
%             end
%         end
%
%
%     elseif(idx == 1)
%         %First Layer
%         theta = TT(nNeurons(idx)+1,length(xi),idx);
%         %Update each th in this layer
%         [rows,cols] = size(theta);
%
%     else
%         %Middle layer
%         theta = TT(nNeurons(idx)+1,nNeurons(idx-1)+1,idx);
%         %Update each th in this layer
%         [rows,cols] = size(theta);
%         for ii = 1:rows
%             for jj = 1:cols
%                 th = theta(ii, jj);
%                 fact = GetBPFactor(idx,ii,jj,TT,AA,nNeurons);
%                 stp = del * fact * AA(idx,ii);
%             end
%         end
%
%     end
% end

end

