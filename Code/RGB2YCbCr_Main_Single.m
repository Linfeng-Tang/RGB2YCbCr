%% 只有一幅源图像为彩色图像
clc;
clear all;
A_dir = '..\Data\VIF\MSRS\vi'; % 包含所有源图像A的文件夹路径
save_dir_A = '..\Data\VIF\MSRS\vi_Y\'; % 保存源图像A的Y通道的文件夹路径
 if exist(save_dir_A,'dir')==0
	mkdir(save_dir_A);
 end
 fileFolder=fullfile(A_dir); 
dirOutput=dir(fullfile(fileFolder,'*.png')); % 图像后缀
fileNames = {dirOutput.name};
[m, num] = size(fileNames);
for i = 1:num
	name_A = fullfile(A_dir, fileNames{i});
    save_name_A = strcat(save_dir_A, fileNames{i});
    image_A = double(imread(name_A));
    [Y_A,Cb_A,Cr_A]=RGB2YCbCr(image_A); 
    imwrite(uint8(Y_A), save_name_A);
    disp(save_name_A)
end