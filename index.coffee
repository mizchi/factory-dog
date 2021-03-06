uuid = require 'node-uuid'
index = 0

randomChar = ->
  n = ~~(Math.random() * 57)
  String.fromCharCode 65+n

randomString = (n = 10) ->
  [1..n]
    .map -> randomChar()
    .join ''

gen = ->

utils =
  unique: uuid
  incr: -> index++
  resetIncr: -> index = 0
  gen: (type, n = 10) ->
    if typeof type is 'string'
      switch type
        when 'number'
          ~~(Math.random() * 100)
        when 'number[]'
          [1..n].map -> ~~(Math.random() * 100)
        when 'string'
          randomString(n)
        when 'string[]'
          [1..n].map -> randomString(n)
        when 'boolean'
          ~~(Math.random() * 100) % 2 is 0
        when 'boolean[]'
          [1..n].map -> ~~(Math.random() * 100) % 2 is 0
        else
          {}
    else
      ret = {}
      for k, v of type
        ret[k] = utils.gen v
      ret

class FactoryDog
  @utils = utils
  @defs = {}
  @define: (name, rule) ->
    @defs[name] = rule

  @build: (name, overrides = {}) ->
    obj = {}
    rule = @defs[name]
    for k, v of rule
      if overrides[k]
        obj[k] = overrides[k]
      else
        if v instanceof Function
          obj[k] = v()
        else if v in ['number', 'string', 'boolean']
          obj[k] = utils.gen v
        else if v instanceof Object
          obj[k] = utils.gen v
        else
          obj[k] = v
    obj

module.exports = FactoryDog
# index = 0
# FactoryDog.define 'user',
#   prop: -> ++index
#   a: 'number'
#   b: 'string'
#   c:
#     d: 'number[]'
#     e: 'boolean'
#
# assert = require 'assert'
# a = FactoryDog.build 'user'
# assert.equal a.prop, 1
# b = FactoryDog.build 'user', prop: 'b'
# assert.equal b.prop, 'b'
#
# console.log a
