const {describe, ex, eq}= require('./test.js');
const {copyWith, copyWithout} = require('./copyWith.js');

describe('Array', () => {
  const array = [1, 2];
  
  eq(copyWith(array, 3),
    [1, 2, 3]);
  eq(copyWith(array, 3, 4),
    [1, 2, 3, 4]);
  eq(copyWith(array, {c: 3}),
    [1, 2, {c: 3}]);
  eq(copyWith(array, [3, 4]),
    [1, 2, [3, 4]]);
  eq(copyWith(array, [3, 4], [5, 6]),
    [1, 2, [3, 4], [5, 6]]);
  
  eq(copyWithout(array, 1),
    [2]);
  eq(copyWithout(array, 2),
    [1]);
  eq(copyWithout([1, 1, 2, 1], 1),
    [2]);
  
  ex('does not mutate original', array, [1, 2]);
});

describe('Object', () => {
  const object = {a: 1};
  
  eq(copyWith(object, {b: 2}),
    {a: 1, b: 2});
  eq(copyWith(object, {b: 2, c: 3}),
    {a: 1, b: 2, c: 3});
  eq(copyWith(object, {b: 2}, {c: 3}),
    {a: 1, b: 2, c: 3});
  eq(copyWith(object, {a: 'a'}),
    {a: 'a'});
  
  eq(copyWithout(object, 'a'),
    {});
  eq(copyWithout({a: 1, b: 2}, 'b'),
    {a: 1});
  eq(copyWithout({a: 1, b: 2, c: 3}, 'a', 'b'),
    {c: 3});
  
  ex('does not mutate original', object, {a: 1});
});

describe('Strings', () => {
  const string = 'abc';
  
  eq(copyWith(string, 'def'),
    'abcdef');
  eq(copyWith(string, 'def', 'ghi'),
    'abcdefghi');
  eq(copyWith(string, 1),
    'abc1');

  
  eq(copyWithout(string, 'a'),
    'bc');
  eq(copyWithout(string, 'ab'),
    'c');
  eq(copyWithout(string, 'a', 'b'),
    'c');
  eq(copyWithout('aaba', 'a'),
    'aba');
  eq(copyWithout('aaba', /a/g),
    'b');
  
  ex('does not mutate original', string, 'abc');
});