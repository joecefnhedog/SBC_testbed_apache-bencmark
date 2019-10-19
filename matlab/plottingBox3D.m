function plottingBox3D
xx=randn(365,9,168)+repmat((permute(rr'+cc'/80,[3 1 2])),[365,1,1]);
>> boxPlot3D(xx)
end