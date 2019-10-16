function [w_str] = GetWord(lang_str, max_len)
if(strcmp(lang_str,'latin'))
    f_len = 3290;
    file_str = 'latin.txt';
    yi = [1;0];
else
    f_len = 84095;
    yi = [0;1];
    file_str = 'engmix.txt';
end

fid = fopen(file_str);

w_idx = randi(f_len,1);
line = textscan(fid, '%s', 1, 'delimiter', '\n', 'headerlines', w_idx-1);
w_str = char(line{1});
while(length(w_str) > max_len)
    w_idx = randi(f_len,1);
    fclose(fid);
    fid = fopen(file_str);
    line = textscan(fid, '%s', 1, 'delimiter', '\n', 'headerlines', w_idx-1);
    w_str = char(line{1});
end

fclose(fid);

end

