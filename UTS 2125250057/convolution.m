close all;
clear all;

original_image = imread("original_image_2.jpg");

low_pass_kernel_1 = [1/16 1/8 1/16; 1/8 1/4 1/8; 1/16 1/8 1/16]
low_pass_kernel_2 = ones(3)/10;
low_pass_kernel_2(2,2) = 1/5
low_pass_kernel_3 = ones(3)/9

high_pass_kernel_1 = ones(3)*-1;
high_pass_kernel_1(2,2) = 8
high_pass_kernel_2 = [0 -1 0; -1 5 -1; 0 -1 0]
high_pass_kernel_3 = [1 -2 1; -2 5 -2; 1 -2 1]

low_pass_image_1 = convolutionize(original_image, low_pass_kernel_1);
low_pass_image_2 = convolutionize(original_image, low_pass_kernel_2);
low_pass_image_3 = convolutionize(original_image, low_pass_kernel_3);
high_pass_image_1 = convolutionize(original_image, high_pass_kernel_1);
high_pass_image_2 = convolutionize(original_image, high_pass_kernel_2);
high_pass_image_3 = convolutionize(original_image, high_pass_kernel_3);

figure("Name", "Convolution - Robert Antonius", "WindowState", "normal");
figure_n = 4; figure_m = 4;
subplot(figure_n, figure_m, 1), imshow(original_image), title("Original Image");
subplot(figure_n, figure_m, 2), imhist(original_image), title("Original Histogram");
subplot(figure_n, figure_m, 5), imshow(low_pass_image_1), title("Low Pass Filter Image 1");
subplot(figure_n, figure_m, 6), imhist(low_pass_image_1), title("Low Pass Filter Histogram 1");
subplot(figure_n, figure_m, 7), imshow(high_pass_image_1), title("High Pass Filter Image 1");
subplot(figure_n, figure_m, 8), imhist(high_pass_image_1), title("High Pass Filter Histogram 1");
subplot(figure_n, figure_m, 9), imshow(low_pass_image_2), title("Low Pass Filter Image 2");
subplot(figure_n, figure_m, 10), imhist(low_pass_image_2), title("Low Pass Filter Histogram 2");
subplot(figure_n, figure_m, 11), imshow(high_pass_image_2), title("High Pass Filter Image 2");
subplot(figure_n, figure_m, 12), imhist(high_pass_image_2), title("High Pass Filter Histogram 2");
subplot(figure_n, figure_m, 13), imshow(low_pass_image_3), title("Low Pass Filter Image 3");
subplot(figure_n, figure_m, 14), imhist(low_pass_image_3), title("Low Pass Filter Histogram 3");
subplot(figure_n, figure_m, 15), imshow(high_pass_image_3), title("High Pass Filter Image 3");
subplot(figure_n, figure_m, 16), imhist(high_pass_image_3), title("High Pass Filter Histogram 3");

function result = convolutionize(image, kernel)
    figure
    result = imfilter(image, kernel, "symmetric", "same", "conv");
    subplot(4,2,1);
    imshow(result);
    subplot(4,2,2);
    imhist(result);
    result = imadjust(result, [], [0.3 0.3 0.3; 0.7 0.7 0.7]);
    subplot(4,2,3);
    imshow(result);
    subplot(4,2,4);
    imhist(result);
    result = imsubtract(image, result);
    subplot(4,2,5);
    imshow(result);
    subplot(4,2,6);
    imhist(result);
    result = imadjust(result, [], []);
    result = immultiply(result, 255);
    subplot(4,2,7);
    imshow(result);
    subplot(4,2,8);
    imhist(result);
end