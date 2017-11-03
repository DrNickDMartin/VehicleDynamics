function stop = optimplotfval(~,optimValues,state,varargin)
% OPTIMPLOTFVAL Plot value of the objective function at each iteration.
%
%   STOP = OPTIMPLOTFVAL(X,OPTIMVALUES,STATE) plots OPTIMVALUES.fval.  If
%   the function value is not scalar, a bar plot of the elements at the
%   current iteration is displayed.  If the OPTIMVALUES.fval field does not
%   exist, the OPTIMVALUES.residual field is used.
%
%   Example:
%   Create an options structure that will use OPTIMPLOTFVAL as the plot
%   function
%     options = optimset('PlotFcns',@optimplotfval);
%
%   Pass the options into an optimization problem to view the plot
%     fminbnd(@sin,3,10,options)

%   Copyright 2006-2010 The MathWorks, Inc.
%   $Revision: 1.1.6.2 $  $Date: 2012/08/21 00:30:41 $

stop = false;
switch state
    case 'iter'
        if isfield(optimValues,'fval')
            if isscalar(optimValues.fval)
                plotscalar(optimValues.iteration,optimValues.fval);
            else
                plotvector(optimValues.iteration,optimValues.fval);
            end
        else
            plotvector(optimValues.iteration,optimValues.residual);
        end
end

function plotscalar(iteration,fval)
% PLOTSCALAR initializes or updates a line plot of the function value
% at each iteration.

if iteration == 0
    axes(findobj(gcf,'Tag','Fval_axes'))
    plotfval = plot(iteration,fval,'b.');    
    title(getString(message('MATLAB:funfun:optimplots:TitleCurrentFunctionValue',sprintf('%g',fval))),'interp','none');
    xlabel(getString(message('MATLAB:funfun:optimplots:LabelIteration')),'interp','none');
    set(plotfval,'Tag','optimplotfval');
    ylabel(getString(message('MATLAB:funfun:optimplots:LabelFunctionValue')),'interp','none')
else
    allaxes = findall(gcf,'type','axes');    
    plotfval= get(allaxes(2),'Children');
    newX = [get(plotfval,'Xdata') iteration];
    newY = [get(plotfval,'Ydata') fval];
    set(plotfval,'Xdata',newX, 'Ydata',newY);
    set(get(gca,'Title'),'String',getString(message('MATLAB:funfun:optimplots:TitleCurrentFunctionValue',sprintf('%g',fval))));
end

function plotvector(iteration,fval)
% PLOTVECTOR creates or updates a bar plot of the function values or
% residuals at the current iteration.
if iteration == 0
    xlabelText = getString(message('MATLAB:funfun:optimplots:LabelNumberOfFunctionValues0',sprintf('%g',length(fval))));
    % display up to the first 100 values
    if numel(fval) > 100
        xlabelText = {xlabelText,getString(message('MATLAB:funfun:optimplots:LabelShowingOnlyFirst100Values'))};
        fval = fval(1:100);
    end
    plotfval = bar(fval);
    title(getString(message('MATLAB:funfun:optimplots:TitleCurrentFunctionValues')),'interp','none');
    set(plotfval,'edgecolor','none')
    set(gca,'xlim',[0,1 + length(fval)])
    xlabel(xlabelText,'interp','none')
    set(plotfval,'Tag','optimplotfval');
    ylabel(getString(message('MATLAB:funfun:optimplots:LabelFunctionValue')),'interp','none')
else
    plotfval = findobj(get(gca,'Children'),'Tag','optimplotfval');
    % display up to the first 100 values
    if numel(fval) > 100
        fval = fval(1:100);
    end
    set(plotfval,'Ydata',fval);
end
