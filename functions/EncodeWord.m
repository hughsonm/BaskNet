function [code] = EncodeWord(word,max_len)

code = zeros(26*max_len,1);

for idx = 1:length(word)
    letter = word(idx);
    offset = 26*(idx-1);
    code(offset + letter - 'a' + 1) = 1;
end


end

