#!/usr/bin/env node

vowel_strings(2);

function vowel_strings(max_len, str = '') {
  if (str.length === max_len) {
    console.log(str);
    return;
  }
  var next = [];
  var last = '';

  if (str.length > 0) {
    last = str.substring(-1, 1);
  }

  if (str === '') {
    next = ['a', 'e', 'i', 'o', 'u'];
  } else if (last === 'a') {
    next = ['e', 'i'];
  } else if (last === 'e') {
    next = ['i'];
  } else if (last === 'i') {
    next = ['a', 'e', 'o', 'u'];
  } else if (last === 'o') {
    next = ['a', 'u'];
  } else if (last === 'u') {
    next = ['e', 'o'];
  }

  const iter = next.values();
  for (const i of iter) {
    vowel_strings(max_len, str + i);
  }
}
