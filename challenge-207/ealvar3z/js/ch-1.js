#!/usr/bin/node

const assert = require("assert");

// Tests

const test_one = ["Hello", "Alaska", "Dad", "Peace"];
const test_two = ["OMG", "Bye"];

const _1 = test_one.filter(task_one);
const _2 = test_two.filter(task_one);

console.log(_1);
console.log(_2);

assert.deepStrictEqual(_1, ["Alaska", "Dad"]);
assert.deepStrictEqual(_2, []);

// Implementation

const q = /[qwertyuiop]+/i;
const a = /[asdfghjkl]+/i;
const z = /[zxcvbnm]+/i;

function task_one(w) {
    const compile = `^(${q.source}|${a.source}|${z.source})$`;
    const re = new RegExp(compile, "i");
    return re.test(w);
}


