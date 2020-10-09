function [xg_non_linear, yg_non_linear, psi_non_linear] = sim_non_linear(t)
    simOut = sim('nonlinear_system_angelo', t);
    %set_param('simOut','AlgebraicLoopMsg','none');
    xg_non_linear = simOut.get('xg_non_linear');
    yg_non_linear = simOut.get('yg_non_linear');
    psi_non_linear = simOut.get('psi_non_linear');
end