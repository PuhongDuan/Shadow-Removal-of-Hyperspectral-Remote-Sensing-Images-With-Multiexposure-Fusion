function ratio = get_ratio(data, shadow)

[r,c,x] = size(data);
img = data;
re_img = shadow;
re_img = 1 - re_img;

for i = 1:x
    sum_1(:,:,i) = img(:,:,i) .* re_img;
    sum_2(1,i) = sum(sum(sum_1(:,:,i)));
    average_1(1,i) = sum_2(1,i)/sum(sum(re_img));
end

% ¸¯Ê´
B=[0 1 0;1 1 1;0 1 0];
re_img_1 = re_img;
for i = 1:100
    re_img_1=imdilate(re_img_1,B);
end
% figure;imshow(re_img_1);
re_img1 = re_img_1 - re_img;
% figure;imshow(re_img1);
% re_img1 = 1 - re_img;

for i = 1:x
    sum_1(:,:,i) = img(:,:,i) .* re_img1;
    sum_2(i) = sum(sum(sum_1(:,:,i)));
    average_2(i) = sum_2(i)/sum(sum(re_img1));
end

ratio = average_2./average_1;