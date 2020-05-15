function parc_out=parc_quantum(V,dV,parc_number)
%purpose:parcellation of brain based on potential energy and potential
%difference
load parc_graymatter.mat;
tmp=zeros(siz);
tmp(msk_gray)=V;
V_plot=tmp;%V_plot is needed in the following parcellation
parc=zeros(siz);
[label_node,~]=node_txt(dV,parc_number);%mni of each cluster center
num_label=size(label_node,1);
label_node=sortrows(label_node,[1 2 3]);
x_node=label_node(:,1);
y_node=label_node(:,2);
z_node=label_node(:,3);
for ii=1:num_label
    parc(x_node(ii),y_node(ii),z_node(ii))=ii;%give each cluster center an index
end
%mni of each data point(except for the cluster center)
minvector=ones(num_gray,1);
tmp=zeros(siz);
tmp(msk_gray)=minvector;
index_tmp=tmp;
index=find(index_tmp==1);
[i,j,k]=ind2sub(siz,index);
label_data=[i,j,k];
num_data=size(label_data,1);
for jj=1:num_data
    distance_V=((label_data(jj,1)-label_node(:,1)).^2+(label_data(jj,2)-label_node(:,2)).^2 ...
    +(label_data(jj,3)-label_node(:,3)).^2).^0.5;
    min_dis=min(distance_V);
    min_index=find(distance_V==min_dis);
    if size(min_index,1)>1
        for kk=1:size(min_index,1)
            V_diff=zeros(size(min_index,1),1);
            V_diff(kk)=V_plot(label_data(jj,1),label_data(jj,2),label_data(jj,3))-V_plot(x_node(min_index(kk)),y_node(min_index(kk)),z_node(min_index(kk)));
        end
        [~,min_tmp]=max(V_diff);
        mmin_index=min_index(min_tmp);
        parc(label_data(jj,1),label_data(jj,2),label_data(jj,3))=parc(x_node(mmin_index),y_node(mmin_index),z_node(mmin_index));
    else
        parc(label_data(jj,1),label_data(jj,2),label_data(jj,3))=parc(x_node(min_index),y_node(min_index),z_node(min_index));
    end
end
parc_out=parc(ind_gray);