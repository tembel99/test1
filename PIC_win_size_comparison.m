%% *************** Concentration maps comparison *********************
% Compare the signal from the concentration data of the PIV, the amplitude
% of the vectrino and the total volume concentration of the LISST

%%

close all
clc
clear
%%
DriveFolder=computer_name_identification();

%% directories pathways
% C:\Users\user\OneDrive - Technion
eval(['cd_drive_misc=''',DriveFolder,'\misc'';']);
eval(['cd_drive_mfiles=''',DriveFolder,'\mfiles'';']);
eval(['cd_drive_meetings=''',DriveFolder,'\meetings\'';']);
eval(['cd_drive_results=''',DriveFolder,'\results\'';']);
eval(['cd_drive_PIC=''',DriveFolder,'\data\PIC\'';']);
eval(['cd_drive_PIC_window_size_comp=''',DriveFolder,'\meetings\methods\concentration\PIC\window_size_comparison\'';']);
cd_PIV_Images='H:\PIV\Images';
%%
eval(['load(''',cd_drive_misc,'\resuspension_dates.mat'');']);
eval(['load(''',cd_drive_misc,'\resuspension_sets.mat'');']);
eval(['load(''',cd_drive_misc,'\x-z_31-42.mat'');']);
eval(['load(''',cd_drive_misc,'\x_cm_z_cm.mat'');']);


%%

% line_colors={'k','b','g','r','m'};
% for i_resuspension=1:length(resuspension_dates.day)
% 20171018, set 011, image 66 (number 47)
% resusension_case(1)=6;set_case(1)=11;image_case(1)=47;
image_case=105;
% % 20171101, set 016, image 133 (number 114)
% resusension_case(2)=1;set_case(2)=16;image_case(2)=114;
for i_resuspension=5
    
    set_year_str=num2str((resuspension_dates.year(i_resuspension)),'%02.2d');
    set_month_str=num2str((resuspension_dates.month(i_resuspension)),'%02.2d');
    set_day_str=num2str((resuspension_dates.day(i_resuspension)),'%02.2d');    

    eval(['sets=resuspension_sets.sets_',set_year_str,set_month_str,set_day_str,'(:,1);']);
    % load the PIC structure (full) and matching timeline structure:
    eval(['load(''',cd_drive_PIC_window_size_comp,'\conc_',set_year_str,set_month_str,set_day_str,'_d17.mat'');']);
    eval(['conc_',set_year_str,set_month_str,set_day_str,'_d17=conc_',set_year_str,set_month_str,set_day_str,';']);
    eval(['load(''',cd_drive_PIC_window_size_comp,'\conc_',set_year_str,set_month_str,set_day_str,'_d23.mat'');']);
    eval(['conc_',set_year_str,set_month_str,set_day_str,'_d23=conc_',set_year_str,set_month_str,set_day_str,';']);
    eval(['load(''',cd_drive_PIC,'\Conc\conc_',set_year_str,set_month_str,set_day_str,'.mat'');']);

    % get x&z coordinates:
    eval(['z_cm=squeeze(x_cm_z_cm.x_cm_z_cm_',set_year_str,set_month_str,set_day_str,'.z_cm(:,1));']);
    eval(['x_cm=squeeze(x_cm_z_cm.x_cm_z_cm_',set_year_str,set_month_str,set_day_str,'.x_cm(1,:));']);

    % flow velocity:
    case_name=resuspension_dates.cases(i_resuspension);
    case_str=cell2mat(case_name);

    %%    for set_number=2:length(sets)-1
%     for set_number=1:length(sets)
    for set_number=16
    %     set_number=set_case(i);
        set_real_num=sets(set_number);
        eval(['C=conc_',set_year_str,set_month_str,set_day_str,'.set_',num2str((set_real_num),'%.4d'),'.c;']);
        eval(['C_d17=conc_',set_year_str,set_month_str,set_day_str,'_d17.set_',num2str((set_real_num),'%.4d'),'.c;']);
        eval(['C_d23=conc_',set_year_str,set_month_str,set_day_str,'_d23.set_',num2str((set_real_num),'%.4d'),'.c;']);

        eval(['cd ',cd_PIV_Images,'\',set_year_str,'_',set_month_str,'_',set_day_str,'\set_',num2str((set_real_num),'%.4d'),'\;']);
        files=dir('*.tif');
        %% choose image number
        for i_img=107
%         for i_img=image_case:(length(files)-image_case)
            im1 = imread(fullfile(pwd,files(i_img).name));
            im1=im1(1:1024,:);

        %     f1=imshow(im1);caxis([0 25000]);
        %     set(gcf, 'Position',[500 500 360 300]);
        %     xlabel('x (cm)', 'interpreter','latex');
        %     ylabel('z (cm)', 'interpreter','latex');
        %     
        %     figure('Color',[1 1 1],'Position',[100 100 400 300]);
        %     pcolor(x_cm,z_cm,C(:,:,i_img)),shading interp; colorbar
        %     xlabel('x (cm)', 'interpreter','latex');
        %     ylabel('z (cm)', 'interpreter','latex');
        %     
            figure('Color',[1 1 1],'Position',[2000 100 620 420]);
        %     sgtitle(case_str);
            ha = tight_subplot(2,2,[.07 .06],[.092 .015],[.07 .14]);

            axes(ha(1)); 
            imshow(im1);caxis([0 25000]);
%             ylabel('z (cm)', 'interpreter','latex');

            axes(ha(2)); 
            pcolor(x_cm,z_cm,C(:,:,i_img)),shading interp; 
%             xlabel('x (cm)', 'interpreter','latex');
            ylabel('z (cm)', 'interpreter','latex');
            caxis([0 max(max(C(:,:,i_img)))]);
            ax = gca;
            ax.FontSize = 10;
%             c_bar = colorbar;
%             c_bar.Location = 'northoutside';
%             c_bar.Label.Interpreter = 'latex';
%             c_bar.Label.String = '$C$ $(mg L^{-1})$';
%             c_bar.Label.FontSize = 10;
%             c_bar.Label.FontWeight = 'Bold';        
            
            axes(ha(3)); 
            pcolor(x_cm,z_cm,C_d17(:,:,i_img)),shading interp; 
            xlabel('x (cm)', 'interpreter','latex');
            ylabel('z (cm)', 'interpreter','latex');
            caxis([0 max(max(C(:,:,i_img)))]);
            ax = gca;
            ax.FontSize = 10;
%             c_bar = colorbar;
%             c_bar.Location = 'northoutside';
%             c_bar.Label.Interpreter = 'latex';
%             c_bar.Label.String = '$C$ $(mg L^{-1})$';
%             c_bar.Label.FontSize = 10;
%             c_bar.Label.FontWeight = 'Bold';   
            
            
            axes(ha(4)); 
            pcolor(x_cm,z_cm,C_d23(:,:,i_img)),shading interp; 
            xlabel('x (cm)', 'interpreter','latex');
%             ylabel('z (cm)', 'interpreter','latex');
            caxis([0 max(max(C(:,:,i_img)))]);
            ax = gca;
            ax.FontSize = 10;
            c_bar = colorbar;
%             c_bar.Location = 'northoutside';
            c_bar.Label.Interpreter = 'latex';
            c_bar.Label.String = '$C$ $(mg L^{-1})$';
            c_bar.Label.FontSize = 10;
            c_bar.Label.FontWeight = 'Bold'; 
            c_bar.Position = [0.89 0.09 0.035 0.895];
            
%             pause;
%             close all
        end
    end
    eval(['clear conc_',set_year_str,set_month_str,set_day_str,';']);

end
%%
dim_ann_w=[0.028,0.45,0.028,0.45];
dim_ann_h=[0.96,0.96,0.49,0.49];
str_ann={'(a)','(b)','(c)','(d)'};
for i_ann=1:4
    dim_ann_1 = [dim_ann_w(i_ann), dim_ann_h(i_ann), 0.06,0.056];
    t=annotation('textbox',dim_ann_1,'String',str_ann(i_ann),'FitBoxToText','on','FontSize',12);
    t.EdgeColor = 'none';
end

