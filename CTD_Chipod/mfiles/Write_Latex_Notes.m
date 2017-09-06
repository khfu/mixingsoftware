function Write_Latex_Notes(Project)
%~~~~~~~~~~~~~~~~~~~~~~~~~~
%
% Write_Latex_Notes.m
%
% Function to write an entire .tex file for standard ctd-Chipod cruise notes
%
% Need to run standard processing before this:
% -
% -
%
%-------------
% 09/27/16 - A.Pickering - andypicke@gmail.com
% 09/03/17 - AP - Turn into general function
%~~~~~~~~~~~~~~~~~~~~~~~~~~
%%

% *** Load paths for CTD and chipod data
eval(['Load_chipod_paths_' Project])

% *** Load chipod deployment info
eval(['Chipod_Deploy_Info_' Project])

% ** need to specify directory to write to


%% open a text file

txtfname=fullfile(cruise_path,Project,'Notes',['Chipod_Note_' Project '_auto.tex']);

fileID= fopen(fullfile(txtfname),'w');
%%
% if exist(fullfile(chi_proc_path,txtfname),'file')==2
%     % results file for this day exists, append a # to it to make new file
%     keepgoing=1;

%% write preamble

%'\' is a control charactar in sprintf, so we need an extra \ before it

fprintf(fileID,['\\documentclass[11pt]{article} \n'])
fprintf(fileID,'\\usepackage{geometry} \n')
fprintf(fileID,'\\geometry{letterpaper} \n')
fprintf(fileID,'\\usepackage{graphicx} \n')
fprintf(fileID,'\\usepackage{amssymb} \n')
fprintf(fileID,'\\usepackage{amsmath} \n')
fprintf(fileID,'\\usepackage{epstopdf} \n')
fprintf(fileID,'\\usepackage{hyperref} \n')
fprintf(fileID,'\\usepackage{natbib} \n')
fprintf(fileID,'\\DeclareGraphicsRule{.tif}{png}{.png}{`convert #1 `dirname #1`/`basename #1 .tif`.png} \n')
%~~~~~~~~


%% set graphics paths (need to loop over SNs)


%*** Set graphics path for figures
fprintf(fileID,'\\graphicspath{\n')
fprintf(fileID,['{' fullfile(cruise_path,Project) '/}\n'])
fprintf(fileID,['{' fullfile(cruise_path,Project,'figures') '/}\n'])
fprintf(fileID,['{' fullfile(cruise_path,Project,'figures','XC') '/}\n'])

% loop through and add path to each SN here
for iSN=1:length(ChiInfo.SNs)
    fprintf(fileID,['{/Users/Andy/Cruises_Research/ChiPod/' Project '/Data/proc/Chipod/SN' ChiInfo.SNs{iSN} '/figures/}\n'])
    fprintf(fileID,['{' fullfile(cruise_path,Project,'figures',['SN' ChiInfo.SNs{iSN}]) '/}\n'])
end
fprintf(fileID,'} \n\n')

%% Begin document

fprintf(fileID,[ '\\title{' Project ' CTD-Chipod Notes} \n'])
fprintf(fileID, '\\author{Andy Pickering} \n')
%\date{}                                           % Activate to display a given date or no date


fprintf(fileID, '\\begin{document} \n')
fprintf(fileID, '\\maketitle \n')

fprintf(fileID, '\\tableofcontents \n')
fprintf(fileID, '\\newpage \n\n')

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fprintf(fileID,'%s',['%~~~~~~~~~~~~~~~~~~~~~~~~~~']);
fprintf(fileID,'\n \\section{About} \n\n');

fprintf(fileID, ['Notes on processing and analysis of CTD-chipod data collected during ' Project ' cruise.. \n\n'])

fprintf(fileID, '\\begin{figure}[htbp] \n')
fprintf(fileID, ['\\includegraphics[width=38pc]{' Project '_kml_map.jpg} \n'])
fprintf(fileID, ['\\caption{Map of CTD cast locations during cruise ' Project '.} \n'])
fprintf(fileID, '\\label{map} \n')
fprintf(fileID, '\\end{figure} \n\n')




