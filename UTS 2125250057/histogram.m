original_image = imread("original_image_1.jpg");
red_image = original_image(:,:,1);
green_image = original_image(:,:,2);
blue_image = original_image(:,:,3);
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

