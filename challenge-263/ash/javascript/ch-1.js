// Solution of Task 1 of The Weekly Challenge 263
// https://theweeklychallenge.org/blog/perl-weekly-challenge-263/

/*
$ node ch-1.js
[ 1, 2 ]
[]
[ 4 ]
*/

let tests = [
    [1, 5, 3, 2, 4, 2],
    [1, 2, 4, 3, 5],
    [5, 3, 2, 4, 2, 1]
];
let values = [2, 6, 4];

for (let c = 0; c != tests.length; c++) {
    console.log(solve(tests[c], values[c]));    
}

function solve(data, value) {
    data.sort();

    let indices = [];
    for (let c = 0; c != data.length; c++) {
        if (data[c] == value) indices.push(c);
        if (data[c] > value) break;
    }

    return indices;
}
