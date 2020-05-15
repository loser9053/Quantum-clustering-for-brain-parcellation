function  [coordinate,index]=node_txt(vector,num)
%find the zero values in the vector and output the txt files for nodes.
    load parc_graymatter.mat;
    [n,~]=size(vector);
    minvector=zeros(n,1);
    %label=find(vector==0);
    %minvector(label)=1;
    %num=size(label,1);
    v=abs(vector);
    [~,kth]=sort(mean(v,2));
    minvector(kth(1:num))=1;
    tmp=zeros(siz);
    tmp(msk_gray)=minvector;
    index_tmp=tmp;
    index=find(index_tmp==1);
    [i,j,k]=ind2sub(siz,index);
    coordinate=[i,j,k];
    %mni=cor2mni(coordinate);
    %MNI=mni;
    %MNI(:,4)=4*ones(num,1);%save as brainnet viewer's node file structure
    %MNI(:,5)=3.96*ones(num,1);
    %save seed as txt file
    %fid=fopen('quantum_potential/seed_node.txt','w');
    %fprintf(fid,'%5d %5d %5d %5d %5f\r\n',MNI');
end