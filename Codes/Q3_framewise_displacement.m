clear
subjfolder_task = dir('F:\fMRI_QC\fmri-open-qc-task_bias_corrected\sub*');

for subji = 1:length(subjfolder_task)
    rp = load(['F:\fMRI_QC\fmri-open-qc-task_bias_corrected\' subjfolder_task(subji).name '\func\rp_' subjfolder_task(subji).name '_task-pamenc_bold.txt']);

    fd_trans = fd_calc(rp(:,1:3));
    fd_rotat = fd_calc(rp(:,4:6)*180/pi);
    
    fd_max_trans_task(subji,1) = max(fd_trans);
    fd_max_rotat_task(subji,1) = max(fd_rotat);
    
    fd_mean_trans_task(subji,1) = mean(fd_trans);
    fd_mean_rotat_task(subji,1) = mean(fd_rotat);
end

subjfolder_rest = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder_rest)
    rp = load(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder_rest(subji).name '\func\rp_' subjfolder_rest(subji).name '_ses-01_task-rest_run-01_bold.txt']);

    fd_trans = fd_calc(rp(:,1:3));
    fd_rotat = fd_calc(rp(:,4:6)*180/pi);
    
    fd_max_trans_rest(subji,1) = max(fd_trans);
    fd_max_rotat_rest(subji,1) = max(fd_rotat);
    
    fd_mean_trans_rest(subji,1) = mean(fd_trans);
    fd_mean_rotat_rest(subji,1) = mean(fd_rotat);
end

subjfolder = [subjfolder_task;subjfolder_rest];

fd_max_trans = [fd_max_trans_task;fd_max_trans_rest];
fd_max_rotat = [fd_max_rotat_task;fd_max_rotat_rest];

fd_mean_trans = [fd_mean_trans_task;fd_mean_trans_rest];
fd_mean_rotat = [fd_mean_rotat_task;fd_mean_rotat_rest];

figure('DefaultAxesFontSize',18)
scatterhist(fd_max_trans,fd_max_rotat,'NBins',[100 100],'Direction','out','Marker','.','MarkerSize',10)
xline(1.5,'r');yline(1.5,'r')
title('FD Max')
xlabel('Translation');ylabel('Rotation')
box off

exportgraphics(gcf,['C:\Users\synge\Documents\GitHub\Preprocessing_and_QC\QC_images\Q3_head_motion.jpg']);

% figure('DefaultAxesFontSize',18)
% scatterhist(fd_mean_trans,fd_mean_rotat,'NBins',[100 100],'Direction','out','Marker','.','MarkerSize',10)
% xline(0.15,'r');yline(0.15,'r')
% title('FD Mean')
% xlabel('Translation');ylabel('Rotation')
% box off



% site effects
% n_site = [30 20 20 16 23 20 20 20];
% site = [];
% for sitei = 1:length(n_site)
%     site = [site;ones(n_site(sitei),1)*sitei];
% end
% 
% figure('DefaultAxesFontSize',18)
% scatterhist(fd_max_trans,fd_max_rotat,'Group',site,'Kernel','on','NBins',[100 100],'Direction','out','Marker','.')
% xline(1.5,'r');yline(1.5,'r')
% title('FD Max')
% xlabel('Translation');ylabel('Rotation')
% box off


included = find(fd_max_trans<1.5&fd_max_rotat<1.5);
excluded = find(fd_max_trans>1.5|fd_max_rotat>1.5);

subjfolder(excluded).name


function fd = fd_calc(Y)
% calculate framewise displacement
    Y_diff = diff(Y);
    multp = Y_diff*Y_diff';
    fd = sqrt(diag(multp));
end