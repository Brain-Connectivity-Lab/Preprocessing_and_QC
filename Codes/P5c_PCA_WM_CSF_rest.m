clear
subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 91:length(subjfolder)
    fprintf('extracting pca components for subject %d',subji)
    
    % load masks
    v_WM  = spm_vol(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'masks', 'mask_WM_99.nii'));
    y_WM  = spm_read_vols(v_WM);
    v_CSF = spm_vol(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'masks', 'mask_CSF_99.nii'));
    y_CSF = spm_read_vols(v_CSF);
    
    image_dim = v_WM.dim;
    a_WM  = reshape(y_WM ,image_dim(1)*image_dim(2)*image_dim(3),1);
    a_CSF = reshape(y_CSF,image_dim(1)*image_dim(2)*image_dim(3),1);
    clear a_BOLD_WM a_BOLD_CSF
    
    v = spm_vol(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\func\' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii']);
    
    clear a_BOLD_WM a_BOLD_CSF
    
    for imagei = 1:length(v)
        v_BOLD = spm_vol(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'func', ['w', subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,' num2str(imagei)]));
        y_BOLD = spm_read_vols(v_BOLD);
        a_BOLD = reshape(y_BOLD,image_dim(1)*image_dim(2)*image_dim(3),1);
        
        a_BOLD_WM(:,imagei)  = a_BOLD(find(a_WM  > 0.5));
        a_BOLD_CSF(:,imagei) = a_BOLD(find(a_CSF > 0.5));
    end
    
    % remove NaN voxels
    aa = mean(a_BOLD_WM,2);
    a_BOLD_WM = a_BOLD_WM(isfinite(aa),:);
    aa = mean(a_BOLD_CSF,2);
    a_BOLD_CSF = a_BOLD_CSF(isfinite(aa),:);
    
    a_BOLD_WM = a_BOLD_WM(isfinite(a_BOLD_WM(:,1)),:);
    [c,s_WM]  = pca(a_BOLD_WM');
    a_BOLD_CSF = a_BOLD_CSF(isfinite(a_BOLD_CSF(:,1)),:);
    [c,s_CSF] = pca(a_BOLD_CSF');
    
    pca_WM  = s_WM (:,1:5);
    pca_CSF = s_CSF(:,1:5);
    
    save(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'masks', 'covariance_wm_csf.mat'), 'pca_WM', 'pca_CSF');
    
    fprintf(' done! \n')
end
