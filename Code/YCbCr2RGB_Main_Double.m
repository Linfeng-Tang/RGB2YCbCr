%% 两幅源图像都是彩色图像
clc;
clear all;
A_dir = fullfile('..\Data\MFF\Lytro\A'); % 包含所有源图像A的文件夹路径
B_dir = fullfile('..\Data\MFF\Lytro\B'); % 包含所有源图像B的文件夹路径
Fused_dir = fullfile('..\Comparison\MFF\SwinFusion_Lytro_Y'); % 融合图像的Y通道的文件夹路径
save_dir = fullfile('..\Comparison\MFF\SwinFusion_Lytro'); % 彩色融合图像的文件夹路径
fileFolder=fullfile(A_dir);
dirOutput=dir(fullfile(fileFolder,'*.png'));
fileNames = {dirOutput.name};
[m, num] = size(fileNames);
if exist(save_dir,'dir')==0
	mkdir(save_dir);
end
for i = 1:num
    name_A = fullfile(A_dir, fileNames{i});
    name_B = fullfile(B_dir, fileNames{i});
    name_fused = fullfile(Fused_dir, fileNames{i});
    save_name = fullfile(save_dir, fileNames{i});
    image_A = double(imread(name_A));
    image_B = double(imread(name_B));
    I_result = double(imread(name_fused));
    [Y1,Cb1,Cr1]=RGB2YCbCr(image_A);
    [Y2,Cb2,Cr2]=RGB2YCbCr(image_B);
    [H,W]=size(Cb1);
    Cb=ones([H,W]);
    Cr=ones([H,W]);
    for k=1:H
        for n=1:W
            if (abs(Cb1(k,n)-128)==0&&abs(Cb2(k,n)-128)==0)  
                Cb(k,n)=128;
            else
                middle_1= Cb1(k,n)*abs(Cb1(k,n)-128)+Cb2(k,n)*abs(Cb2(k,n)-128);
                middle_2=abs(Cb1(k,n)-128)+abs(Cb2(k,n)-128);
                Cb(k,n)=middle_1/middle_2;
            end
            if (abs(Cr1(k,n)-128)==0&&abs(Cr2(k,n)-128)==0)
                Cr(k,n)=128;  
            else
                middle_3=Cr1(k,n)*abs(Cr1(k,n)-128)+Cr2(k,n)*abs(Cr2(k,n)-128);
                middle_4=abs(Cr1(k,n)-128)+abs(Cr2(k,n)-128); 
                Cr(k,n)=middle_3/middle_4;
            end
        end
    end
    I_final_YCbCr=cat(3,I_result,Cb,Cr);
    I_final_RGB=YCbCr2RGB(I_final_YCbCr);
    imwrite(uint8(I_final_RGB), save_name);
    disp(save_name);
end