function [] = showNet(xi,AA,nNeurons,figNum)
nLayers = length(nNeurons);
figure(figNum);
hold off
maxHeight = max(nNeurons(2:end)) + 1;
for layer = 2:nLayers
    neurInLayer = nNeurons(layer);
    xPos = layer*ones(neurInLayer,1);
    yPos = (maxHeight:-1:(maxHeight - neurInLayer+1))';
    aLayer = AA(1:nNeurons(layer),layer);    
    colours = [aLayer,zeros(size(aLayer)),1-aLayer];
    scatter(xPos,yPos, 100, colours,'.');
    hold on        
end

team1 = find(xi(1:30) == 1,1);
team2 = find(xi(31:60) == 1,1);
margins = xi(61:63,:);

labels = [team1;team2;margins];

xPos = ones(1,5);
yPos = (maxHeight:-1:(maxHeight - 4));
text(xPos,yPos,cellstr(num2str(labels)));
title(['Team ',num2str(team1),' vs Team ',num2str(team2)]);
xlabel('Layer');
ylabel('Neuron');
hold off;
axis([0,nLayers+1,0,maxHeight+1]);
pause(.1);

end

