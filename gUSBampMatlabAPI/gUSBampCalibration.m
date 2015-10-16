function [a b] = gUSBampCalibration(varargin)
% DESCRIPTION: Get Offset and Scaling values for gUSBamp.
%
% Call it with: [offset, scaling] = gUSBampCalibration(ID,verbose)
%
% INPUT:
%   ID...amplifiers serial ID can be retrieved from device top label
%   verbose...display progress information in command line (boolean)
%
% OUTPUT:
%   offset...vector of offset voltages in µV (16x1)
%   scaling...vector of scaling factors (16x1)
%
% NOTE: Values are not stored. Use gUSBampSaveCalibration to store values.
%
% EXAMPLE:
%   verbose = true;
%   ID = 'UA-2006.01.05';
%   [offset, scaling] = gUSBampCalibration(ID,verbose);
%
% Version: 3.12.00, g.tec medical engineering GmbH

[a b] = gUSBampCalibrationp(varargin{:});
