## Copyright (C) 2023 Andrei
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
## @deftypefn {} {@var{retval} =} task2 (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: Andrei <Andrei@DESKTOP-PK505U9>
## Created: 2023-02-28

function new_X = task2 (photo, pcs)
  [m n] = size(photo);

  % initializare matrice finala.
  new_X = zeros(m, n);

  % am convertit matricea la double.
  photo = double(photo);
  % am normalizat matricea initiala scazand din ea media fiecarui rand
  % q este vectorul in care voi retine mediile calculate
  % am calculat mai intai mediile
  q = zeros(m, 1);
  for i = 1 : m
    s = 0;
    for j = 1 : n
      s = s + photo(i, j);
    endfor
    q(i) = s / n;
  endfor
  % si apoi le-am scazur din matricea initiala
  for i = 1 : m
    for j = 1 : n
      photo(i, j) = photo(i, j) - q(i);
    endfor
  endfor
  % am construit matricea Z, dupa formula data
  Z = (1 / sqrt(n - 1)) * photo';
  % am calculat matricele U, S si V din SVD aplicat matricei Z
   [U, S, V] = svd(Z);
  % am construit matricea W din primele pcs coloane ale lui V
  W = V(:, 1 : pcs);
  % am caclulat matricea Y, dupa formula data
  Y = W' * photo;
  % am aproximat matricea initiala
  new_X = W * Y + q;
  % am transformat matricea in uint8 pentru a fi o imagine valida.
  new_X = uint8(new_X);
endfunction
