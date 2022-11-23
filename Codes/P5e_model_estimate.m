%-----------------------------------------------------------------------
% Job saved on 18-Jun-2022 17:06:39 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlabbatch

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    matlabbatch{subji}.spm.stats.fmri_est.spmmat = {fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'glm_denoise', 'SPM.mat')};
    matlabbatch{subji}.spm.stats.fmri_est.write_residuals = 1;   % write residual
    matlabbatch{subji}.spm.stats.fmri_est.method.Classical = 1;
end
