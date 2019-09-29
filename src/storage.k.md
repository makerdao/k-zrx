Copyright (C) 2019 Maker Ecosystem Growth Holdings, INC.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published
by the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

```k
syntax Int ::= "#ZRXToken.balances" "[" Int "]" [function]
rule #ZRXToken.balances[A] => #hashedLocation("Solidity", 0, A)
```

```k
syntax Int ::= "#ZRXToken.allowed" "[" Int "][" Int "]" [function]
rule #ZRXToken.allowed[A][B] => #hashedLocation("Solidity", 1, A B)
```
