
module.exports = {
  "env": {
    "browser": true,
    "es6": true,
    "node": true
  },
  "extends": "airbnb",
  "globals": {
    "Atomics": "readonly",
    "SharedArrayBuffer": "readonly"
  },
  "parserOptions": {
    "ecmaVersion": 6,
    "sourceType": "module",
    "ecmaFeatures": {
      "jsx": true
    }
  },
  "plugins": [
    "react",
    "no-null"
  ],
  "rules": {
    "no-null/no-null": 2,
    "semi": "always" // Require semicolons
  }
};