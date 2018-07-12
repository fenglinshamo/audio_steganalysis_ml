%% Get difference percentage (used to select a better preprocessing method)
% Bitrate = 128kbps, RER = 100%

cover = load('E:\Myself\2.database\mtap\txt\cover\128\wav10s_00003.txt');
% stego = load('E:\Myself\2.database\mtap\mp3\stego\EECS\EECS_W_2_B_128_ER_10\wav10s_00003_stego_128.txt');
stego = load('E:\Myself\2.database\mtap\mp3\stego\HCM\HCM_B_128_ER_08\wav10s_00003.txt');

%% cut
QMDCT_num = 450;
cover = cover(:, 1:QMDCT_num);
stego = stego(:, 1:QMDCT_num);

%% prepcrocessing
% cover
cover_abs = pre_process_matrix(cover, 'abs');

cover_dif_c_1 = pre_process_matrix(cover, 'dif1_h');
cover_dif_r_1 = pre_process_matrix(cover, 'dif1_v');
cover_dif_c_2 = pre_process_matrix(cover, 'dif2_h');
cover_dif_r_2 = pre_process_matrix(cover, 'dif2_v');

cover_abs_dif_c_1 = pre_process_matrix(cover, 'abs_dif1_h');
cover_abs_dif_r_1 = pre_process_matrix(cover, 'abs_dif1_v');
cover_abs_dif_c_2 = pre_process_matrix(cover, 'abs_dif2_h');
cover_abs_dif_r_2 = pre_process_matrix(cover, 'abs_dif2_v');

% stego
stego_abs = pre_process_matrix(stego, 'abs');

stego_dif_c_1 = pre_process_matrix(stego, 'dif1_h');
stego_dif_r_1 = pre_process_matrix(stego, 'dif1_v');
stego_dif_c_2 = pre_process_matrix(stego, 'dif2_h');
stego_dif_r_2 = pre_process_matrix(stego, 'dif2_v');

stego_abs_dif_c_1 = pre_process_matrix(stego, 'abs_dif1_h');
stego_abs_dif_r_1 = pre_process_matrix(stego, 'abs_dif1_v');
stego_abs_dif_c_2 = pre_process_matrix(stego, 'abs_dif2_h');
stego_abs_dif_r_2 = pre_process_matrix(stego, 'abs_dif2_v');

% substraction
diff = cover(:) - stego(:);percentage = length(find(diff ~= 0)) / length(find(cover ~= 0));
diff_abs = cover_abs(:) - stego_abs(:);percentage_abs = length(find(diff_abs ~= 0)) / length(find(cover ~= 0));

diff_dif_c_1 = cover_dif_c_1(:) - stego_dif_c_1(:);percentage_dif_c_1 = length(find(diff_dif_c_1 ~= 0)) / length(find(cover ~= 0));
diff_dif_r_1 = cover_dif_r_1(:) - stego_dif_r_1(:);percentage_dif_r_1 = length(find(diff_dif_r_1 ~= 0)) / length(find(cover ~= 0));
diff_dif_c_2 = cover_dif_c_2(:) - stego_dif_c_2(:);percentage_dif_c_2 = length(find(diff_dif_c_2 ~= 0)) / length(find(cover ~= 0));
diff_dif_r_2 = cover_dif_r_2(:) - stego_dif_r_2(:);percentage_dif_r_2 = length(find(diff_dif_r_2 ~= 0)) / length(find(cover ~= 0));

diff_abs_dif_c_1 = cover_abs_dif_c_1(:) - stego_abs_dif_c_1(:);percentage_abs_dif_c_1 = length(find(diff_abs_dif_c_1 ~= 0)) / length(find(cover ~= 0));
diff_abs_dif_r_1 = cover_abs_dif_r_1(:) - stego_abs_dif_r_1(:);percentage_abs_dif_r_1 = length(find(diff_abs_dif_r_1 ~= 0)) / length(find(cover ~= 0));
diff_abs_dif_c_2 = cover_abs_dif_c_2(:) - stego_abs_dif_c_2(:);percentage_abs_dif_c_2 = length(find(diff_abs_dif_c_2 ~= 0)) / length(find(cover ~= 0));
diff_abs_dif_r_2 = cover_abs_dif_r_2(:) - stego_abs_dif_r_2(:);percentage_abs_dif_r_2 = length(find(diff_abs_dif_r_2 ~= 0)) / length(find(cover ~= 0));

fprintf('==================================\n');
fprintf('original: %.2f%%\n', percentage*100);
fprintf('absolute: %.2f%%\n', percentage_abs*100);

fprintf('first  order col difference: %.2f%%\n', percentage_dif_c_1*100);
fprintf('first  order row difference: %.2f%%\n', percentage_dif_r_1*100);
fprintf('second order col difference: %.2f%%\n', percentage_dif_c_2*100);
fprintf('second order row difference: %.2f%%\n', percentage_dif_r_2*100);

fprintf('first  order abs col difference: %.2f%%\n', percentage_abs_dif_c_1*100);
fprintf('first  order abs row difference: %.2f%%\n', percentage_abs_dif_r_1*100);
fprintf('second order abs col difference: %.2f%%\n', percentage_abs_dif_c_2*100);
fprintf('second order abs row difference: %.2f%%\n', percentage_abs_dif_r_2*100);