%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
fprintf(fileID,'\n\n%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
fprintf(fileID,'\\section{Data and Processing} \n\n')

fprintf(fileID, 'Data paths are set w/ :  \n')
fprintf(fileID, '\\begin{itemize} \n')
fprintf(fileID, ['\\item \\verb+Load_chipod_paths_' Project '.m+ \n'])
fprintf(fileID, '\\end{itemize} \n\n')

fprintf(fileID, 'Chipod deployment info is given in  \n')
fprintf(fileID, '\\begin{itemize} \n')
fprintf(fileID, ['\\item \\verb+Chipod_Deploy_Info_' Project '+ \n'])
fprintf(fileID, '\\end{itemize} \n\n')



fprintf(fileID, '$s', '%~~~~~~~~~~~~ \n\n')
fprintf(fileID, '\\subsection{CTD} \n\n')

fprintf(fileID, 'Raw (hex) CTD data are processed with: \n')
fprintf(fileID, '\\begin{itemize} \n')
fprintf(fileID, ['\\item \\verb+Process_CTD_hex_' Project '.m+ \n'])
fprintf(fileID, '\\end{itemize} \n\n')



fprintf(fileID, '$s', '%~~~~~~~~~~~~ \n\n')
fprintf(fileID, '\\subsection{Chipod} \n\n')

fprintf(fileID, '% **** Made w/ MakeTableChiDeploy \n')
fprintf(fileID, '\\begin{table}[htdp] \n')
fprintf(fileID, '\\caption{Summary of Chipod deployment .} \n')
fprintf(fileID, '\\begin{center} \n')
fprintf(fileID, '\\begin{tabular}{|c|c|c|c|} \n')
fprintf(fileID, '\\hline \n')
fprintf(fileID, '\\end{tabular} \n')
fprintf(fileID, '\\end{center} \n')
fprintf(fileID, '\\label{default} \n')
fprintf(fileID, '\\end{table}% \n\n')


fprintf(fileID, 'Raw chipod files are plotted with  \n')
fprintf(fileID, '\\begin{itemize} \n')
fprintf(fileID, ['\\item \\verb+PlotChipodDataRaw_' Project '.m+ \n'])
fprintf(fileID, '\\end{itemize} \n')
fprintf(fileID, 'to check for obvious issues/malfunctions with any of the instruments; these plots are saved in \verb+/Figures/chipodraw/+.  \n')

fprintf(fileID, '%*** Note any major issues here \n')
fprintf(fileID, 'Based on a quick look at these: \n')
fprintf(fileID, '\\begin{itemize} \n')
fprintf(fileID, '\\item \n')
fprintf(fileID, '\\end{itemize} \n\n')

fprintf(fileID, 'Files with obviously bad or missing data (based on above raw plots) are noted in \verb+bad_file_list_XXXX.m+ and, which will prevent them from being loaded in the processing. \n\n')

fprintf(fileID, 'Processing scripts are: \n')
fprintf(fileID, '\\begin{itemize} \n')
fprintf(fileID, ['\\item \\verb+MakeCasts_CTDchipod_' Project '.m+ \n'])
fprintf(fileID, ['\\item \\verb+DoChiCalc_' Project '.m+ \n'])
fprintf(fileID, '\\end{itemize} \n\n')



fprintf(fileID, '$s', '%~~~~~~~~~~~~ \n\n')
fprintf(fileID, '\\subsection{Further processing and analysis} \n\n')

fprintf(fileID, '\\begin{itemize} \n')
fprintf(fileID, ['\\item Data from all casts are combined into a single structure w/ \verb+MakeCombinedStruct_' Project '.m+ \n'])
fprintf(fileID, '\\item  \n')
fprintf(fileID, '\\end{itemize} \n\n')


fprintf(fileID, '\\newpage \n\n')
fprintf(fileID,'%s',['%~~~~~~~~~~~~~~~~~~~~~~~~~~']);
fprintf(fileID, '\n \\section{Processing Notes} \n\n')

fprintf(fileID, '\\begin{itemize} \n')
fprintf(fileID, '\\item Table \ref{chidepinfo} gives the info for $\chi$pods deployed. \n')
fprintf(fileID, '\\item Table \ref{procsum} gives a summary of the processing from MakeCasts. \n')
fprintf(fileID, '\\end{itemize} \n\n')

fprintf(fileID, '%% make and insert table 1 \n\n')


fprintf(fileID, '%% make and insert table 2 \n\n')


fprintf(fileID, '%% continue... \n\n')

fprintf(fileID, '%~~ \n\n')
fprintf(fileID, '$s', '%~~~~~~~~~~~~ \n\n')
fprintf(fileID, '\\subsubsection{Time Offsets} \n\n')


fprintf(fileID, '\\begin{figure}[htbp] \n\n')
fprintf(fileID, ['\\includegraphics[scale=1]{' Project '_timeoffsets_all.png} \n'])
fprintf(fileID, '\\caption{Time-offsets for all $\\chi$pods, found by aligning with CTD data.} \n')
fprintf(fileID, '\\label{toffs} \n')
fprintf(fileID, '\\end{figure} \n\n')



fprintf(fileID, '\\newpage \n\n')
fprintf(fileID,'%s',['%~~~~~~~~~~~~~~~~~~~~~~~~~~']);
fprintf(fileID, '\n \\section{Example Raw Chipod Data for 1 cast} \n\n')

for iSN=1:length(ChiInfo.SNs)
    
    fprintf(fileID, '\\begin{figure}[htbp] \n')
    fprintf(fileID, ['\\includegraphics[scale=0.7]{SN' ChiInfo.SNs{iSN} '_001_Fig1_RawChipodTS.png} \n'])
    fprintf(fileID, ['\\caption{Raw chipod data from SN' ChiInfo.SNs{iSN} 'for a CTD cast.} \n'])
    fprintf(fileID, ['\\label{sn' ChiInfo.SNs{iSN} '_1} \n'])
    fprintf(fileID, '\\end{figure} \n\n')
    
end
%%

fprintf(fileID, '\\newpage \n\n')
fprintf(fileID,'\n\n%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
fprintf(fileID, '\\section{Results} \n\n')


fprintf(fileID, '\\clearpage \n\n')
fprintf(fileID, '$s', '%~~~~~~~~~~~~ \n\n')
fprintf(fileID, '\\subsubsection{CTD Data } \n')

fprintf(fileID, '% Figure showing pcolor of t and s from all casts \n')
fprintf(fileID, '\\begin{figure}[htbp] \n')
fprintf(fileID, ['\\includegraphics[scale=0.7]{' Project '_ctd_t_s.png} \n'])
fprintf(fileID, '\\caption{Plot of temperature and salinity from CTD downcasts on all casts.} \n')
fprintf(fileID, '\\label{} \n')
fprintf(fileID, '\\end{figure} \n\n')


fprintf(fileID, '\\clearpage \n\n')
%~~


fprintf(fileID, '$s', '%~~~~~~~~~~~~ \n\n')
fprintf(fileID, '\\subsubsection{Data from each individual Chipod} \n\n')

% LOOP over SNs
% *** One for each chipod
for iSN=1:length(ChiInfo.SNs)
    whSN=ChiInfo.SNs{iSN};
    fprintf(fileID, '\\begin{figure}[htbp] \n')
    fprintf(fileID, ['\\includegraphics[scale=0.7]{XC_' whSN '_Vs_lat_' ChiInfo.(whSN).InstDir.T1 'AllVars.png} \n'])
    fprintf(fileID, ['\\caption{All chipod profiles from sensor ' whSN '. Variables are: N2, dTdz, chi, eps, and KT.} \n'])
    fprintf(fileID, '\\label{} \n')
    fprintf(fileID, '\\end{figure} \n\n')
end

fprintf(fileID, '\\clearpage \n')
fprintf(fileID, '\\newpage \n')
%~~


fprintf(fileID, '$s', '%~~~~~~~~~~~~ \n\n')
fprintf(fileID, '\\subsubsection{One variable from all Chipods} \n\n')

fprintf(fileID, '\\begin{figure}[htbp] \n')
fprintf(fileID, ['\\includegraphics[scale=0.7]{' Project '_chi_AllSNs_Vslat.png} \n'])
fprintf(fileID, '\\caption{Plot of one variable from all chipods.} \n')
fprintf(fileID, '\\label{} \n')
fprintf(fileID, '\\end{figure} \n\n')

fprintf(fileID, '\\begin{figure}[htbp] \n')
fprintf(fileID, ['\\includegraphics[scale=0.7]{' Project '_KT_AllSNs_Vslat.png} \n'])
fprintf(fileID, '\\caption{Plot of one variable from all chipods.} \n')
fprintf(fileID, '\\label{} \n')
fprintf(fileID, '\\end{figure} \n\n')


fprintf(fileID, '\\end{document}  \n')
fprintf(fileID,'\n\n%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n')
%%
