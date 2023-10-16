"use strict";

function runningSum(array) {
    const sum = [];
    sum[0] = array[0];
    for (let i = 1; i < array.length; i++) {
        sum[i] = array[i] + sum[i - 1];
    }
    return sum;
}

const assert = require('assert');

const testCases = [
    { input: [1, 2, 3, 4, 5], want: [1, 3, 6, 10, 15] },
    { input: [1, 1, 1, 1, 1], want: [1, 2, 3, 4, 5] },
    { input: [0, -1, 1, 2], want: [0, -1, 0, 2] },
];

testCases.forEach((testCase, index) => {
    const { input, want } = testCase;
    const got = runningSum(input);
    assert.deepStrictEqual(got, want, `Test [${input}]`);
});

console.log('All tests passed.');
