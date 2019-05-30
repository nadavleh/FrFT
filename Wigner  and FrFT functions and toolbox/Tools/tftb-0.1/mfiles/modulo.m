function y=modulo(x,N);
%MODULO	Congruence of a vector.
%	Y=MODULO(X,N) gives the congruence of each element of the
%	vector X modulo N. These values are strictly positive and 
%	lower equal than N.
%
%	See also REM.

%	O. Lemoine - February 1996.
%	Copyright (c) 1996 by CNRS (France).
%
%  This program is free software; you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation; either version 2 of the License, or
%  (at your option) any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License
%  along with this program; if not, write to the Free Software
%  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

L=length(x);

for l=1:L,
  if rem(x(l),N)==0,
    y(l)=N;
  elseif rem(x(l),N)<0,
    y(l)=rem(x(l),N)+N;
  else
    y(l)=rem(x(l),N);
  end
end
