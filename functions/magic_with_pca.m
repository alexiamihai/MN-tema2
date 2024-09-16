## Copyright (C) 2021 Andrei
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} magic_with_pca (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-08

function [train, miu, Y, Vk] = magic_with_pca (train_mat, pcs)
  [m, n] = size (train_mat);

  % initializare train
  train = zeros (m, n);

  % initializare miu
  miu = zeros (1, n);

  % initializare Y
  Y = zeros (m, pcs);

  % initializare Vk
  Vk = zeros (n, pcs);

  % am convertit matricea la double
  train_mat = double(train_mat);
  % am calculat media fiecarei coloane a matricei
  for i = 1 : n
    miu(i) = sum(train_mat(:,i))/m;
  endfor
  % am scazut media din matricea initiala
  train_mat = train_mat - miu;
  % am calculat matricea de covarianta
  cov_matrix = train_mat' * train_mat;
  % am calculat vectorii si valorile proprii ale matricei de covarianta
  [V, S] = eig(cov_matrix);
  % am ordonat descrescator valorile proprii
  [S, i] = sort(diag(S), 'descend');
  % am creat o matrice V formata din vectorii proprii asezati pe coloane
  V = V(:, i);
  % am pastrat doar primele pcs coloane din matricea obtinuta anterior.
  Vk = V(:, 1 : pcs);
  % am creat matricea Y schimband baza matricii initiale
  Y = train_mat * Vk;
  % am calculeaza matricea train care este o aproximatie a matricii initiale
  % folosindu-ma de matricea Vk calculata anterior
  train = Y * Vk';
endfunction
