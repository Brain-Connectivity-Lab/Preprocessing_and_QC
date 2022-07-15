%-----------------------------------------------------------------------
% Job saved on 17-Jun-2022 09:26:13 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlab

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');


for subji = 1:length(subjfolder)
    matlabbatch{subji}.spm.util.imcalc.input{1,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'func', ['w' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,1']);
    matlabbatch{subji}.spm.util.imcalc.input{2,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'anat', ['wc2' subjfolder(subji).name '_ses-01_run-01_T1w.nii']);
    matlabbatch{subji}.spm.util.imcalc.output = 'mask_WM_99';
    matlabbatch{subji}.spm.util.imcalc.outdir = {fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'masks')};
    matlabbatch{subji}.spm.util.imcalc.expression = 'i2 > 0.99';
    matlabbatch{subji}.spm.util.imcalc.var = struct('name', {}, 'value', {});
    matlabbatch{subji}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{subji}.spm.util.imcalc.options.mask = 0;
    matlabbatch{subji}.spm.util.imcalc.options.interp = 0;
    matlabbatch{subji}.spm.util.imcalc.options.dtype = 4;
end
