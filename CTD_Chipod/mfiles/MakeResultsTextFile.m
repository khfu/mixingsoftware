%~~~~~~~~~~~~~~~~~~~~~~~~~~~
%
% MakeResultsTextFile.m
%
% Initialize a text file for results of CTD-chipod processing
%
% Replaces a bunch of lines in processing script (deletes any files of same
% name already existing in chi_proc_path).
% 
%---------------
% 10/07/15 - AP - apickering@coas.oregonstate.edu - initial coding
% 10/26/15 - AP - 
%~~~~~~~~~~~~~~~~~~~~~~~~~~~
%%

% make a text file to print a summary of results to
txtfname=['Results' datestr(floor(now)) '.txt'];

if exist(fullfile(chi_proc_path,txtfname),'file')==2
    % results file for this day exists, append a # to it to make new file
    keepgoing=1;
    a=1;
    while keepgoing==1
        testname=[txtfname(1:end-4) '_' num2str(a) '.txt'];
        if exist(fullfile(chi_proc_path,testname))
            a=a+1;
        else
            txtfname=testname;
            keepgoing=0;
        end
    end
end

fileID= fopen(fullfile(chi_proc_path,txtfname),'a');
fprintf(fileID,['\n ~~~~~~~~~~~~~~~~ \n CTD-chipod Processing Summary\n']);
fprintf(fileID,[' Created ' datestr(now) '\n Current Dir:' pwd ' \n~~~~~~~~~~~~~~~~ \n']);
fprintf(fileID,'\n Processed CTD path: \n');
fprintf(fileID,[CTD_out_dir_root '\n']);
fprintf(fileID,'\n Raw chipod data path: \n');
fprintf(fileID,[chi_data_path '\n']);
fprintf(fileID,'\n Processed chipod path: \n');
fprintf(fileID,[chi_proc_path '\n']);
%fprintf(fileID,'\n figure path \n');
%fprintf(fileID,[chi_fig_path '\n \n']);
fprintf(fileID,[' \n There are ' num2str(length(CTD_list)) ' CTD files' ]);

%%