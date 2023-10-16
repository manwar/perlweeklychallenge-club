"use strict";  // make the browsers happy.

const digitWeight = {};

function calculateDigitWeight(num) {
    if (digitWeight[num] !== undefined) {
        return digitWeight[num];
    }

    if (num < 0) {
        throw new Error(`Not expecting a negative number (${num})`);
    }

    let n = num;
    let count = 0;

    while (n > 9) {
        count++;
        const digits = n.toString().split('').map(Number);
        n = digits.pop();
        while (digits.length > 0) {
            n *= digits.pop();
        }
    }

    digitWeight[num] = count;
    return count;
}

function persistenceSort(array) {
    return array.sort((a, b) => {
        const weightA = calculateDigitWeight(a);
        const weightB = calculateDigitWeight(b);

        if (weightA !== weightB) {
            return weightA - weightB;
        } else {
            return a - b;
        }
    });
}

const assert = require('assert');

const testCases = [
    { input: [15, 99, 1, 34], want: [1, 15, 34, 99] },
    { input: [50, 25, 33, 22], want: [22, 33, 50, 25] },
    { input: [12347, 2347, 347, 47, 7], want: [7, 47, 347, 2347, 12347] },
];

testCases.forEach((testCase) => {
    const { input, want } = testCase;
    const output = persistenceSort([...input]);
    assert.deepStrictEqual(output, want, `persistenceSort(${input})`);
});

console.log('All tests passed.');
