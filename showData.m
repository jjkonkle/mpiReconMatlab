% This program loads and displays partial FOV MPI Data
% Copyright (C) 2015  Justin J. Konkle
%
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; version 2
% of the License.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software
% Foundation, Inc., 51 Franklin Street, Fifth Floor, 
% Boston, MA  02110-1301, USA.


clearvars; close all;

datasets = {'2014-05-01_16-47_DoubleHelix'; '2014-04-28_16-07_coronariesClear'}

for d = 1:length(datasets)

    % Load Double Helix PFOV data
    info = load(['OptReconPaperData/', datasets{d}, '/meta_', datasets{d}], 'in');
    in = info.in;
    frame3D = cell(in.frame3DLength,1);
    for i = 1:in.frame3DLength
        currentFrame = load(['OptReconPaperData/', datasets{d}, '/', datasets{d}, num2str(i)],'tempFrame');
        frame3D{i} = currentFrame.tempFrame;
    end

    % Show images of data
    figure;
    width = 8;
    height = ceil(in.frame3DLength/width);
    for i = 1:in.frame3DLength
        subplot(height, width, i);
        imagesc(max(frame3D{i}, [], 3));
        colormap gray;
        axis off;
    end

    % eventually we hope to post the full image reconstruction code, which we
    % could run with:
    % imRec = DC.rec3D(frame3D, in.pFovShiftPixels, in.lambdaIm, in.lambdaDiff, in.solver, ...
    %    in.zigZag, in.debug, in.dsFactor, in.matrixFree, in.fixEnds);
    % displayMip(imRec, in.xFov, in.yFov, in.zFov, 2, 1)
end 

