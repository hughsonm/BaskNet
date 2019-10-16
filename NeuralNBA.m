close all
clear all
clc

addpath('functions');

T_SCALE = 4;
RATE = .1;
THRESH_PCT = .81;
LOOK_BACK = 200;
MAX_ITER = 3000000;
N_TEAMS = 30;
N_TRIALS = 100;
SHOW_NET = 0;
NAMES = {
'Bucks'
'Bulls'
'Cavaliers'
'Celtics'
'Clippers'
'Grizzlies'
'Hawks'
'Heat'
'Hornets'
'Jazz'
'Kings'
'Knicks'
'Lakers'
'Magic'
'Mavericks'
'Nets'
'Nuggets'
'Pacers'
'Pelicans'
'Pistons'
'Raptors'
'Rockets'
'Seventysixers'
'Spurs'
'Suns'
'Thunder'
'Timberwolves'
'Trailblazers'
'Warriors'
'Wizards'
};

nNeurons = [N_TEAMS*2+3,...
    10,5,2,...    
    1];
nLayers = length(nNeurons);
maxTTDim = max(nNeurons+1);
TT = (T_SCALE * (rand(maxTTDim,maxTTDim,length(nNeurons)-1) - .5));

scores = dlmread('NBA2015Scores.csv');

sx = scores(:,1:5)';
sy = scores(:,6);

[~,nExamples] = size(sx);

xx = zeros(N_TEAMS*2+3,nExamples);
for nn = 1:nExamples
    xx(sx(1,nn),nn) = 1;
    xx(sx(2,nn)+N_TEAMS,nn) = 1;
    xx(N_TEAMS*2+1:N_TEAMS*2+3,nn) = sx(3:5,nn);
end

yy = sy';
yy(yy>0) = 1;
yy(yy<=0) = 0;


rates = zeros(nNeurons(end), MAX_ITER);
startt = cputime();
keep_going = 1;
ii = 1;

correct_rate = 0;

% Train the net

while(keep_going)
    % Get a training example
    rIdx = randi(nExamples);
    xi = xx(:,rIdx);
    yi = yy(:,rIdx);        
    AA = PropFwdAutoBP(xi, TT, nNeurons);
    is_correct = round(AA(1:nNeurons(nLayers),nLayers)) == yi;
    correct_rate = (correct_rate*ii + is_correct)/(ii+1);
    rates(:,ii) = correct_rate;
    newTT = PropBack(TT,AA,nNeurons,yi,RATE);
    TT = newTT;
    keep_going = ~prod(correct_rate > THRESH_PCT && ii < MAX_ITER);
    if(~mod(ii-1,10000))
        clc;
        disp(correct_rate);        
        if(SHOW_NET)
            showNet(xi,AA,nNeurons,3);
        end
    end
    ii = ii + 1;
end


% Read in verbose lists
tscores = dlmread('NBA2016Scores.csv');

tsx = tscores(:,1:5)';
tsy = tscores(:,6);

[~,nTExamples] = size(tsx);

tx = zeros(N_TEAMS*2+3,nTExamples);
for nn = 1:nTExamples
    tx(tsx(1,nn),nn) = 1;
    tx(tsx(2,nn)+N_TEAMS,nn) = 1;
    tx(N_TEAMS*2+1:N_TEAMS*2+3,nn) = tsx(3:5,nn);
end

ty = tsy';
ty(ty>0) = 1;
ty(ty<=0) = 0;

n_right = 0;
n_wrong = 0;
delete('MyGuesses.txt');
clc;
diary('MyGuesses.txt')
for trial = 1:nTExamples    
    rIdx = trial;
    txi = tx(:,rIdx);
    tyi = ty(:,rIdx);
    prop = PropFwdAutoBP(txi, TT, nNeurons);
    guess = prop(1:nNeurons(nLayers),nLayers);
    is_correct = round(guess) == tyi;
    is_correct = prod(is_correct);
    
    teams = find(txi == 1,2) + [0;-30]; 
    disp([NAMES{teams(1)},' vs ',NAMES{teams(2)}]);
    disp(['Margin: ',num2str(tsy(trial))]);
    if(is_correct)   
        n_right = n_right+1;
    end
    disp([guess,tyi]);
end

disp(['Guessed Correctly: ', num2str(100*n_right/(nTExamples)), ' %']);

diary off;
rates = rates(:,1:ii-1);
semilogx(rates');
tott = cputime() - startt;
 
rmpath('functions');