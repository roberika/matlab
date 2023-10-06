clear all;
close all;

scale = 180000;

loop1 = 30;
image1 = uint8([]);
for i = 1 : loop1
    image1 = cat(2, image1, ones([scale scale/loop1/2]));
end
for i = 1 : loop1
    image1 = cat(2, image1, zeros([scale scale/loop1/2]));
end

loop2 = 10;
image2 = uint8([]);
for i = 1 : loop2
    image2 = cat(2, image2, ones([scale scale/loop2/2]));
    image2 = cat(2, image2, zeros([scale scale/loop2/2]));
end

loop3 = 30;
image3 = uint8([]);
cons = 0;
for i = 1 : loop3
    if cons >= 100 || randi(100 - cons) >= 50
        image3 = cat(1, image3, ones([scale/loop3 scale]));
        cons = cons + 1;
    else
        image3 = cat(1, image3, zeros([scale/loop3 scale]));
    end
end
loop4 = 20;
temp = uint8([]);
cons = 0;
for i = 1 : loop4
    if cons >= 100 || randi(100 - cons) >= 30
        temp = cat(1, temp, ones([scale/loop4 scale]));
        cons = cons + 1;
    else
        temp = cat(1, temp, zeros([scale/loop4 scale]));
    end
end
image3 = bitxor(image3, temp');

degree = 45;
t4 = maketform('affine', [cosd(degree) -sind(degree) 0; sind(degree) cosd(degree) 0; 0 0 1]');
image4 = imtransform(image3, t4);
t5 = maketform('affine', [3.5 0 0; 0 3.5 0; 0 0 1]');
image5 = imtransform(image3, t5);
xform = [1 0 25; 0 1 15; 0 0 1];
t6 = maketform('affine', xform');
image6 = imtransform(image3, t6, ...
        'XData', [1 (size(image3, 2) + xform(3,1))], ...
        'YData', [1 (size(image3, 2) + xform(3,2))], ...
        'FillValues', 128);
t7 = maketform('affine', [1 3 0; 2 1 0; 0 0 1]');
image7 = imtransform(image3, t7);
% affinetform2d(image3);

figure;
subplot(1,2,1);
imshow(image1, []);
subplot(1,2,2);
imshow(image2, []);

figure;
subplot(2,3,1);
imshow(bitand(image1, image2),[]);
subplot(2,3,2);
imshow(bitor(image1, image2),[]);
subplot(2,3,3);
imshow(bitxor(image1, image2),[]);
subplot(2,3,4);
imshow(bitcmp(image1),[]);
subplot(2,3,5);
imshow(bitcmp(image2),[]);

figure;
subplot(2,3,1);
imshow(image3,[]);
subplot(2,3,2);
imshow(image4,[]);
subplot(2,3,3);
imshow(image5,[]);
subplot(2,3,5);
imshow(image6,[]);
subplot(2,3,6);
imshow(image7,[]);

