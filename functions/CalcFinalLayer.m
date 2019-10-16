function [aa_out] = CalcFinalLayer(theta,aa_in)
aa_out = Sgmd(theta * aa_in);
end

