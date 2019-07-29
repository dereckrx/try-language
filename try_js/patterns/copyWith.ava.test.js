const test = require('ava');
const {copyWith, copyWithout}= require('./copyWith.js');

test('Array', t => {
  const is = t.deepEqual;
  const array = [1, 2];
  
  is(copyWith(array, 3),
    [1, 2, 3]);
  is(copyWith(array, 3, 4),
    [1, 2, 3, 4]);
  is(copyWith(array, {c: 3}),
    [1, 2, {c: 3}]);
  is(copyWith(array, [3, 4]),
    [1, 2, [3, 4]]);
  is(copyWith(array, [3, 4], [5, 6]),
    [1, 2, [3, 4], [5, 6]]);
  
  is(copyWithout(array, 1),
    [2]);
  is(copyWithout(array, 2),
    [1]);
  is(copyWithout([1, 1, 2, 1], 1),
    [2]);
  
  is(array, [1, 2], 'does not mutate original');
});

test('Object', t => {
  const is = t.deepEqual;
  const object = {a: 1};
  
  is(copyWith(object, {b: 2}),
    {a: 1, b: 2});
  is(copyWith(object, {b: 2, c: 3}),
    {a: 1, b: 2, c: 3});
  is(copyWith(object, {b: 2}, {c: 3}),
    {a: 1, b: 2, c: 3});
  is(copyWith(object, {a: 'a'}),
    {a: 'a'});
  
  is(copyWithout(object, 'a'),
    {});
  is(copyWithout({a: 1, b: 2}, 'b'),
    {a: 1});
  is(copyWithout({a: 1, b: 2, c: 3}, 'a', 'b'),
    {c: 3});
  
  is(object, {a: 1}, 'does not mutate original');
});

test('Strings', t => {
  const is = t.is;
  const string = 'abc';
  
  is(copyWith(string, 'def'),
    'abcdef');
  is(copyWith(string, 'def', 'ghi'),
    'abcdefghi');
  is(copyWith(string, 1),
    'abc1');
  
  is(copyWithout(string, 'a'),
    'bc');
  is(copyWithout(string, 'ab'),
    'c');
  is(copyWithout(string, 'a', 'b'),
    'c');
  is(copyWithout('aaba', 'a'),
    'aba');
  is(copyWithout('aaba', /a/g),
    'b');
  
  is(string, 'abc', 'does not mutate original');
});