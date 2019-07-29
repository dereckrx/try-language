const test = require('ava');

const add1 = (item) => item + 1;
const add2 = (item) => { return item + 2 };
function add3(item) { return item + 3; }

test('functions', t => {
  t.is(add1(1), 2);
  t.is(add2(1), 3);
  t.is(add3(1), 4);
});

test('Passing functions', t => {
  t.deepEqual(
    [0, 1, 2, 3, 4].map(add1),
    [1, 2, 3, 4, 5]);
});


