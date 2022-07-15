%-----------------------------------------------------------------------
% Job saved on 07-May-2022 10:01:08 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlabbatch

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');
subjfolder = subjfolder([97 98]);

for subji = 1:length(subjfolder)
    matlabbatch{subji}.spm.spatial.coreg.estimate.ref = {fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'anat', ['ss_m' subjfolder(subji).name '_ses-01_run-01_T1w.nii,1'])};
    matlabbatch{subji}.spm.spatial.coreg.estimate.source = {fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'func', ['mean' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,1'])};
    %%
    v = spm_vol(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\func\' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii']);
    
    for imagei = 1:length(v)
        matlabbatch{subji}.spm.spatial.coreg.estimate.other{imagei,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'func', [subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,' num2str(imagei)]);
    end
    %%
    matlabbatch{subji}.spm.spatial.coreg.estimate.eoptions.cost_fun = 'nmi';
    matlabbatch{subji}.spm.spatial.coreg.estimate.eoptions.sep = [4 2];
    matlabbatch{subji}.spm.spatial.coreg.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
    matlabbatch{subji}.spm.spatial.coreg.estimate.eoptions.fwhm = [7 7];
end
