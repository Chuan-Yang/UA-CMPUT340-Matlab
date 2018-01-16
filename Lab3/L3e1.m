clear all;

load EllipsePoints


[V1,D1,t1] = PCA(Y1);
figure(1), plot(Y1(1,:),Y1(2,:),'.'), axis equal
hold on
plot([t1(1) 2*sqrt(D1(1,1))*V1(1,1)+t1(1)], [t1(2) 2*sqrt(D1(1,1))*V1(2,1)+t1(2)],'g')
plot([t1(1) 2*sqrt(D1(2,2))*V1(1,2)+t1(1)], [t1(2) 2*sqrt(D1(2,2))*V1(2,2)+t1(2)],'r')
axis equal
hold off

[V2,D2,t2] = PCA(Y2);
figure(2), plot(Y2(1,:),Y2(2,:),'.'), axis equal
hold on
plot([t2(1) 2*sqrt(D2(1,1))*V2(1,1)+t2(1)], [t2(2) 2*sqrt(D2(1,1))*V2(2,1)+t2(2)],'g')
plot([t2(1) 2*sqrt(D2(2,2))*V2(1,2)+t2(1)], [t2(2) 2*sqrt(D2(2,2))*V2(2,2)+t2(2)],'r')
axis equal
hold off

[V3,D3,t3] = PCA(Y3);
figure(3), plot(Y3(1,:),Y3(2,:),'.'), axis equal
hold on
plot([t3(1) 2*sqrt(D3(1,1))*V3(1,1)+t3(1)], [t3(2) 2*sqrt(D3(1,1))*V3(2,1)+t3(2)],'g')
plot([t3(1) 2*sqrt(D3(2,2))*V3(1,2)+t3(1)], [t3(2) 2*sqrt(D3(2,2))*V3(2,2)+t3(2)],'r')
axis equal
hold off




function [V,D,t] = PCA(Y)
    t = mean(Y,2);
    Y_approx = Y - t*ones(1,size(Y,2));
    C = (Y_approx* (Y_approx'))/size(Y,2);
    [V, D] = eig(C);
end