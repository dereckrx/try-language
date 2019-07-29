const fetch = require('node-fetch');

function callbackFetch(url, callback) {
  fetch(url)
    .then(result => callback(undefined, result))
    .catch(err => callback(err, undefined));
}

function fetchWithCallback(url) {
  callbackFetch(url, function (err, result) {
    if (err) {
      console.log('ERROR: fetchWithCallback: ', err);
    } else {
      console.log('fetchWithCallback: ', result.status);
    }
  });
}

function fetchWithPromise(url) {
  fetch(url).then(function (result) {
    console.log('fetchWithPromise: ', result.status);
  }).catch(function (err) {
    console.log('ERROR: fetchWithPromise: ', err);
  });
}

async function fetchWithAwait(url) {
  try {
    const result = await fetch(url);
    console.log('fetchWithAwait: ', result.status);
  } catch (err) {
    console.log('ERROR: fetchWithAwait: ', err);
  }
}

const URL = 'https://google.com';

fetchWithCallback(URL);
fetchWithPromise(URL);
fetchWithAwait(URL).then(() => console.log('Done'));
