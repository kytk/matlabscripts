% vbm_preproc_existing_dartel_batch.m
% batch script for VBM preprocessing (existing DARTEL templates)
% Usage: put this file under Matlab path
%        type vbm_preproc_existing_dartel_batch in Matlab command window
% Requirements: SPM12
% 8/June/2017 K.Nemoto

%% Initialize batch
spm_jobman('initcfg');
matlabbatch = {};

%% Select T1 files
imglist = spm_select(Inf,'image','Select T1 volume files');
t1vols = cellstr(imglist);

%% Prepare the SPM window
% interactive window (bottom-left) to show the progress, 
% and graphics window (right) to show the result of coregistration 

%spm('CreateMenuWin','on'); %Comment out if you want the top-left window.
spm('CreateIntWin','on');
spm_figure('Create','Graphics','Graphics','on');

%% Select DARTEL Template1 (and specify remaining Templates)
dartemp1 = spm_select(1,'image','Select DARTEL template1',{},pwd,'.*_1.nii',1);
dartemp1 = dartemp1(:,1:end-2);
dartemp2 = strrep(dartemp1,'1.nii','2.nii');
dartemp3 = strrep(dartemp1,'1.nii','3.nii');
dartemp4 = strrep(dartemp1,'1.nii','4.nii');
dartemp5 = strrep(dartemp1,'1.nii','5.nii');
dartemp6 = strrep(dartemp1,'1.nii','6.nii');

%% Segmentation
matlabbatch{1}.spm.spatial.preproc.channel.vols = t1vols;
matlabbatch{1}.spm.spatial.preproc.channel.biasreg = 0.001;
matlabbatch{1}.spm.spatial.preproc.channel.biasfwhm = 60;
matlabbatch{1}.spm.spatial.preproc.channel.write = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(1).tpm = {fullfile(spm('Dir'),'tpm/TPM.nii,1')};
matlabbatch{1}.spm.spatial.preproc.tissue(1).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(1).native = [1 1];
matlabbatch{1}.spm.spatial.preproc.tissue(1).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(2).tpm = {fullfile(spm('Dir'),'tpm/TPM.nii,2')};
matlabbatch{1}.spm.spatial.preproc.tissue(2).ngaus = 1;
matlabbatch{1}.spm.spatial.preproc.tissue(2).native = [0 1];
matlabbatch{1}.spm.spatial.preproc.tissue(2).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).tpm = {fullfile(spm('Dir'),'tpm/TPM.nii,3')};
matlabbatch{1}.spm.spatial.preproc.tissue(3).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(3).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(3).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).tpm = {fullfile(spm('Dir'),'tpm/TPM.nii,4')};
matlabbatch{1}.spm.spatial.preproc.tissue(4).ngaus = 3;
matlabbatch{1}.spm.spatial.preproc.tissue(4).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(4).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).tpm = {fullfile(spm('Dir'),'tpm/TPM.nii,5')};
matlabbatch{1}.spm.spatial.preproc.tissue(5).ngaus = 4;
matlabbatch{1}.spm.spatial.preproc.tissue(5).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(5).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).tpm = {fullfile(spm('Dir'),'tpm/TPM.nii,6')};
matlabbatch{1}.spm.spatial.preproc.tissue(6).ngaus = 2;
matlabbatch{1}.spm.spatial.preproc.tissue(6).native = [0 0];
matlabbatch{1}.spm.spatial.preproc.tissue(6).warped = [0 0];
matlabbatch{1}.spm.spatial.preproc.warp.mrf = 1;
matlabbatch{1}.spm.spatial.preproc.warp.cleanup = 1;
matlabbatch{1}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
matlabbatch{1}.spm.spatial.preproc.warp.affreg = 'mni';
matlabbatch{1}.spm.spatial.preproc.warp.fwhm = 0;
matlabbatch{1}.spm.spatial.preproc.warp.samp = 3;
matlabbatch{1}.spm.spatial.preproc.warp.write = [0 0];

%% Save Tissue Volumes as Tissue_volumes.csv
matlabbatch{2}.spm.util.tvol.matfiles(1) = cfg_dep('Segment: Seg Params', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','param', '()',{':'}));
matlabbatch{2}.spm.util.tvol.tmax = 3;
matlabbatch{2}.spm.util.tvol.mask = {fullfile(spm('Dir'),'tpm/mask_ICV.nii,1')};
matlabbatch{2}.spm.util.tvol.outf = 'Tissue_Volumes.csv';

%% Dartel (existing Templates)
matlabbatch{3}.spm.tools.dartel.warp1.images{1}(1) = cfg_dep('Segment: rc1 Images', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{1}, '.','rc', '()',{':'}));
matlabbatch{3}.spm.tools.dartel.warp1.images{2}(1) = cfg_dep('Segment: rc2 Images', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{2}, '.','rc', '()',{':'}));
matlabbatch{3}.spm.tools.dartel.warp1.settings.rform = 0;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(1).its = 3;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(1).rparam = [4 2 1e-06];
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(1).K = 0;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(1).template = {dartemp1};
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(2).its = 3;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(2).rparam = [2 1 1e-06];
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(2).K = 0;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(2).template = {dartemp2};
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(3).its = 3;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(3).rparam = [1 0.5 1e-06];
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(3).K = 1;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(3).template = {dartemp3};
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(4).its = 3;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(4).rparam = [0.5 0.25 1e-06];
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(4).K = 2;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(4).template = {dartemp4};
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(5).its = 3;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(5).rparam = [0.25 0.125 1e-06];
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(5).K = 4;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(5).template = {dartemp5};
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(6).its = 3;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(6).rparam = [0.25 0.125 1e-06];
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(6).K = 6;
matlabbatch{3}.spm.tools.dartel.warp1.settings.param(6).template = {dartemp6};
matlabbatch{3}.spm.tools.dartel.warp1.settings.optim.lmreg = 0.01;
matlabbatch{3}.spm.tools.dartel.warp1.settings.optim.cyc = 3;
matlabbatch{3}.spm.tools.dartel.warp1.settings.optim.its = 3;

%% Normalize to MNI (preserve volumes)
matlabbatch{4}.spm.tools.dartel.mni_norm.template = {dartemp6};
matlabbatch{4}.spm.tools.dartel.mni_norm.data.subjs.flowfields(1) = cfg_dep('Run Dartel (existing Templates): Flow Fields', substruct('.','val', '{}',{3}, '.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','files', '()',{':'}));
matlabbatch{4}.spm.tools.dartel.mni_norm.data.subjs.images{1}(1) = cfg_dep('Segment: c1 Images', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','tiss', '()',{1}, '.','c', '()',{':'}));
matlabbatch{4}.spm.tools.dartel.mni_norm.vox = [NaN NaN NaN];
matlabbatch{4}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{4}.spm.tools.dartel.mni_norm.preserve = 1;
matlabbatch{4}.spm.tools.dartel.mni_norm.fwhm = [8 8 8];

%% Run batch
spm_jobman('interactive',matlabbatch);

