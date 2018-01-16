load mri_c1.mat;
ComputeTomography(Amri,Bmri,imsize);

function ComputeTomography(Amri,Bmri,imsize)
    [~,n]=size(Bmri);
    for i = 1:n
        graph = reshape(Amri\(Bmri(:,i)),imsize);
        graph = graph';
        subplot(1,n,i);
        imshow(graph);
    end
end