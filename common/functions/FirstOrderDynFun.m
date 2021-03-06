classdef FirstOrderDynFun < LinearDynFun
    properties
        tau
    end
    methods
        function obj = FirstOrderDynFun(tau)
            A = -1/tau;
            B = 1/tau;
            obj = obj@LinearDynFun(A, B);
            obj.tau = tau;
        end
        
        % override
        function out = forward(obj, x, u)
            assert(isscalar(x), 'The dimension of the state should be 1.')
            assert(isscalar(u), 'The dimension of the input should be 1.')
            out = forward@LinearDynFun(obj, x, u);
        end
    end
    
    methods(Static)
        function test()
            fprintf('== Test for FirstOrderDynFun == \n')
            tau = 1;
            system = DynSystem(0, FirstOrderDynFun(tau));
            simulator = Simulator(system);
            
            u_step = 1;
            simulator.propagate(0.01, 10, true, u_step);
            
            [timeList, stateList, inputList] = system.history{:};
            figure();
            hold on
            plot(timeList, inputList, '-', 'DisplayName', 'Reference')
            plot(timeList, stateList, '--', 'DisplayName', 'Actual')
            xlabel('Time')
            ylabel('Value')
            grid on
            box on
            legend()
        end
    end
end      