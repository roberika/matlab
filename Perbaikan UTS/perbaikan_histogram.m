original_image = imread("original_image_1.jpg");
red_channel = original_image(:,:,1);
green_channel = original_image(:,:,2);
blue_channel = original_image(:,:,3);
red_image = cat(3, red_channel*1, green_channel*0, blue_channel*0);
green_image = cat(3, red_channel*0, green_channel*1, blue_channel*0);
blue_image = cat(3, red_channel*0, green_channel*0, blue_channel*1);
gray_image = rgb2gray(original_image);

% max(max(original_image))

figure("Name", "Histogram - Robert Antonius", "WindowState", "maximized");
figure_n = 3; figure_m = 4;

subplot(figure_n,figure_m, 1), imshow(original_image), title("RGB Image");
subplot(figure_n,figure_m, 5), imshow(gray_image), title("Grayscale Image");

subplot(figure_n,figure_m, 3), imshow(red_image), title("Red Channel Image");
subplot(figure_n,figure_m, 7), imshow(green_image), title("Green Channel Image");
subplot(figure_n,figure_m,11), imshow(blue_image), title("Blue Channel Image");

subplot(figure_n,figure_m,2), imhist(original_image), title("RGB Histogram");
subplot(figure_n,figure_m,6), imhist(gray_image), title("Grayscale Histogram");

subplot(figure_n,figure_m, 4), imhist(red_image), title("Red Channel Histogram");
subplot(figure_n,figure_m, 8), imhist(green_image), title("Green Channel Histogram");
subplot(figure_n,figure_m,12), imhist(blue_image), title("Blue Channel Histogram");

% subplot(figure_n,figure_m, 1), imshow(original_image), title("RGB Image");
% subplot(figure_n,figure_m, 7), imshow(gray_image), title("Grayscale Image");
% 
% subplot(figure_n,figure_m, 3), imshow(red_image), title("Red Only Image");
% subplot(figure_n,figure_m, 9), imshow(green_image), title("Green Only Image");
% subplot(figure_n,figure_m,15), imshow(blue_image), title("Blue Only Image");
% 
% subplot(figure_n,figure_m, 5), imshow(red_channel), title("Red Channel Image");
% subplot(figure_n,figure_m,11), imshow(green_channel), title("Green Channel Image");
% subplot(figure_n,figure_m,17), imshow(blue_channel), title("Blue Channel Image");
% 
% subplot(figure_n,figure_m,2), imhist(original_image), title("RGB Histogram");
% subplot(figure_n,figure_m,8), imhist(gray_image), title("Grayscale Histogram");
% 
% subplot(figure_n,figure_m, 4), imhist(red_image), title("Red Only Histogram");
% subplot(figure_n,figure_m,10), imhist(green_image), title("Green Only Histogram");
% subplot(figure_n,figure_m,16), imhist(blue_image), title("Blue Only Histogram");
% 
% subplot(figure_n,figure_m, 6), imhist(red_channel), title("Red Channel Histogram");
% subplot(figure_n,figure_m,12), imhist(green_channel), title("Green Channel Histogram");
% subplot(figure_n,figure_m,18), imhist(blue_channel), title("Blue Channel Histogram");
