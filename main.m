clc
clear all
%load('./Eigen.mat');%Eigen is the output of eigen-decomposition
[V,~,~,dV] = qc_parallel (ri,q,r);%solving schrodinger equation
quantum=parc_quantum(V,dV,parc_number);%parcellation with quantum clustering
[quantum_hierarchical,quantum_kmeans]=parc_quantum_hierarchical_kmeans(V,dV,parc_number);%parcellation with quantum-hybrid clustering
