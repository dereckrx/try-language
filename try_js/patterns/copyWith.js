const {isEqual}= require('./test.js');
const type = require('./typeCheck.js');

// Non-mutating operations on data structures

// Adds values to the collection
function copyWith(col, ...additions) {
  return additions.reduce(adderFor(col), col);
}

// Removes all occurrences of the values from the collection
function copyWithout(col, ...removals) {
  return removals.reduce(removerFor(col), col);
}

const adders = {
  array: (col, value) => [...col, value],
  string: (col, value) => col + value,
  object: (col, value) => {return {...col, ...value}}
};

function adderFor(col) {
  if (type.isArray(col)) {
    return adders.array;
  } else if (type.isString(col)) {
    return adders.string;
  } else {
    return adders.object;
  }
}

const removers = {
  array: (col, value) => col.filter((item) => !isEqual(item, value)),
  string: (col, value) => col.replace(value, ''),
  object: (col, value) => {
    const {[value]: _, ...rest} = col;
    return rest;
  }
};

function removerFor(col) {
  if (type.isArray(col)) {
    return removers.array;
  } else if (type.isString(col)) {
    return removers.string;
  } else {
    return removers.object;
  }
}

module.exports = {
  copyWith,
  copyWithout
};