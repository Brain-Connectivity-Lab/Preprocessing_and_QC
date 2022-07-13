% Quality control Q4
% Check registration between the functional and anatomical images
% Xin Di, July 13, 2022

clear

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    imgs = char(fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'func', [subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,1']),...
        fullfile('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected', subjfolder(subji).name, 'anat', ['ss_m' subjfolder(subji).name '_ses-01_run-01_T1w.nii,1']));
    
    spm_check_registration(imgs);
    
    % Display the participant's ID
    spm_orthviews('Caption', 1, subjfolder(subji).name);
    
    % Display contour of 1st image onto 2nd
    spm_orthviews('contour','display',1,2)
    
    spm_print(['C:\Users\synge\Documents\GitHub\Preprocessing_and_QC\QC_images\Q4_coregister_check\' subjfolder(subji).name '.jpg'],'Graphics','jpg')
end
