% Read in model, mask, and result images
model = rgb2gray(imread('Phantom.jpg'));
mask = rgb2gray(imread('Phantom Mask.jpg'));
image1 = rgb2gray(imread('Result1.jpg'));
image2 = rgb2gray(imread('Result2.jpg'));
image3 = rgb2gray(imread('Result3.jpg'));
image4 = rgb2gray(imread('Result4.jpg'));
image5 = rgb2gray(imread('Result5.jpg'));
image6 = rgb2gray(imread('image6.jpg'));
Ring = rgb2gray(imread('RingResult.jpg'));

% Registration test images
rotated = rgb2gray(imread('rotated.jpg'));
moved = rgb2gray(imread('moved.jpg'));
scaled = rgb2gray(imread('scaled.jpg'));
all = rgb2gray(imread('all.jpg'));

[row,col] = size(model);


%Plot model and mask images
figure;
subplot(1,2,1), imshow(model);
subplot(1,2,2), imshow(mask);

% Perform image registration if needed.
[op,metric] = imregconfig('Multimodal');
registered = imregister(all,model,'similarity',op, metric);
figure;
imshowpair(model,registered);

% Plot a smattering of result images.
figure;
subplot(1,5,1), imshow(image1);
subplot(1,5,2), imshow(image2);
subplot(1,5,3), imshow(image3);
subplot(1,5,4), imshow(image4);
subplot(1,5,5), imshow(image5);

% Perform Mask Prep
[R,C] = prepMaski(mask,10);

%Calculate error for each image loaded.
err1 = imcomp(image1,R,C,model);
err2 = imcomp(image2,R,C,model);
err3 = imcomp(image3,R,C,model);
err4 = imcomp(image4,R,C,model);
err5 = imcomp(image5,R,C,model);
err6 = imcomp(image6,R,C,model);
errreg = imcomp(registered,R,C,model);
errring = imcomp(Ring,R,C,model);


%Plot Results 
[~,num] = size(err1);
plotx = 1:1:num;

figure;
plot(err1,'rx');
hold on;
plot(err2,'bx');
plot(err3,'gx');
plot(err4,'kx');
plot(err5,'mx');

figure;
subplot(1,2,1), imshow(image1);
subplot(1,2,2), scatter(ploty,err1,140,'ro','filled');

figure;
subplot(1,2,1), imshow(Ring);
subplot(1,2,2), scatter(ploty,errring,140,'bo','filled');

figure;
subplot(1,2,1), imshow(image5);
subplot(1,2,2), scatter(ploty,err5,140,'ko','filled');

figure;
subplot(1,2,1), imshow(image6);
subplot(1,2,2), scatter(ploty,err6,140,'go','filled');

figure;
subplot(1,3,1), imshow(all);
subplot(1,3,2), imshowpair(model,registered);
subplot(1,3,3), scatter(plotx,errreg,140,'yo','filled');

figure;
subplot(1,2,1), imshow(image2);
subplot(1,2,2), plot(err2,'bx');

figure;
subplot(1,2,1), imshow(image3);
subplot(1,2,2), plot(err3,'gx');

figure;
subplot(1,2,1), imshow(image4);
subplot(1,2,2), plot(err4,'cx');

figure;
subplot(1,2,1), imshow(image5);
subplot(1,2,2), plot(err5,'mx');

figure;
subplot(1,2,1), imshow(registered);
subplot(1,2,2), plot(err5,'bx');

