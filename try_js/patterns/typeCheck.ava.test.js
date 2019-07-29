const test = require('ava');
const type = require('./typeCheck.js');

test('Arrays', t => {
  t.true(type.isArray([1, 2, 3]));
  t.true(type.isArray(new Array(1, 2, 3)));
});
  
test('Strings', t => {
  t.true(type.isString('foo'));
  t.true(type.isString(new String('foo')));
});

test('Numbers', t => {
  t.true(type.isNumber(1));
  t.false(type.isNumber(NaN));
  t.false(type.isNumber(Infinity));
});

test('Objects', t => {
  t.true(type.isObject({}));
  t.true(type.isObject(new Object()));
  t.true(type.isObject({a: 1}));
});

test('Functions', t => {
  t.true(type.isFunction(() => null));
  t.true(type.isFunction(function () {}));
});

test('Nullish', t => {
  t.true(type.isNullish(null));
  t.true(type.isNullish(undefined));
});
