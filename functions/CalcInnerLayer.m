function [aa_out] = CalcInnerLayer(theta,aa_in)
aa_out = Sgmd(theta * aa_in);
aa_out(end) = 1;
end

