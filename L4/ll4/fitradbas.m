function y=fitradbas(X,Y,beta,x)
x=mod(x,2*pi);
dist=repmat(x,[1,size(X,2)])-X;
dist=abs(dist);
dist=min(2*pi-dist,dist);
dist=exp(-beta*sum(dist.^2,1));
dist=dist/sum(dist(:));
y=Y*dist';
