// Generated by CoffeeScript 1.8.0
(function() {
  var FactoryDog, gen, index, randomChar, randomString, utils, uuid;

  uuid = require('node-uuid');

  index = 0;

  randomChar = function() {
    var n;
    n = ~~(Math.random() * 57);
    return String.fromCharCode(65 + n);
  };

  randomString = function(n) {
    var _i, _results;
    if (n == null) {
      n = 10;
    }
    return (function() {
      _results = [];
      for (var _i = 1; 1 <= n ? _i <= n : _i >= n; 1 <= n ? _i++ : _i--){ _results.push(_i); }
      return _results;
    }).apply(this).map(function() {
      return randomChar();
    }).join('');
  };

  gen = function() {};

  utils = {
    unique: uuid,
    incr: function() {
      return index++;
    },
    resetIncr: function() {
      return index = 0;
    },
    gen: function(type, n) {
      var k, ret, v, _i, _j, _k, _results, _results1, _results2;
      if (n == null) {
        n = 10;
      }
      if (typeof type === 'string') {
        switch (type) {
          case 'number':
            return ~~(Math.random() * 100);
          case 'number[]':
            return (function() {
              _results = [];
              for (var _i = 1; 1 <= n ? _i <= n : _i >= n; 1 <= n ? _i++ : _i--){ _results.push(_i); }
              return _results;
            }).apply(this).map(function() {
              return ~~(Math.random() * 100);
            });
          case 'string':
            return randomString(n);
          case 'string[]':
            return (function() {
              _results1 = [];
              for (var _j = 1; 1 <= n ? _j <= n : _j >= n; 1 <= n ? _j++ : _j--){ _results1.push(_j); }
              return _results1;
            }).apply(this).map(function() {
              return randomString(n);
            });
          case 'boolean':
            return ~~(Math.random() * 100) % 2 === 0;
          case 'boolean[]':
            return (function() {
              _results2 = [];
              for (var _k = 1; 1 <= n ? _k <= n : _k >= n; 1 <= n ? _k++ : _k--){ _results2.push(_k); }
              return _results2;
            }).apply(this).map(function() {
              return ~~(Math.random() * 100) % 2 === 0;
            });
          default:
            return {};
        }
      } else {
        ret = {};
        for (k in type) {
          v = type[k];
          ret[k] = utils.gen(v);
        }
        return ret;
      }
    }
  };

  FactoryDog = (function() {
    function FactoryDog() {}

    FactoryDog.utils = utils;

    FactoryDog.defs = {};

    FactoryDog.define = function(name, rule) {
      return this.defs[name] = rule;
    };

    FactoryDog.build = function(name, overrides) {
      var k, obj, rule, v;
      if (overrides == null) {
        overrides = {};
      }
      obj = {};
      rule = this.defs[name];
      for (k in rule) {
        v = rule[k];
        if (overrides[k]) {
          obj[k] = overrides[k];
        } else {
          if (v instanceof Function) {
            obj[k] = v();
          } else if (v === 'number' || v === 'string' || v === 'boolean') {
            obj[k] = utils.gen(v);
          } else if (v instanceof Object) {
            obj[k] = utils.gen(v);
          } else {
            obj[k] = v;
          }
        }
      }
      return obj;
    };

    return FactoryDog;

  })();

  module.exports = FactoryDog;

}).call(this);
