%SSA Pipeline
%read in unique household (column 5)

data_in = temp_storage;

M = round(((size(data_in,1))/2)-1);

%size of time series
N = size(data_in,1);

%define time series
time = data_in(:,10); %date

%set specified time_series
est_mil = data_in(:,12);
ro_event = data_in(:,14);
ro_total = data_in(:,15);
p_total_2_or_more = data_in(:,204);
p_total_asian = data_in(:,205);
p_total_black = data_in(:,206);
p_total_hawaii = data_in(:,207);

figure(1);
clf;
set(1,'name','Time series X');
subplot(1,2,1);
plot(est_mil, 'r-');
title('est mil');
subplot(1,2,2);
plot(ro_event, 'r-');
title('ro event');

figure(2);
clf;
set(1,'name','Time series X');
subplot(1,2,1);
plot(ro_total, 'r-');
title('ro total');
subplot(1,2,2);
plot(p_total_2_or_more, 'r-');
title('p total 2 or more');

figure(3);
clf;
set(1,'name','Time series X');
subplot(1,2,1);
plot(p_total_asian, 'r-');
title('p total asian');
subplot(1,2,2);
plot(p_total_black, 'r-');
title('p total black');

figure(4);
clf;
set(1,'name','Time series X');
subplot(1,2,1);
plot(p_total_hawaii, 'r-');
title('p total hawaii');

%calculate covariance matrix (trajectory approach)
%--------------------------------------------------------------------------
Y1 = zeros(N-M+1,M);
Y2 = zeros(N-M+1,M);
Y3 = zeros(N-M+1,M);
Y4 = zeros(N-M+1,M);
Y5 = zeros(N-M+1,M);
Y6 = zeros(N-M+1,M);
Y7 = zeros(N-M+1,M);

for m=1:M;
    Y1(:,m) = est_mil((1:N-M+1)+m-1);
    Y2(:,m) = ro_event((1:N-M+1)+m-1);
    Y3(:,m) = ro_total((1:N-M+1)+m-1);
    Y4(:,m) = p_total_2_or_more((1:N-M+1)+m-1);
    Y5(:,m) = p_total_asian((1:N-M+1)+m-1);
    Y6(:,m) = p_total_black((1:N-M+1)+m-1);    
    Y7(:,m) = p_total_hawaii((1:N-M+1)+m-1);    
end

Y = [Y1 Y2 Y3 Y4 Y5 Y6 Y7];

Cemb=Y'*Y / (N-M+1);

figure(5);
imagesc(Cemb);
axis square
set(gca,'clim',[-1 1]);
colorbar


%-------------------------------------------------------------------------

%-------------------------------------------------------------------------

%calculate respective eigenvalues

[RHO,LAMBDA] = eig(Cemb);
LAMBDA = diag(LAMBDA);      % extract the diagonal
[LAMBDA,ind]=sort(LAMBDA,'descend'); % sort eigenvalues
eigenvalues = [LAMBDA,ind];

RHO = RHO(:,ind);             % and eigenvectors

figure(6);
clf;
set(gcf,'name','Eigenvectors RHO and eigenvalues LAMBDA')
subplot(3,1,1);
plot(LAMBDA,'o-');
subplot(3,1,2);
plot(RHO(:,1:2), '-');
legend('1', '2');
subplot(3,1,3);
plot(RHO(:,3:4), '-');
legend('3', '4');

%-------------------------------------------------------------------------

% Calculate principal components PC
% The principal components are given as the scalar product
% between Y, the time-delayed embedding of X1 and X2, and the
% eigenvectors RHO.

PC = Y*RHO;

figure(7);
set(gcf,'name','Principal components PCs')
clf;
for m=1:4
  subplot(4,1,m);
  plot(PC(:,m),'k-');
  ylabel(sprintf('PC %d',m));
  ylim([-10 10]);
end;

%-------------------------------------------------------------------------
% Calculate reconstructed components RC

RC1=zeros(N,2*M);
RC2=zeros(N,2*M);
RC3=zeros(N,2*M);
RC4=zeros(N,2*M);
RC5=zeros(N,2*M);
RC6=zeros(N,2*M);
RC7=zeros(N,2*M);

for m=1:2*M
  buf1=PC(:,m)*RHO(1:M,m)'; % invert projection - first channel
  buf1=buf1(end:-1:1,:);
  
  buf2=PC(:,m)*RHO(M+1:end,m)'; % invert projection - second channel
  buf2=buf2(end:-1:1,:);
  
  buf3=PC(:,m)*RHO(M+2:end,m)'; % invert projection - third channel
  buf3=buf2(end:-1:1,:);
  
  buf4=PC(:,m)*RHO(M+3:end,m)'; % invert projection - third channel
  buf4=buf2(end:-1:1,:);  
  
  buf5=PC(:,m)*RHO(M+4:end,m)'; % invert projection - third channel
  buf5=buf2(end:-1:1,:);  
  
  buf6=PC(:,m)*RHO(M+5:end,m)'; % invert projection - third channel
  buf6=buf2(end:-1:1,:);  
  
  buf7=PC(:,m)*RHO(M+6:end,m)'; % invert projection - third channel
  buf7=buf2(end:-1:1,:);  
  
  for n=1:N % anti-diagonal averaging
    RC1(n,m)=mean( diag(buf1,-(N-M+1)+n) );  
    RC2(n,m)=mean( diag(buf2,-(N-M+1)+n) ); 
    RC3(n,m)=mean( diag(buf3,-(N-M+1)+n) ); 
    RC4(n,m)=mean( diag(buf4,-(N-M+1)+n) );  
    RC5(n,m)=mean( diag(buf5,-(N-M+1)+n) ); 
    RC6(n,m)=mean( diag(buf6,-(N-M+1)+n) ); 
    RC7(n,m)=mean( diag(buf7,-(N-M+1)+n) ); 
    
  end
end;

