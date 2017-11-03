function [err] = opt_fun(MF_par,data)

K= data.xdata;
Fx_soll= data.Fx;

Fx= MF52_LongForce_calc(MF_par,K,data.NormalLoad);
% Fx= MF1996_LongForce_calc(MF_par,K/100,data.NormalLoad,data.NominalLoad);

err= sum((Fx_soll-Fx).^2)/length(K);

if data.plot_flag
    axes(data.axes)
    plot(data.xdata,Fx_soll,'r.')
    grid on
    hold on
    plot(K,Fx,'LineWidth',2)
    ylabel('Longitudinal Force Fx (N)');
    xlabel('Slip Ratio ');
    hold off
end

end

