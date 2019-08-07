// Based on https://jrsinclair.com/articles/2018/how-to-deal-with-dirty-side-effects-in-your-pure-functional-javascript/

const test = require('ava');

const logger = (() => {
  let messages = [];
  return {
    log: (message) => {
      console.log(message);
      messages.push(message)
    },
    messages: (index) => messages[index],
    clear: () => messages = []
  };
})();

const document = {
  querySelector: (selector) => {
    logger.log(selector);
    return {
      '.userbio': '<div>User Biography</div>',
      '#articles': '<div>Articles</div>',
      '.userfullname': '<div>Foo Bar</div>'
    }[selector];
  }
};

const config = {
  selectors: {
    'user-bio': '.userbio',
    'article-list': '#articles',
    'user-name': '.userfullname',
  },
  templates: {
    'greet': 'Pleased to meet you, {name}',
    'notify': 'You have {n} alerts',
  }
};

// Effect :: Function -> Effect
function Effect(f) {
  return {
    map(g) {
      return Effect(x => g(f(x)));
    },
    // use join to un-nest Effects
    join(x) {
      return f(x);
    },
    // use runEffects to actually run effects
    runEffects(x) {
      return f(x);
    }
  }
}

// Like the jQuery $() only pure
// querySelector :: String -> Effect DOMElement
function querySelector(selector) {
  return Effect.of(document.querySelector(selector));
}

// zero :: () -> Number
function fZero() {
  logger.log('This is an impure effect');
  return 0;
}

test('runEffects', t => {
  const zero = Effect(fZero);
  t.is(zero.runEffects(), 0);
});


test('map effects', t => {
  const zero = Effect(fZero);
  const increment = x => x + 1; // Just a regular function.
  const one = zero.map(increment);
  t.is(one.runEffects(), 1);
});

test('map more effects', t => {
  const double = x => x * 2;
  const cube = x => Math.pow(x, 3);
  const increment = x => x + 1; // Just a regular function.
  const eight = Effect(fZero)
    .map(increment)
    .map(double)
    .map(cube);
  
  t.is(eight.runEffects(), 8);
  
  const incDoubleCube = x => cube(double(increment(x)));
  // const incDoubleCube = compose(cube, double, increment);
  const eightComposed = Effect(fZero).map(incDoubleCube);
  
  t.is(eight.runEffects(), 8);
});

// Shortcut for making effects
// of :: a -> Effect a
Effect.of = function of(val) {
  return Effect(() => val);
};

test('Effect.of stores a impure effector', t => {
  logger.clear();
  const logEffect = Effect.of(logger);
  
  const val = logEffect.runEffects();
  
  t.is(val, logger);
});

test('Effect.of can use effector by mapping', t => {
  logger.clear();
  const logEffect = Effect.of(logger);
  
  logEffect
    .map((log) => log.log('Hello effector!'))
    .runEffects();
  
  t.is(logger.messages(0), 'Hello effector!');
});


test('nested effect', t => {
  logger.clear();
  const nested = Effect(() => Effect(() => document.querySelector(config.selectors['user-bio'])));
  const nested2 = Effect.of(config)
    .map((c) => c.selectors['article-list'])
    .map(querySelector); // nested effect
  
  // Bad, you have to unwrap and then call runEffects again
  const bio = nested.runEffects().runEffects();
  t.is(bio, '<div>User Biography</div>');
  
  // Same thing, still bad
  logger.clear();
  const article = nested2.runEffects().runEffects();
  t.is(article, '<div>Articles</div>');
});

test('join to unwrap effects without running them', t => {
  logger.clear();
  const nested = Effect.of(config)
    .map((c) => c.selectors['user-bio'])
    .map(querySelector) // nested effect
    .join();
  
  const bio = nested.runEffects();
  t.is(bio, '<div>User Biography</div>');
});