function [xg_linear, yg_linear, psi_linear] = sim_linear(t)
    simOut = sim('linear_system', t);
    %set_param('simOut','AlgebraicLoopMsg','none');
    xg_linear = simOut.get('xg_linear');
    yg_linear = simOut.get('yg_linear');
    psi_linear = simOut.get('psi_linear');
end