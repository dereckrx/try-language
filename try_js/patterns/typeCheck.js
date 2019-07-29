// https://webbjocke.com/javascript-check-data-types/

const type = function () {
  const all = (fn, values) => {
    return values.map((value) =>
      fn(value)
    ).reduce((prev, curr) => prev && curr, true);
  };
  
  return {
    isString: (...values) =>
      all(
        (value) => typeof value === 'string' || value instanceof String,
        values),
    isNumber: (...values) =>
      all(
        (value) => typeof value === 'number' && isFinite(value),
        values),
    isArray: (...values) =>
      all(
        (value) => value && typeof value === 'object' && value.constructor === Array && Array.isArray(value),
        values),
    isFunction: (...values) =>
      all(
        (value) => typeof value === 'function',
        values),
    isObject: (...values) =>
      all(
        (value) => value && typeof value === 'object' && value.constructor === Object,
        values),
    isNullish: (...values) =>
      all(
        (value) => value == null,
        values)
  }
}();

module.exports = type;