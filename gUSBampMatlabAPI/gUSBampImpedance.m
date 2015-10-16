function [a] = gUSBampImpedance(varargin)
% DESCRIPTION: Measure the electrode impedances connected to gUSBamp.
%
% Call it with: impedance = gUSBampImpedance(ID,verbose)
%
% INPUT:
%   ID...amplifiers serial ID can be retrieved from device top label
%   verbose...display progress information in command line (boolean)
%
% OUTPUT:
%   impedance...vector of impedances
%
% NOTE: impedance(1:16) are the impedance values for channels 1 to 16
% impedance(17:20) are the impedance values for references A, B, C, D
%
% EXAMPLE:
%   verbose = true;
%   ID = 'UA-2006.01.05';
%   impedance = gUSBampImpedance(ID,verbose);
%
% Version: 3.12.00, g.tec medical engineering GmbH

[a] = gUSBampImpedancep(varargin{:});
