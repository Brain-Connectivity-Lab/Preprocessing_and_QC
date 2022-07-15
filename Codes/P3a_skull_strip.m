%-----------------------------------------------------------------------
% Job saved on 06-May-2022 10:32:43 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlabbatch

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    matlabbatch{subji}.spm.util.imcalc.input{1,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'anat', ['m' subjfolder(subji).name '_ses-01_run-01_T1w.nii,1']);
    matlabbatch{subji}.spm.util.imcalc.input{2,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'anat', ['c1' subjfolder(subji).name '_ses-01_run-01_T1w.nii,1']);
    matlabbatch{subji}.spm.util.imcalc.input{3,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'anat', ['c2' subjfolder(subji).name '_ses-01_run-01_T1w.nii,1']);
    matlabbatch{subji}.spm.util.imcalc.input{4,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'anat', ['c3' subjfolder(subji).name '_ses-01_run-01_T1w.nii,1']);
    
    matlabbatch{subji}.spm.util.imcalc.output = ['ss_m' subjfolder(subji).name '_ses-01_run-01_T1w'];
    matlabbatch{subji}.spm.util.imcalc.outdir = {fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'anat')};
    matlabbatch{subji}.spm.util.imcalc.expression = 'i1.*((i2+i3+i4)>0.5)';
    matlabbatch{subji}.spm.util.imcalc.var = struct('name', {}, 'value', {});
    matlabbatch{subji}.spm.util.imcalc.options.dmtx = 0;
    matlabbatch{subji}.spm.util.imcalc.options.mask = 0;
    matlabbatch{subji}.spm.util.imcalc.options.interp = 1;
    matlabbatch{subji}.spm.util.imcalc.options.dtype = 4;
end
