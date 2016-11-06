%{
%sliderFigs
%
%     SHORT DESCRIPTION OF THE FUNCTION
%     Create a new figure that groups multiple figures into one.
%     The function creates a new figure to which the axes of other figures
%     are copied, according to the slider. The figures keep the creation 
%     order or the one designated by the input vector.
%
%
%    NOTES: All figs must stay created, since the function simply copies
%           the axis from one figure to another.
%
%
%    INPUTS: VectorSelFigs: Vector with figure numbers to group. 
%                           
%
%
%    OUTPUTS: --
%
%
%    LOG:
% 
%        >>Created:05-Nov-2016
%        >>
% 
%
%    EX: (1) sliderFigs([]);                %Group all figures
%        (2) sliderFigs([1,2,10,3,4,5])     %Group indicated figures
%        (3) sliderFigs();                  %Displays help
%
% 
%    see also findobj, copyobj, uicontrol
%
%
%(c) John Restrepo
%}

function sliderFigs( VectorSelFigs )
    
   if nargin == 0, help('sliderFigs'); return; end
   
   %Do not create slider for a single figure
   if numel(VectorSelFigs) == 1
       error('Error: only one figure, no slider possible ... see Help');
       return;
   end
    
   if isempty(VectorSelFigs)               %Empty argument == Do all figures

       %Get list of all current figures
       ListAllFigs = findall(0,'type','figure');
       
       %Get numeric vector of figures
       VectorSelFigs = [ListAllFigs(:).Number];
       
       %Re-order for first figures display first
       VectorSelFigs = fliplr(VectorSelFigs);
   end
   
   %Create a cell array with all the axes inside the figures
   CellAxesHandles = cell(1,numel(VectorSelFigs));      %pre-alloc
   for ii = 1:numel(VectorSelFigs)
              
       crFigHandle= figure(VectorSelFigs(ii));
       FigChildren = get(crFigHandle,'children');
       CellAxesHandles{ii} = findobj(FigChildren,'type','Axes');

   end

   NewFigHandle = figure;
   
   set(NewFigHandle, 'Position', [680 558, 560, 560]);
   set(NewFigHandle, 'Name', 'FigureViewer', 'Toolbar', 'figure', 'NumberTitle', 'off', 'Color', [1,1,1]);

   
	%Create the slider
	SliderHandle = uicontrol(NewFigHandle, 'Style', 'slider', 'Max', numel(VectorSelFigs), 'Min', 1, ...
							 'Value', 1, 'SliderStep', [1/(numel(VectorSelFigs)-1), 10/(numel(VectorSelFigs)-1)], ...
							 'Units', 'normalized', 'Position', [.1, .02, .8, .05]  ); 	

	%Variable for Callbacks
	Vars = struct('SliderHandle', SliderHandle, 'Axes', CellAxesHandles, ...
            'Fig', NewFigHandle);
        
    %Copy first element in CellAxesHandles
    copyobj(CellAxesHandles{1}, NewFigHandle);

    %Set the callback for the slider
    set(SliderHandle, 'Callback', {@sliderCallback, Vars });


end        %end function:sliderFigs

%Callback admin function
function [] = sliderCallback(~,~,Vars)

	showCurrent(Vars);

end 		%return

%Actual copying.
function [] = showCurrent(Vars)
	
    %Rename the handle locally
	CurrHandle = Vars.SliderHandle;
    CurrFig = round(CurrHandle.Value);
    CurrNewFigHandle = Vars.Fig;
    CurrAxes = Vars(CurrFig).Axes;
    
    %Delete the current graphics to avoid superimpose
    figure(CurrNewFigHandle);
    delete(gca);
    
    %Copy object for current axes
    copyobj(CurrAxes, CurrNewFigHandle);
        
end	 		%return
