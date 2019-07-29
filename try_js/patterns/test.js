function log(...messages) {
  console.log(...messages);
}

function it(name, testFn) {
  log(name, '\n=> ', testFn())
}

function assertEqual(expected, actual) {
  return isEqual(actual, expected)
    ? 'Pass'
    : `FAIL: ${jstring(actual)} does not equal ${jstring(expected)}`;
}

function eq(actual, expected) {
  log(assertEqual(expected, actual), '-', `${jstring(actual)} == ${jstring(expected)}`);
}

function ex(name, actual, expected) {
  it(name, () => assertEqual(expected, actual))
}

function describe(name, fn) {
  log('\n___', name, '___');
  fn();
}

function isEqual(obj1, obj2) {
  return jstring(obj1) === jstring(obj2);
}

function jstring(string) {
  return JSON.stringify(string);
}

const is = eq;

module.exports = {
  log,
  it,
  assertEqual,
  eq,
  ex,
  describe,
  isEqual,
  is
};