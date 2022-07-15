%-----------------------------------------------------------------------
% Job saved on 06-May-2022 15:19:55 by cfg_util (rev $Rev: 7345 $)
% spm SPM - SPM12 (7771)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlabbatch

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');
subjfolder = subjfolder([97 98]);

for subji = 1:length(subjfolder)
    v = spm_vol(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\func\' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii']);
    
    for imagei = 1:length(v)
        matlabbatch{subji}.spm.spatial.realign.estwrite.data{1}{imagei,1} = fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\', subjfolder(subji).name, 'func', [subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,' num2str(imagei)]);
    end
    %%
    matlabbatch{subji}.spm.spatial.realign.estwrite.eoptions.quality = 0.9;
    matlabbatch{subji}.spm.spatial.realign.estwrite.eoptions.sep = 4;
    matlabbatch{subji}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
    matlabbatch{subji}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
    matlabbatch{subji}.spm.spatial.realign.estwrite.eoptions.interp = 2;
    matlabbatch{subji}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
    matlabbatch{subji}.spm.spatial.realign.estwrite.eoptions.weight = '';
    matlabbatch{subji}.spm.spatial.realign.estwrite.roptions.which = [0 1];   % mean image only
    matlabbatch{subji}.spm.spatial.realign.estwrite.roptions.interp = 4;
    matlabbatch{subji}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
    matlabbatch{subji}.spm.spatial.realign.estwrite.roptions.mask = 1;
    matlabbatch{subji}.spm.spatial.realign.estwrite.roptions.prefix = 'r';
end
