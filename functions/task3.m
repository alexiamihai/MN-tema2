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
## @deftypefn {} {@var{retval} =} pca_cov (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2021-09-06

function new_X = task3 (photo, pcs)
  [m, n] = size (photo);

  % initializare matrice finala.
  new_X = zeros (m, n);

  % am convertit matricea la double.
  photo = double(photo);
  % am calculat media fiecarui rand al matricii, retinand-o in vectorul q
   q = zeros(m, 1);
  for i = 1 : m
    s = 0;
    for j = 1 : n
      s = s + photo(i, j);
    endfor
    q(i) = s / n;
  endfor
  % am normalizat matricea initiala scazand din ea media fiecarui rand.
  for i = 1 : m
    for j = 1 : n
      photo(i, j) = photo(i, j) - q(i);
    endfor
  endfor
  % am calculat matricea de covarianta.
  Z = (1 / (n - 1)) * photo * photo';
  % am calculat vectorii si valorile proprii ale matricei de covarianta
  [V, S] = eig(Z);
  % am ordonat descrescator valorile proprii
  [S, i] = sort(diag(S), 'descend');
  % am creat matricea V, formata din vectorii proprii
  V = V(:, i);
  % TODO: pastreaza doar primele pcs coloane
  % am pastrat doar primele pcs coloane din V
  W = V(:, 1 : pcs);
  % am creat matricea Y, schimband baza matricii initiale.
  Y = W' * photo;
  % am calculat matricea new_X care este o aproximatie a matricii initiale,
  % adunand media randurilor scazuta anterior
  new_X = W * Y + q;
  % am transformat matricea in uint8 pentru a fi o imagine valida.
  new_X = uint8(new_X);
endfunction
