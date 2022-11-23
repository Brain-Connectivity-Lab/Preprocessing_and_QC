% Quality control Q6
% Plot time series from fMRI images and head motion
% Show their correlations before and after preprocessing
% Xin Di, July 13, 2022

clear

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');
subjfolder = subjfolder([1:89 91:end]); % subji 90 CSF mask empty

figure('position',[10 50 1500 400]);
for subji = 1:length(subjfolder)
    fprintf('Processing subject %d ...',subji)
    
    
    % load the raw functional images and calculate the global mean and pairwise variance
    v_all = spm_vol(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\func\' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii']);
    
    clear a dt
    
    for imagei = 1:length(v_all)
        v = spm_vol(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'func', [subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,' num2str(imagei)]));
        y = spm_read_vols(v);
        
        a(:,imagei) = y(:);
    end
    
    gm = mean(mean(a)); % grand mean (4D)
    
    % calculate pairwise variance
    for imagei = 1:length(v_all)-1
        dt(imagei) = (mean((a(:,imagei) - a(:,imagei+1)).^2))/gm;
    end
    
    meany = mean(a)./gm; % scaled global mean
    
    
    % load rigid body motion parameters and calculate framewise displacement 
    rp = load(['F:\fMRI_QC\fmri-open-qc-rest\' subjfolder(subji).name '\func\rp_' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.txt']);

    fd_trans = fd_calc(rp(:,1:3));
    fd_rotat = fd_calc(rp(:,4:6)*180/pi);
    
    fd_max_trans(subji,1) = max(fd_trans);
    fd_max_rotat(subji,1) = max(fd_rotat);
    
    fd_mean_trans(subji,1) = mean(fd_trans);
    fd_mean_rotat(subji,1) = mean(fd_rotat);
    
    
    % load WM and CSF signals and calculate their difference over time
    load(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'masks', 'covariance_wm_csf.mat'), 'pca_WM', 'pca_CSF');


    % load the preprocessed functional images and calculate the global mean and pairwise variance
    clear ar_mask dtr
    
    % load the brain mask from the GLM step
    v_mask = spm_vol(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'glm_denoise', 'mask.nii'));
    y_mask = spm_read_vols(v_mask);
    a_mask = y_mask(:);
    
    for imagei = 1:length(v_all)
        v = spm_vol(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'glm_denoise', ['Res_' num2str(imagei,'%.4d') '.nii']));
        y = spm_read_vols(v);
        
        ar = y(:);
        ar_mask(:,imagei) = ar(a_mask==1);
    end
    
    gmr = mean(mean(ar_mask)); % grand mean (4D) from the residual images (preprocessed images)
    
    % calculate pairwise variance from the residual images (preprocessed images)
    for imagei = 1:length(v_all)-1
        dtr(imagei) = (mean((ar_mask(:,imagei) - ar_mask(:,imagei+1)).^2));
    end
    
    meanyr = mean(ar_mask); % scaled global mean from the residual images (preprocessed images)
    
    
    % plots
    subplot(2,5,1)
    plot(meany)
    title('Global mean (raw)');xlabel('Image number')
    box off
    
    subplot(2,5,6)
    plot(dt)
    yline(mean(dt)+3*std(dt),'-','3 SD','color',[0 0.4470 0.7410]);
    title('Pairwise variance (raw)');xlabel('Image pair')
    box off
    
    subplot(2,5,2)
    plot([rp(:,1:3) rp(:,4:6)*180/pi])
    title('Rigid body motion');xlabel('Image number')
    box off
    
    subplot(2,5,7)
    plot([fd_trans fd_rotat])
    title('Framewise displacement');xlabel('Image pair')
    legend('Translation','Rotation','location','best','box','off')
    if max(max([fd_trans fd_rotat])) > 1.5
        yline(1.5,'r','FD = 1.5');
    end
    box off
    
    subplot(2,5,3)
    plot([pca_WM(:,1) pca_CSF(:,1)])
    title('WM & CSF');xlabel('Image number')
    legend('WM','CSF','location','best','box','off')
    box off
    
    subplot(2,5,8)
    plot(diff([pca_WM(:,1) pca_CSF(:,1)]))
    title('d(WM) & d(CSF)');xlabel('Image pair')
    legend('WM','CSF','location','best','box','off')
    box off
    
    subplot(2,5,4)
    plot(meanyr)
    title('Global mean (preprocessed)');xlabel('Image number')
    box off
    
    subplot(2,5,9)
    plot(dtr)
    yline(mean(dtr)+3*std(dtr),'-','3 SD','color',[0 0.4470 0.7410]);
    title('Pairewise variance (preprocessed)');xlabel('Image pair')
    box off
    
    corr_raw = corr([meany' rp pca_WM(:,1) pca_CSF(:,1) meanyr']);
    corr_dt = corr([dt' fd_trans fd_rotat diff(pca_WM(:,1)) diff(pca_CSF(:,1)) dtr']);
    
    subplot(2,5,5)
    imagesc(corr_raw)
    caxis([-1 1]);
    yticks(1:10)
    yticklabels({'G raw','HM 1','HM 2','HM 3','HM 4','HM 5','HM 6','WM','CSF','G final'})
    colorbar
    title('Correlation');
    
    subplot(2,5,10)
    imagesc(corr_dt)
    caxis([-1 1]);
    yticks(1:6)
    yticklabels({'V raw','FD T','FD R','d(WM)','d(CSF)','V final'})
    colorbar
    title('Correlation');
    mat_mask = [0 1 1 1 1 0;1 0 0 0 0 1;1 0 0 0 0 1;1 0 0 0 0 1;1 0 0 0 0 1; 0 1 1 1 1 0];
    [x,y] = find((corr_dt>0.3).*mat_mask);
    hold on; scatter(x,y,[],'r','filled')

    exportgraphics(gcf,['C:\Users\synge\Documents\GitHub\Preprocessing_and_QC\QC_images\Q6_time_series\' subjfolder(subji).name '.jpg']);
    
    fprintf('done!\n')
end


function fd = fd_calc(Y)
% calculate framewise displacement
    Y_diff = diff(Y);
    multp = Y_diff*Y_diff';
    fd = sqrt(diag(multp));
end