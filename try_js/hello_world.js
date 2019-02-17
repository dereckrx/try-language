// node hello_world.js
// IntelliJ Setup:
// * Web Module is basic, but must be configured to use ES6

const expect = (result) => {
  const toEqual = (expected) => {
    if (result === expected) {
      console.log('Pass');
    } else {
      console.log(`Fail: expected ${result} to equal ${expected}`);
    }
  };
  return { toEqual };
};

const it = (name, test) => test();

it('passes if equal', () => expect(1).toEqual(1));

it('fails if not equal', () => expect(1).toEqual(2));
