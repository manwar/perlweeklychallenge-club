"use strict";

// let list = Array(20).fill();
// for (let i in list) {
//   let j = first_pass(i);
//   let s = get_sequence(i * 2);
//   let v = solve_sequence(i);
//   console.log(["", "i", i, "j", j, "v", v].join("\t"));
// }

let list = [2, 5, 10, 60, 200];

for (let i in list) {
  let n = list[i];
  let s = solve_sequence(n);
  console.log(["", n, s].join("\t"));
}

function solve_sequence(n) {
  let j = n * 2;
  let s = get_sequence(1 + j);
  while (s[n] == undefined) {
    j = j * 2;
    s = get_sequence(j);
  }
  return s[n];
}

function get_sequence(n) {
  n = parseInt(n);
  let sequence = Array(n)
    .fill("")
    .map((x, i) => first_pass(i + 1))
    .filter((x) => !x.toString().match(/0/))
    .filter((x) => !x.toString().match(/11/));
  sequence.unshift(0);
  return sequence;
}

function first_pass(n) {
  if (n == 0) {
    return 0;
  }
  let output = [];
  while (n) {
    let i = n % 4;
    n = parseInt(n / 4);
    output.push(i);
  }
  return output.reverse().join("");
}
