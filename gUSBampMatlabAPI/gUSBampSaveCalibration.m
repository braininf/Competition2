function gUSBampSaveCalibration(varargin)
% DESCRIPTION: Store Offset and Scaling values for gUSBamp.
%
% Call it with: gUSBampSaveCalibration(offset,scaling,ID)
%
% INPUT:
%   offset...offset voltages in uV (16x1)
%   scaling...scaling factors (16x1)
%   ID...amplifiers serial ID can be retrieved from device top label (string)
%
% EXAMPLE:
%   offset = zeros(16,1);
%   scaling = ones(16,1);
%   ID = 'UA-2006.01.05';
%   gUSBampSaveCalibration(offset,scaling,ID);
%
% Version: 3.12.00, g.tec medical engineering GmbH

gUSBampAPICalibration(2,varargin{3},varargin{2},varargin{1});
