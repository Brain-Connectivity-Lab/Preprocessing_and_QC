% Quality control Q2
% Plot the segmented images in MNI space and plot the MNI template as a
% reference
% Xin Di, July 13, 2022

clear

subjfolder = dir('F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\sub*');

for subji = 1:length(subjfolder)
    imgs = char(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\anat\wc1' subjfolder(subji).name '_ses-01_run-01_T1w.nii'],...
        'C:\Work\Software\spm12\canonical\single_subj_T1.nii');
    
    spm_check_registration(imgs);
    
    % Display the participant's ID
    spm_orthviews('Caption', 1, subjfolder(subji).name);
    spm_orthviews('Caption', 2, 'single_subj_T1 (MNI)');
    
    % Display contour of 1st image onto 2nd
    spm_orthviews('contour','display',1,2)
    
    global st
    
    % Overlay gray matter, white matter, and CSF images onto the first
    % imaage
    vol = spm_vol(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\anat\wc1' subjfolder(subji).name '_ses-01_run-01_T1w.nii']);
    mat = vol.mat;
    st.vols{1}.blobs=cell(1,1);
    bset = 1;
    st.vols{1}.blobs{bset} = struct('vol',vol, 'mat',mat, ...
        'max',1, 'min',0, 'colour',[1 0 0]);
   
    vol = spm_vol(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\anat\wc2' subjfolder(subji).name '_ses-01_run-01_T1w.nii']);
    mat = vol.mat;
    bset = 2;
    st.vols{1}.blobs{bset} = struct('vol',vol, 'mat',mat, ...
        'max',1, 'min',0, 'colour',[0 1 0]);
    
    vol = spm_vol(['F:\fMRI_QC\fmri-open-qc-rest_bias_corrected\' subjfolder(subji).name '\anat\wc3' subjfolder(subji).name '_ses-01_run-01_T1w.nii']);
    mat = vol.mat;
    bset = 3;
    st.vols{1}.blobs{bset} = struct('vol',vol, 'mat',mat, ...
        'max',1, 'min',0, 'colour',[0 0 1]);

    spm_orthviews('Redraw')
    
%     spm_orthviews('Addtruecolourimage',1,['F:\fMRI_QC\fmri-open-qc-rest\' subjfolder(subji).name '\anat\wc1' subjfolder(subji).name '_ses-01_run-01_T1w.nii'],[0 0 0;1 0 0])
%     spm_orthviews('Addtruecolourimage',1,['F:\fMRI_QC\fmri-open-qc-rest\' subjfolder(subji).name '\anat\wc2' subjfolder(subji).name '_ses-01_run-01_T1w.nii'],[0 0 0;0 1 0])
%     spm_orthviews('Addtruecolourimage',1,['F:\fMRI_QC\fmri-open-qc-rest\' subjfolder(subji).name '\anat\wc3' subjfolder(subji).name '_ses-01_run-01_T1w.nii'],[0 0 0;0 0 1])
%     spm_orthviews('Redraw')
    
    spm_orthviews('Xhairs','off')
    
    spm_print(['C:\Users\synge\Documents\GitHub\Preprocessing_and_QC\QC_images\Q2_segmentation_check\' subjfolder(subji).name '.jpg'],'Graphics','jpg')
end
