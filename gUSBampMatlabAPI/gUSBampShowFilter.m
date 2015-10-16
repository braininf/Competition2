function gUSBampShowFilter(varargin)
% DESCRIPTION: Show possible bandpass and notch filters for a
% specific sampling frequency.
% Possible sampling frequencies are: 
% 32, 64, 128, 256, 512, 600, 1200, 2400, 4800, 9600, 19200, 38400
%
% Call it with: gUSBampShowFilter(samplingfrequency)
%
% INPUT:
%   samplingfrequency...specify the sampling rate
%
% EXAMPLE:
%   gUSBampShowFilter(256);
%
%Version: 3.12.00, g.tec medical engineering GmbH
gUSBampShowFilterp(varargin{:});
