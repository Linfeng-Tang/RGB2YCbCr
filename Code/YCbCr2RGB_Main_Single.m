clc;
clear all;
A_dir = fullfile('..\Data\VIF\MSRS\vi'); % 包含所有源图像A的文件夹路径
Fused_dir = fullfile('..\Comparison\VIF\SwinFusion_MSRS_Y'); % 融合图像的Y通道的文件夹路径
save_dir = fullfile('..\Comparison\VIF\SwinFusion_MSRS'); % 彩色融合图像的文件夹路径
fileFolder=fullfile(A_dir);
dirOutput=dir(fullfile(fileFolder,'*.png'));
fileNames = {dirOutput.name};
[m, num] = size(fileNames);
if exist(save_dir,'dir')==0
	mkdir(save_dir);
end
for i = 1:num
    name_A = fullfile(A_dir, fileNames{i});
    name_fused = fullfile(Fused_dir, fileNames{i});
    save_name = fullfile(save_dir, fileNames{i});    
    image_A = double(imread(name_A));
    I_result = double(imread(name_fused));
    [Y1,Cb1,Cr1]=RGB2YCbCr(image_A);
    I_final_YCbCr=cat(3,I_result,Cb1,Cr1);
    I_final_RGB=YCbCr2RGB(I_final_YCbCr);
    imwrite(uint8(I_final_RGB), save_name);
    disp(save_name);
end