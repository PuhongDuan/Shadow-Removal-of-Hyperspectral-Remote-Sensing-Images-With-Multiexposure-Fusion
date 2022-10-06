function shadow = get_shadow(data)
img = data(:,:,[59 40 23]);

hsi = rgb2hsi(img);
% figure;imshow(hsi);
re_img = (hsi(:,:,1) + 1) ./ (hsi(:,:,3) + 1);
re_img=mat2gray(re_img);
% figure;imshow(re_img,[]);

level = graythresh(re_img) + 0.09; % 黑色多了：要变大
re_img(re_img>=level) = 1;
re_img(re_img<level) = 0;
re_img = 1 - re_img; % 阴影图像

%% 清理孤立的像素点
re_img = 1 - re_img;
re_img = bwmorph(re_img,'spur',1);%去毛刺
re_img = bwmorph(re_img,'hbreak',1);%断连通

re_img = bwareaopen(re_img,4000); % 去除小面积区域
re_img = 1- re_img;

re_img = bwareaopen(re_img,40000); % 填充
re_img = double(re_img);
shadow = re_img;