%{
% dockAllFigs
% 
%     DOCK ALL CURRENT FIGURES
% 
%     LOG:    29/04/2016  >>  Created
% 
%     (c)     John Restrepo.
% 
%}

function dockAllFigs()

%Get all children of the root object
FigHands = get(0,'Children');

if isempty(FigHands)
    disp('No figures to dock...')
else
    for it = 1:numel(FigHands)    
        set(FigHands(it).Number, 'WindowStyle', 'docked');
    end
    disp('All figures docked ... ')
end

end         %main return