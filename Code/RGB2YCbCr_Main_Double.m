%% 两幅源图像都是彩色图像
clc;
clear all;

A_dir = '..\Data\MFF\Lytro\A'; % 包含所有源图像A的文件夹路径
B_dir = '..\Data\MFF\Lytro\B'; % 包含所有源图像B的文件夹路径
save_dir_A = '..\Data\MFF\Lytro\A_Y\'; % 保存源图像A的Y通道的文件夹路径
save_dir_B = '..\Data\MFF\Lytro\B_Y\'; % 保存源图像B的Y通道的文件夹路径
fileFolder=fullfile(A_dir); 
dirOutput=dir(fullfile(fileFolder,'*.png')); % 图像后缀
fileNames = {dirOutput.name};
[m, num] = size(fileNames);
 if exist(save_dir_A,'dir')==0
	mkdir(save_dir_A);
 end
 if exist(save_dir_B,'dir')==0
	mkdir(save_dir_B);
 end
for i = 1:num
	name_A = fullfile(A_dir, fileNames{i});
    name_B = fullfile(B_dir, fileNames{i});
    save_name_A = strcat(save_dir_A, fileNames{i});
    save_name_B = strcat(save_dir_B, fileNames{i});
    image_A = double(imread(name_A));
    image_B = double(imread(name_B));
    [Y_A,Cb_A,Cr_A]=RGB2YCbCr(image_A); 
    [Y_B,Cb_B,Cr_B]=RGB2YCbCr(image_B); 
    imwrite(uint8(Y_A), save_name_A);
    imwrite(uint8(Y_B), save_name_B);    
    disp(save_name_A)
end