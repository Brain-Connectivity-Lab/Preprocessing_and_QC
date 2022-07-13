% Quality control Q1c
% Plot the first functional image and check its intitial position with reference to the MNI template
% Xin Di, July 13, 2022

clear

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    imgs = char(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\func\' subjfolder(subji).name '_ses-01_task-rest_run-01_bold.nii,1'],...
        'C:\Work\Software\spm12\canonical\single_subj_T1.nii');
    
    spm_check_registration(imgs);
    
    % Display the participant's ID
    spm_orthviews('Caption', 1, subjfolder(subji).name);
    spm_orthviews('Caption', 2, 'single_subj_T1 (MNI)');
    
    % Display contour of 1st image onto 2nd
    spm_orthviews('contour','display',1,2)
    
    spm_print(['C:\Users\synge\Documents\GitHub\Preprocessing_and_QC\QC_images\Q1c_func_check\' subjfolder(subji).name '.jpg'],'Graphics','jpg')
end
