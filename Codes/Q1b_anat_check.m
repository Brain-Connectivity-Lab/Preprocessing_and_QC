% Quality control Q1b
% Plot the anatomical image and check its intitial position with reference to the MNI template
% Xin Di, July 13, 2022

clear

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    imgs = char(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\anat\' subjfolder(subji).name '_ses-01_run-01_T1w.nii'],...
        'C:\Work\Software\spm12\canonical\single_subj_T1.nii');
    
    spm_check_registration(imgs);  % Plot the two images using Check Registration 
    
    % Display the participant's ID
    spm_orthviews('Caption', 1, subjfolder(subji).name);
    spm_orthviews('Caption', 2, 'single_subj_T1 (MNI)');
    
    % Display contour of 1st image onto 2nd
    spm_orthviews('contour','display',1,2);
    
    spm_print(['C:\Users\synge\Documents\GitHub\Preprocessing_and_QC\QC_images\Q1b_anat_check\' subjfolder(subji).name '.jpg'],'Graphics','jpg')
end
