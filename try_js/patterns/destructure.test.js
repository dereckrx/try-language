const test = require('ava');

test('destruct object', t => {
  const point = {
    x: 1,
    y: 2,
  };
  
  const {x, y} = point;
  t.is(x, 1);
  t.is(y, 2);
  
  const {c, ...rest} = {a: 10, b: 20, c: 30, d: 40};
  t.is(c, 30);
  t.deepEqual(rest, {a: 10, b: 20, d: 40});
});

test('destruct object with new variable names', t => {
  const {b: foo, d: bar} = {a: 10, b: 20, c: 30, d: 40};
  t.is(foo, 20);
  t.is(bar, 40);
});

test('destruct object with defaults', t => {
  const {a = 10, b = 5} = {a: 10};
  t.is(a, 10);
  t.is(b, 5);
});

test('destruct object with nested objects', t => {
  const user = {
    id: 42,
    displayName: 'jdoe',
    fullName: {
      firstName: 'John',
      lastName: 'Doe'
    }
  };
  const {displayName, fullName: {firstName: name}} = user;
  t.is(displayName, 'jdoe');
  t.is(name, 'John');
});

test('destruct arrays', t => {
  const is = t.deepEqual;
  
  const [a, b] = [0, 1];
  is(a, 0);
  is(b, 1);
  
  const [head, ...tail] = [0, 1, 2, 3];
  is(head, 0);
  is(tail, [1, 2, 3]);
});

test('destruct array with defaults', t => {
  const [d = 5, f = 7] = [0];
  t.is(d, 0);
  t.is(f, 7);
});
  
test('ignoring values', t => {
  const [, , g] = [0, 1, 2, 3];
  t.is(g, 2);
});


test('destructure function params', t => {
  function doubleSpeak({dogSound, catSound}) {
    return [dogSound + dogSound, catSound + catSound]
  }
  
  const [dog, cat] = doubleSpeak({dogSound: 'woof', catSound: 'meow'});
  t.is(dog, 'woofwoof');
  t.is(cat, 'meowmeow');
});
