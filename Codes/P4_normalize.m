%-----------------------------------------------------------------------
% Job saved on 08-May-2022 10:00:51 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlabbatch

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    matlabbatch{1}.spm.spatial.normalise.write.subj(subji).def = {fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'anat', ['y_' subjfolder(subji).name '_ses-01_run-01_T1w.nii'])};
    
    v = spm_vol(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\func\' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii']);
    
    for imagei = 1:length(v)
        matlabbatch{1}.spm.spatial.normalise.write.subj(subji).resample{imagei,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'func', [subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,' num2str(imagei)]);
    end
end
matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
    78 76 85];
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [3 3 3];   % set voxel size
matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
matlabbatch{1}.spm.spatial.normalise.write.woptions.prefix = 'w';
