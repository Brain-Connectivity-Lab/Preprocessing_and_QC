% Quality control Q3
% Plot time series from fMRI images and head motion
% Xin Di, July 13, 2022

clear

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

figure
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
    
    
 
    % plots
    subplot(2,2,1)
    plot(meany)
    title('Global mean (raw)');xlabel('Image number')
    box off
    
    subplot(2,2,3)
    plot(dt)
    yline(mean(dt)+3*std(dt),'-','3 SD','color',[0 0.4470 0.7410]);
    title('Pairwise variance (raw)');xlabel('Image pair')
    box off
    
    subplot(2,2,2)
    plot([rp(:,1:3) rp(:,4:6)*180/pi])
    title('Rigid body motion');xlabel('Image number')
    box off
    
    subplot(2,2,4)
    plot([fd_trans fd_rotat])
    title('Framewise displacement');xlabel('Image pair')
    legend('Translation','Rotation','location','best','box','off')
    if max(max([fd_trans fd_rotat])) > 1.5
        yline(1.5,'r','FD = 1.5');
    end
    box off
    
    exportgraphics(gcf,['C:\Users\synge\Documents\GitHub\Preprocessing_and_QC\QC_images\Q3_head_motion\' subjfolder(subji).name '.jpg']);
    
    fprintf('done!\n')
end


function fd = fd_calc(Y)
% calculate framewise displacement
    Y_diff = diff(Y);
    multp = Y_diff*Y_diff';
    fd = sqrt(diag(multp));
end