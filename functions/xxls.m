function result = xxls(img)
%     for i = 1:size(img,3)
%         result(:,:,i) = imadjust(img(:,:,i), stretchlim(img(:,:,i), [0.01 0.99]), []);
%     end
    for i=1: size(img,3)
        result(:,:,i)=imadjust(img(:,:,i),stretchlim(img(:,:,i)));
    end
end