# FactoryDog

```
npm install factory-dog
```

## How to use

```coffee
index = 0
FactoryDog.define 'user',
  prop: -> ++index
  a: 'number'
  b: 'string'
  c:
    d: 'number[]'
    e: 'boolean'

assert = require 'assert'
a = FactoryDog.build 'user'
assert.equal a.prop, 1
b = FactoryDog.build 'user', prop: 'b'
assert.equal b.prop, 'b'

console.log a
###
{ prop: 1,
a: 29,
b: 'uYO_aVHryj',
c: { d: [ 25, 75, 89, 99, 26, 89, 3, 62, 94, 47 ], e: true } }
###
```  
