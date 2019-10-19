%%
% *This is an example of how to create a bivariate histogram in MATLAB&#174;* .
% 
% You can open this example in the <https://www.mathworks.com/products/matlab/live-editor.html 
% Live Editor> with MATLAB version 2016a or higher.
%
% Read about the <http://www.mathworks.com/help/matlab/ref/histogram2.html |histogram2|> function in the MATLAB documentation. This function is available in R2015b or newer.
% For more examples, go to <http://www.mathworks.com/discovery/gallery.html MATLAB Plot Gallery>
%
% Copyright 2017-2018 The MathWorks, Inc.

% Check version
if verLessThan('matlab','8.6')
    error('histogram2 is available in R2015b or newer.')
end

% Load ride data from Boston's bike sharing program
load rideData rideData

% Create bivariate histogram plot using the histogram2 function
histogram2(rideData.Duration, rideData.birth_date, 'BinWidth', [2 2])
xlabel('Length of Ride')
ylabel('Birth Year')
zlabel('Number of Rides')
title('Ride counts based on ride length and the age of the rider')

% Adjust view
view(17,30)
