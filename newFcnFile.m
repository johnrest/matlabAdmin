%{
% Create a new function file with an specific type of header
% 
% %Create from NEWFCN from Matlab Central
% 
% LOG:        
%         >> 17/06/2016       -Created
% (c)   John Restrepo
% 
%}

function newFcnFile(FcnName)
    
    %Display help when called without arguments
    if nargin == 0, help('newFcnFile'); return; end
    
    %Display error for wrong number of inputs
    if nargin > 1, error('  MSG: Only one Parameter accepted!'); end

    ex = exist(FcnName, 'file');  % does M-Function already exist ? Loop statement

    while ex == 2         % rechecking existence
        overwrite = 0;    % Creation decision
        msg = sprintf(['Sorry, but Function -< %s.m >- does already exist!\n', ...
            'Do you wish to Overwrite it ?'], FcnName);
        % Action Question: Text, Title, Buttons and last one is the Default
        action = questdlg(msg, ' Overwrite Function?', 'Yes', 'No','No');
        if strcmp(action,'Yes') == 1
            ex = 0; % go out of While Loop, set breaking loop statement
        else
            % Dialog for new Functionname
            FcnName = char(inputdlg('Enter new Function Name ... ', 'NEWFCN - New Name'));
            if isempty(FcnName) == 1  % {} = Cancel Button => "1"
                disp('   MSG: User decided to Cancel !')
                return
            else
                ex = exist(FcnName);  % does new functionname exist ?
            end
        end
    end
    
    overwrite = 1;

    if overwrite == 1
        CreationMsg = CreateFcn(FcnName);   % Call of Sub-Function
        disp(['   MSG: <' FcnName '.m> ' CreationMsg])
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%   CREATEFCN   %%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end


function s = CreateFcn(name)
    % Sub-Function will write the M-File, open it and mark the starting write
    % line

    ext = '.m';  % Default extension for a FUNCTION !!
    filename = [name ext];
    
    %Open the file for writing
    fid = fopen(filename,'w');
    
    %First line - Open block commenting
    fprintf(fid,'%s\n', '%{');

    %Second line - Name of the function
    %Select the name part in case full name (i.e. name and directory)
    [~, onlyname, ~] = fileparts(name); 

    line = ['%',onlyname]; % Function Header
    fprintf(fid,'%s\n', line );
    
    %Empty line
    fprintf(fid,'%s\n', '%');
    
    line = ['%','     SHORT DESCRIPTION OF THE FUNCTION']; 
    fprintf(fid,'%s\n', line );
    
    %Empty Lines:
    for ii = 1:4
        fprintf(fid,'%s\n', '%');
    end
    
    line = ['%', '    NOTES:'];
    fprintf(fid,'%s\n', line );
    
    %Empty Lines:
    for ii = 1:2
        fprintf(fid,'%s\n', '%');
    end
    
    line = ['%', '    INPUTS:'];
    fprintf(fid,'%s\n', line );
    
    %Empty Lines:
    for ii = 1:2
        fprintf(fid,'%s\n', '%');
    end
    
    line = ['%', '    OUTPUTS:'];
    fprintf(fid,'%s\n', line );
    
    %Empty Lines:
    for ii = 1:2
        fprintf(fid,'%s\n', '%');
    end
    
    line = ['%', '    LOG:'];
    fprintf(fid,'%s\n', line );

    %Empty Lines:
    for ii = 1:2
        fprintf(fid,'%s\n', '%');
    end

    line = ['%', '    EX:'];
    fprintf(fid,'%s\n', line );
    
    %Empty Lines:
    for ii = 1:2
        fprintf(fid,'%s\n', '%');
    end

    line = ['%', '    see also '];
    fprintf(fid,'%s\n', line );    
    
	%Empty Lines:
    for ii = 1:2
        fprintf(fid,'%s\n', '%');
    end

    dt = datestr(now);    dt(end-8:end) = [];       %Take only date/month/year
    line = ['%', '        >>Created:', dt];
    fprintf(fid,'%s\n', line );
    line = ['%', '        >>'];
    fprintf(fid,'%s\n', line );


    %Empty Lines:
    for ii = 1:2
        fprintf(fid,'%s\n', '%');
    end

    
    line = ['%', '(c) John Restrepo'];
    fprintf(fid,'%s\n', line );

    %Last line of help - close block commenting
    fprintf(fid,'%s\n', '%}');
    
    line = ['function ', onlyname, '()']; % Function Header
    fprintf(fid,'%s\n', line );

    %Empty line:
    fprintf(fid,'%s\n', '');

    %Always prompt help when called without arguments
    line = ['   if nargin == 0, help(''', onlyname, '''); return; end']; % Function Header
    fprintf(fid,'%s\n', line );

    %Empty Lines:
    for ii = 1:6
        fprintf(fid,'%s\n', '');
    end

    fprintf(fid,'%s\n', ['end        %end function:', onlyname]);
    
    % Close the written File
    st = fclose(fid);

    %Verify file is closed
    if st == 0  % "0" for successful
        s = 'successfully done !!';
    else
        s = ' ERROR: Problems encounter while closing File!';
    end
    
end