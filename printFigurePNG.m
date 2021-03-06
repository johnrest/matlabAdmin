%{
%printFigurePNG
%
%     SHORT DESCRIPTION OF THE FUNCTION
%       Print figure on png with default resolution. Save .fig with
%       identical name.
%
%
%
%    NOTES:
%
%
%    INPUTS:
%           FigRatio: 2x1 vector with values from 0 to 1
%
%    OUTPUTS:
%
%
%    LOG:
%
%
%    EX:
%
%
%    see also 
%
%
%        >>Created:05-Nov-2016
%        >>
%
%
%(c) John Restrepo
%}
function printFigurePNG(FigNumber, FileName, DirName, FigRatio)

   if nargin == 0, help('printFigurePNG'); return; end

   %save figure handle
   FigHandle = figure(FigNumber);
                                                                                       
   %Maximize. Warning: this produces different types of results
   %Resize to FigRatio to avoid large sized empty regions
   set(FigHandle,'units','normalized','outerposition',[0 0 FigRatio(1) FigRatio(2)])
   
   %Increase font size for all characters
   set( findall(FigHandle, '-property', 'FontSize'), 'FontSize', 32 );
   
   %Title font slightly larger than rest.
   TitleHandle = get(gca, 'title');
   set(TitleHandle, 'FontSize', 40, 'FontWeight', 'bold');
   
   %Do proper formatting to enhance print command
   pos = get( FigHandle, 'Position' );
   set( FigHandle, 'PaperPositionMode', 'Auto', 'PaperUnits', 'Inches', 'PaperSize', [pos(3), pos(4)] );
   
   FullName = [DirName,'/', FileName];
   print(FigHandle, FullName,'-dpng','-r0');
   
   %Save .fig file with the same name 
   savefig(FigHandle, FullName);

end        %end function:printFigurePNG
