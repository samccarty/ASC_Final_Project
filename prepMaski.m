function [ regionsnew, countnew ] = prepMaski( mask, num )
% This function divides the given mask into its regions and returns the x
% and y coordinates of each point in each region. 
% The image "mask" should be a white background with shapes marking the
% desired regions to be compared in varying shades of gray. 
% num is the number of regions in the mask. 


rstandard = zeros(1,num); %A token value from each region will be stored here.
for i = 1:num
    rstandard(i) = 255;
end
regions = zeros(2,1,num); %The coordinates of the points in each region.
rcount = ones(1,num); %The number of points currently stored in each region.
rscount = 1; %The number of "standards" that have been set so far.
[row,col] = size(mask);

for i = 2:row
    for j = 2:col
        comp = int16(mask(i,j)); %The current pixel value converted to int16 for easy comparison.
        compcheck = int16(mask(i-1,j-1)); %The last pixel value.
        check = false;
        
        if (abs(comp - 255) > 10) %Ignores background.
            if (abs(comp - compcheck) < 3) %This prevents values of single "in-between" points from being stored.
                for r = 1:rscount-1
                    if(abs(comp-rstandard(r)) < 15) %Compares to current standards and stores in the appropriate region.
                        regions(1,rcount(r),r) = i;
                        regions(2,rcount(r),r) = j;
                        rcount(r) = rcount(r) + 1;
                        check = true;
                    end
                end
            
                if check == false %If not stored, add to standards list.
                    rstandard(rscount) = comp;
                    rscount = rscount + 1;
                end
            end
        end

    end
    
end
    

%regionsnew holds only the regions greater than 20 points and countnew
%holds its associated counts. 
bad = 0;
for count = 1:num

    if(rcount(count) < 20)
        regions(:,:,count) = 0;
        bad = bad + 1;
    else
        regionsnew(:,:,(count-bad)) = regions(:,:,count);
        countnew((count-bad)) = rcount(count);
    end
    
end
        
end


