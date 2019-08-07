const test = require('ava');

test.beforeEach(t => {
  t.context.unicorn = 'unicorn';
});

test('text context has unicorn', t => {
  t.is(t.context.unicorn, 'unicorn');
});

test('built-in assertions', t => {
  const value = 1;
  const expected = 1;
  
  t.is(value, expected, 'Assert that value is the same as expected.');
  t.not(value, expected, 'Assert that value is not the same as expected.');
  
  t.deepEqual(value, expected, 'Assert that value is deeply equal to expected.');
  t.notDeepEqual(value, expected, 'Assert that value is not deeply equal to expected.');
  
  t.pass('Passing assertion');
  t.fail('Failing assertion');
  
  t.assert(value, 'Asserts that value is truthy.');
  
  t.truthy(value, 'Assert that value is truthy.');
  t.falsy(value, 'Assert that value is falsy.');
  
  t.true(value, 'Assert that value is true.');
  t.false(value, 'Assert that value is false.');
  
  const contents = 'hello world';
  const regex = /hello/;
  
  t.regex(contents, regex, 'Assert that contents matches regex.');
  t.notRegex(contents, regex, 'Assert that contents does not match regex.');
  
  t.snapshot(expected, 'Compares the expected value with a previously recorded snapshot.');
  t.snapshot(expected, [options], 'Alternatively pass an options object to select a specific snapshot, for instance {id: \'my snapshot\'}.');
  
  // t.throws(fn)
  const fnThrows = () => throw new TypeError('BOOM!');
  const expectedError = TypeError;
  
  const error = t.throws(fnThrows, expectedError, 'Assert that an error is thrown.');
  t.is(error.message, 'BOOM!');
  
  // t.notThrows(fn)
  const fn = () => void;
  t.notThrows(fn, 'Assert that no error is thrown.');
  
  // t.throwsAsync(asyncFn)
  const asyncFnThrows = async () => throw new TypeError('BOOM!');
  const asyncThrow = async () => {
    const error = await t.throwsAsync(asyncFnThrows, expectedError, 'Assert that an error is thrown.');
    const error2 = await t.throwsAsync(asyncFnThrows, {instanceOf: TypeError, message: 'BOOM!'});
  };
  
  // t.throwsAsync(asyncFn)
  const rejects = async t => {
    const rejectPromise = Promise.reject(new TypeError('BOOM!'));
    const error = await t.throwsAsync(rejectPromise);
    t.is(error.message, 'BOOM!');
  };
  
  // t.notThrowsAsync(asyncFn)
  const resolvedPromise = () => Promise.resolve();
  t.notThrowsAsync(
    resolvedPromise,
    'Assert that no error is thrown. or a promise that should resolve.'
  ).then();
  
  const asyncNoThrow = async t => {
    const nonThrower = async () => null;
    await t.notThrowsAsync(nonThrower);
  };
});