#! /usr/bin/node

"use strict"

function combinations(arr, k) {
    let c = [];
    for (let i = 0; i < k; i++) {
        c.push(i);
    }
    c.push(arr.length);
    c.push(0);
    let out = [];
    while (true) {
        let inner = [];
        for (let i = k-1; i >= 0; i--) {
            inner.push(arr[c[i]]);
        }
        out.push(inner);
        let j = 0;
        while (c[j] + 1 == c[j + 1]) {
            c[j] = j;
            j += 1;
        }
        if (j >= k) {
            break;
        }
        c[j] += 1;
    }
    return out;
}

function grouphero(nums0) {
    let nums = [...nums0];
    nums.sort(function(a,b) {
        return b-a;
    });
    let sum = 0;
    for (let l = 1; l <= nums.length; l++) {
        for (let c of combinations(nums, l)) {
            const h = c[c.length - 1];
            sum += h * h * c[0];
        }
    }
    return sum;
}

if (grouphero([2, 1, 4]) == 141) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
