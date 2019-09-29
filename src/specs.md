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

```act
behaviour totalSupply of ZRXToken
interface totalSupply()

iff
  VCallValue == 0

returns 1000000000000000000000000000
```

```act
behaviour balanceOf of ZRXToken
interface balanceOf(address _owner)

types
  Balance : uint256

storage
  balances[_owner] |-> Balance

iff
  VCallValue == 0

returns Balance
```

```act
behaviour approve of ZRXToken
interface approve(address _spender, uint _value)

storage
  allowed[CALLER_ID][_spender] |-> _ => _value

iff
  VCallValue == 0

returns 1
```

```act
behaviour allowance of ZRXToken
interface allowance(address _owner, address _spender)

types
  Allowance : uint256

storage
  allowed[_owner][_spender] |-> Allowance

iff
  VCallValue == 0

returns Allowance
```

```act
behaviour transfer-true-distinct of ZRXToken
interface transfer(address _to, uint _value)

types
  CallerBalance : uint
  ToBalance : uint

storage
  balances[CALLER_ID] |-> CallerBalance => CallerBalance - _value
  balances[_to] |-> ToBalance => ToBalance + _value

iff
  VCallValue == 0

if
  CALLER_ID =/= _to
  CallerBalance >= _value
  ToBalance + _value <= maxUInt256

returns 1
```

```act
behaviour transfer-true-same of ZRXToken
interface transfer(address _to, uint _value)

types
  Balance : uint

storage
  balances[CALLER_ID] |-> Balance => Balance

iff
  VCallValue == 0

if
  CALLER_ID == _to
  Balance >= _value
  Balance + _value <= maxUInt256

returns 1
```

```act
behaviour transfer-false-distinct of ZRXToken
interface transfer(address _to, uint _value)

types
  CallerBalance : uint
  ToBalance : uint

storage
  balances[CALLER_ID] |-> CallerBalance
  balances[_to] |-> ToBalance

iff
  VCallValue == 0

if
  CALLER_ID =/= _to
  (CallerBalance < _value) or (ToBalance + _value > maxUInt256)

returns 0
```

```act
behaviour transfer-false-same of ZRXToken
interface transfer(address _to, uint _value)

types
  Balance : uint

storage
  balances[CALLER_ID] |-> Balance

iff
  VCallValue == 0

if
  CALLER_ID == _to
  (Balance < _value) or (Balance + _value > maxUInt256)

returns 0
```

```act
behaviour transferFrom-true-distinct of ZRXToken
interface transferFrom(address _from, address _to, uint _value)

types
  Allowance : uint256
  FromBalance : uint256
  ToBalance : uint256

storage
  allowed[_from][CALLER_ID] |-> Allowance => (#if Allowance == maxUInt256 #then Allowance #else Allowance - _value #fi)
  balances[_from] |-> FromBalance => FromBalance - _value
  balances[_to] |-> ToBalance => ToBalance + _value

iff
  VCallValue == 0

if
  _from =/= _to
  FromBalance >= _value
  Allowance >= _value
  ToBalance + _value <= maxUInt256

returns 1
```

```act
behaviour transferFrom-true-same of ZRXToken
interface transferFrom(address _from, address _to, uint _value)

types
  Allowance : uint256
  Balance : uint256

storage
  allowed[_from][CALLER_ID] |-> Allowance => (#if Allowance == maxUInt256 #then Allowance #else Allowance - _value #fi)
  balances[_from] |-> Balance => Balance

iff
  VCallValue == 0

if
  _from == _to
  Balance >= _value
  Allowance >= _value
  Balance + _value <= maxUInt256

returns 1
```

```act
behaviour transferFrom-false-distinct of ZRXToken
interface transferFrom(address _from, address _to, uint _value)

types
  Allowance : uint256
  FromBalance : uint256
  ToBalance : uint256

storage
  allowed[_from][CALLER_ID] |-> Allowance
  balances[_from] |-> FromBalance
  balances[_to] |-> ToBalance

iff
  VCallValue == 0

if
  _from =/= _to
  (FromBalance < _value) or (Allowance < _value) or (ToBalance + _value > maxUInt256)

returns 0
```

```act
behaviour transferFrom-false-same of ZRXToken
interface transferFrom(address _from, address _to, uint _value)

types
  Allowance : uint256
  Balance : uint256

storage
  allowed[_from][CALLER_ID] |-> Allowance
  balances[_from] |-> Balance

iff
  VCallValue == 0

if
  _from == _to
  (Balance < _value) or (Allowance < _value) or (Balance + _value > maxUInt256)

returns 0
```
