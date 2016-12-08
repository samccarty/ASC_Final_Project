function [ error ] = imcomp( image, R, C, model )
% Given a model image, the regions and counts from prepMaski, and an image to compare,
% this function returns an error vector containing the error in each
% region.

[~,~,num] = size(R);
error = zeros(1,num);

for region = 1:num
    [~,points] = size(R(:,:,region));
    for count = 1:points
        
        prow = R(1,count,region); %Read in x and y coordinates of each pixel in the region.
        pcol = R(2,count,region); 
        if(prow == 0 && pcol == 0) %Check to ensure coordinates are real.
            
        else
            error(region) = error(region) + norm(double(image(prow,pcol))-double(model(prow,pcol))); %Add error to existing error.
        end
    end
      error(region) = error(region)/C(region); %Normalize error by size of region.


end

