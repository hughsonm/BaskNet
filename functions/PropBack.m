function [new_TT] = PropBack(TT,AA,n_neurons,yi,rate)

n_layers = length(n_neurons);
new_TT = zeros(size(TT));

dies = zeros(size(AA));

err_out = 0.5*(AA(1,n_layers)-yi)^2;

% Fill in dies first

dies(1:n_neurons(n_layers),n_layers) = AA(1:n_neurons(n_layers),n_layers) - yi;

for layer = n_layers-1:-1:2
    for neur = 1:n_neurons(layer)+1
        die_sum = 0;
        for next_neur = 1:n_neurons(layer+1)+1
            conn_theta = TT(next_neur,neur,layer);
            next_a = AA(next_neur,layer+1);
            next_die = dies(next_neur,layer+1);
            die_a_a = next_a*(1-next_a)*conn_theta;
            die_cont = next_die*die_a_a;
            die_sum = die_sum + die_cont;
        end
        dies(neur,layer) = die_sum;
    end
end

% Fill in new_TT next

for layer = 1:n_layers-1
    for ii = 1:n_neurons(layer+1)
        for jj = 1:n_neurons(layer)+1
            next_a = AA(ii,layer+1);
            prev_a = AA(jj,layer);
            stp = dies(ii,layer+1) * next_a * (1-next_a) * prev_a;
            new_TT(ii,jj,layer) = TT(ii,jj,layer) - rate*stp;
            %new_TT(ii,jj,layer) = TT(ii,jj,layer) - err_out/stp;
        end
    end
    
end

end

