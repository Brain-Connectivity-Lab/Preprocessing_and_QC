%-----------------------------------------------------------------------
% Job saved on 05-May-2022 09:40:11 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlabbatch

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    
    matlabbatch{subji}.spm.spatial.preproc.channel.vols = {fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name,'anat',[subjfolder(subji).name '_ses-01_run-01_T1w.nii,1'])};
    matlabbatch{subji}.spm.spatial.preproc.channel.biasreg = 0.001;
    matlabbatch{subji}.spm.spatial.preproc.channel.biasfwhm = 60;
    matlabbatch{subji}.spm.spatial.preproc.channel.write = [0 1];  % save bias corrected images
    matlabbatch{subji}.spm.spatial.preproc.tissue(1).tpm = {'C:\Work\Software\spm12\tpm\TPM.nii,1'};
    matlabbatch{subji}.spm.spatial.preproc.tissue(1).ngaus = 1;
    matlabbatch{subji}.spm.spatial.preproc.tissue(1).native = [1 0];
    matlabbatch{subji}.spm.spatial.preproc.tissue(1).warped = [1 1];  % save segmented images in MNI space
    matlabbatch{subji}.spm.spatial.preproc.tissue(2).tpm = {'C:\Work\Software\spm12\tpm\TPM.nii,2'};
    matlabbatch{subji}.spm.spatial.preproc.tissue(2).ngaus = 1;
    matlabbatch{subji}.spm.spatial.preproc.tissue(2).native = [1 0];
    matlabbatch{subji}.spm.spatial.preproc.tissue(2).warped = [1 1];   % save segmented images in MNI space
    matlabbatch{subji}.spm.spatial.preproc.tissue(3).tpm = {'C:\Work\Software\spm12\tpm\TPM.nii,3'};
    matlabbatch{subji}.spm.spatial.preproc.tissue(3).ngaus = 2;
    matlabbatch{subji}.spm.spatial.preproc.tissue(3).native = [1 0];
    matlabbatch{subji}.spm.spatial.preproc.tissue(3).warped = [1 1];   % save segmented images in MNI space
    matlabbatch{subji}.spm.spatial.preproc.tissue(4).tpm = {'C:\Work\Software\spm12\tpm\TPM.nii,4'};
    matlabbatch{subji}.spm.spatial.preproc.tissue(4).ngaus = 3;
    matlabbatch{subji}.spm.spatial.preproc.tissue(4).native = [0 0];
    matlabbatch{subji}.spm.spatial.preproc.tissue(4).warped = [0 0];
    matlabbatch{subji}.spm.spatial.preproc.tissue(5).tpm = {'C:\Work\Software\spm12\tpm\TPM.nii,5'};
    matlabbatch{subji}.spm.spatial.preproc.tissue(5).ngaus = 4;
    matlabbatch{subji}.spm.spatial.preproc.tissue(5).native = [0 0];
    matlabbatch{subji}.spm.spatial.preproc.tissue(5).warped = [0 0];
    matlabbatch{subji}.spm.spatial.preproc.tissue(6).tpm = {'C:\Work\Software\spm12\tpm\TPM.nii,6'};
    matlabbatch{subji}.spm.spatial.preproc.tissue(6).ngaus = 2;
    matlabbatch{subji}.spm.spatial.preproc.tissue(6).native = [0 0];
    matlabbatch{subji}.spm.spatial.preproc.tissue(6).warped = [0 0];
    matlabbatch{subji}.spm.spatial.preproc.warp.mrf = 1;
    matlabbatch{subji}.spm.spatial.preproc.warp.cleanup = 1;
    matlabbatch{subji}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
    matlabbatch{subji}.spm.spatial.preproc.warp.affreg = 'mni';
    matlabbatch{subji}.spm.spatial.preproc.warp.fwhm = 0;
    matlabbatch{subji}.spm.spatial.preproc.warp.samp = 3;
    matlabbatch{subji}.spm.spatial.preproc.warp.write = [0 1];   % save deformation field maps
    matlabbatch{subji}.spm.spatial.preproc.warp.vox = NaN;
    matlabbatch{subji}.spm.spatial.preproc.warp.bb = [NaN NaN NaN
        NaN NaN NaN];
end
