%-----------------------------------------------------------------------
% Job saved on 08-Aug-2019 12:00:18 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7487)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlabbatch

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    v = spm_vol(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'func', ['w', subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii']));

    matlabbatch{subji}.spm.stats.fmri_spec.dir = {fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'glm_denoise')};
    matlabbatch{subji}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{subji}.spm.stats.fmri_spec.timing.RT = v(1).private.timing.tspace;
    matlabbatch{subji}.spm.stats.fmri_spec.timing.fmri_t = 16;
    matlabbatch{subji}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
    for imagei = 1:length(v)
        matlabbatch{subji}.spm.stats.fmri_spec.sess.scans{imagei,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'func', ['w', subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,' num2str(imagei)]);
    end
    matlabbatch{subji}.spm.stats.fmri_spec.sess.cond = struct('name', {}, 'onset', {}, 'duration', {}, 'tmod', {}, 'pmod', {}, 'orth', {});
    matlabbatch{subji}.spm.stats.fmri_spec.sess.multi = {''};
    
    % load head motion parameters
    rp = load(['F:\fMRI_QC\fmri-open-qc-rest\' subjfolder(subji).name '\func\rp_' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.txt']);
    rp = zscore(rp);
    rp_previous = [0 0 0 0 0 0; rp(1:end-1,:)];
    rp_auto = [rp rp.^2 rp_previous rp_previous.^2];
    for regressi = 1:24
        matlabbatch{subji}.spm.stats.fmri_spec.sess.regress(regressi).name = 'mot auto';
        matlabbatch{subji}.spm.stats.fmri_spec.sess.regress(regressi).val = rp_auto(:,regressi);
    end
    
    % load WM CSF signals
    load(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'masks', 'covariance_wm_csf.mat'), 'pca_WM', 'pca_CSF');
    n = 1;
    for regressi = 1:n
        matlabbatch{subji}.spm.stats.fmri_spec.sess.regress(regressi+24).name = 'WM';
        matlabbatch{subji}.spm.stats.fmri_spec.sess.regress(regressi+24).val = pca_WM(:,regressi);
        
        matlabbatch{subji}.spm.stats.fmri_spec.sess.regress(regressi+24+n).name = 'CSF';
        matlabbatch{subji}.spm.stats.fmri_spec.sess.regress(regressi+24+n).val = pca_CSF(:,regressi);
    end
    
    matlabbatch{subji}.spm.stats.fmri_spec.sess.multi_reg = {''};
    matlabbatch{subji}.spm.stats.fmri_spec.sess.hpf = 128;
    matlabbatch{subji}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{subji}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{subji}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{subji}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{subji}.spm.stats.fmri_spec.mthresh = 0.8;
    matlabbatch{subji}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{subji}.spm.stats.fmri_spec.cvi = 'AR(1)';
end