"use strict";
"use strict";
const assert = require("assert");

function maximumGreatness(array, permute) {
    const seen = new Map();
    let max = 0;

    for (const value of array) {
        if (!seen.has(value)) {
            seen.set(value, 0);
        }
        const count = seen.get(value) + 1;
        seen.set(value, count);
        if (count > max) {
            max = count;
        }
    }

    if (permute) {
        const sortedIdx = Array.from(array.keys()).sort((a, b) => {
            return array[a] - array[b] || a - b;
        });

        for (let i = 0; i < array.length; i++) {
            const next = (i + max) % array.length;
            permute[sortedIdx[i]] = array[sortedIdx[next]];
        }
    }

    return array.length - max;
}

const testCases = [
    [4, [1, 3, 5, 2, 1, 3, 1], [2, 1, 1, 5, 3, 1, 3]],
    [5, [1, 2, 2, 3, 3, 4, 4], [2, 3, 3, 4, 4, 1, 2]],
    [4, [1, 2, 3, 4, 5], [2, 3, 4, 5, 1]],
    [3, [55, 22, -33, 10], [-33, 55, 10, 22]]
];

testCases.forEach(([want, array, want_permute]) => {
    const permute = new Array(array.length);
    const count = maximumGreatness(array, permute);

    assert.strictEqual(count, want, `Array [${array}] count should be ${want}`);
    if (permute) {
        assert.deepStrictEqual(permute, want_permute, `Permute [${want_permute}]`);
    }
});

console.log("All tests passed!");
