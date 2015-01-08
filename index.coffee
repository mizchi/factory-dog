uuid = require 'node-uuid'
index = 0

randomChar = ->
  n = ~~(Math.random() * 57)
  String.fromCharCode 65+n

randomString = (n = 10) ->
  [1..n]
    .map -> randomChar()
    .join ''

utils =
  unique: uuid
  incr: -> index++
  resetIncr: -> index = 0
  gen: (type) ->
    switch type
      when 'number'
        ~~(Math.random() * 100)
      when 'string'
        randomString()
      when 'boolean'
        ~~(Math.random() * 100) % 2 is 0
      else
        {}

class FactoryBoy
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
        else
          obj[k] = v
    obj

module.exports = FactoryBoy
# index = 0
# FactoryBoy.define 'user', {
  # prop: -> ++index
  # a: 'number'
  # b: 'string'
# }

# assert = require 'assert'
# a = FactoryBoy.build 'user'
# assert.equal a.prop, 1
# b = FactoryBoy.build 'user', prop: 'b'
# assert.equal b.prop, 'b'

# console.log a
