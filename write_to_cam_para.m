Intrinsic=[];
Extrinsic=[];
P=Pmatrices;
for kkk=1:19
    [K1,R1,t1]=P2KRtC(P(kkk*3-2:kkk*3,:));

    K1
    R1
    T = diag(sign(diag(K1)));
    K1 = K1 *T;
    R1 = T * R1;% (T is its own inverse)
    t1=T*t1;
    det(R1)% force make the diag element positive

%     K1
%     R1
%     t1
%     det(R1)
    
    Intrinsic=[Intrinsic;K1];
    Extrinsic=[Extrinsic;R1 t1];
end
absintrincic=(Intrinsic);
Extrinsic=Extrinsic;
% mmm=[21,15,22,11,10,9,12,2,18,8,4,5,3,23,14,1,7,20,13,16];
% mmm=[01,02,03,04,05,07,08,09,10,11,12,13,14,15,16,18,20,21,22,23];
%      01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20

mmm=[1,14,5,2,3,19,18,11,4,16,10,13,15,17,12,8,7,6,9];
size(mmm)
for it=1:19
%     it
    fp=fopen(sprintf('C:/Users/Administrator/Desktop/20181121-jinlee/%02d/%02d.cam',it-1,it-1),'wt');
    fprintf(fp,'#camera track project file\n');
    fprintf(fp,'<Image Sequence>\n');
    fprintf(fp,'Sequence:.\\0001.jpg\n');
    fprintf(fp,'start:1\n');
    fprintf(fp,'step:1\n');
    fprintf(fp,'end:1\n');
    fprintf(fp,'</Image Sequence>\n');
    fprintf(fp,'\n');
    fprintf(fp,'<Motion Type>\n');
    fprintf(fp,'FREE_MOVE\n');
    fprintf(fp,'FOCAL_CONSTANT\n');
    fprintf(fp,'PRINCIPAL_KNOWN\n');
    fprintf(fp,'SKEW_KNOWN\n');
    fprintf(fp,'</Motion Type>\n');
    fprintf(fp,'\n');
    fprintf(fp,'<intrinsic parameter>\n');
    fprintf(fp,'%f %f %f\n',absintrincic(3*mmm(it)-2,1),absintrincic(3*mmm(it)-2,2),absintrincic(3*mmm(it)-2,3));
    fprintf(fp,'%f %f %f\n',absintrincic(3*mmm(it)-1,1),absintrincic(3*mmm(it)-1,2),absintrincic(3*mmm(it)-1,3));
    fprintf(fp,'%f %f %f\n',absintrincic(3*mmm(it),1),absintrincic(3*mmm(it),2),absintrincic(3*mmm(it),3));
    fprintf(fp,'</intrinsic parameter>\n');
    fprintf(fp,'\n');
    fprintf(fp,'<Camera Track>\n');
    fprintf(fp,'%f\n',absintrincic(1,1));
    fprintf(fp,'%f %f %f %f\n',Extrinsic(3*mmm(it)-2,1),Extrinsic(3*mmm(it)-2,2),Extrinsic(3*mmm(it)-2,3),Extrinsic(3*mmm(it)-2,4));
    fprintf(fp,'%f %f %f %f\n',Extrinsic(3*mmm(it)-1,1),Extrinsic(3*mmm(it)-1,2),Extrinsic(3*mmm(it)-1,3),Extrinsic(3*mmm(it)-1,4));
    fprintf(fp,'%f %f %f %f\n',Extrinsic(3*mmm(it),1),Extrinsic(3*mmm(it),2),Extrinsic(3*mmm(it),3),Extrinsic(3*mmm(it),4));
    fprintf(fp,'%f %f %f %f\n',0,0,0,1);
    fprintf(fp,'</Camera Track>');
    fclose(fp);
end