classdef FeedbackControl < SimObject
    properties
        system
        control
    end
    methods
        function obj = FeedbackControl(system, control, interval, name)
            arguments
                system
                control
                interval = -1;
                name = [];
            end
            obj = obj@SimObject(interval, name);
            obj.system = system;
            obj.control = control;

            obj.addSimObjs({system, control});
        end
    end
    methods(Access=protected)
        % implement
        function out = forward_(obj, varargin)
            x = obj.system.state();
            if isnumeric(x)
                u_fb = obj.control.forward(x, varargin{:});
            elseif iscell(x)
                u_fb = obj.control.forward(x{:}, varargin{:});
            else
                error('ValueError')
            end
            out = obj.system.forward(u_fb);
        end
    end
end