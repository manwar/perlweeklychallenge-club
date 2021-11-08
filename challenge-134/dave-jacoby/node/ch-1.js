"use strict;";

let output = [];
pandigital(["1"]);
for (i in output) {
  console.log(["", output[i]].join("\t"));
}

function pandigital(state) {
  let digits = {};
  let numbers = [];
  // we have the first five, we're done
  if (output.length > 4) {
    return;
  }
  // there was some duplicate issues, so we use
  // indexOf to see if that value is in the array
  // already
  if (state.length == 10) {
    let pandigit = state.join("");
    if (output.indexOf(pandigit) === -1) {
      output.push(pandigit);
      return;
    }
  }
  // I think I would normally prefer if
  // for ( i in array ) would give me the value
  // within the array not the index, but there
  // are enough times that I want just that, so
  // I don't need that change
  for (let i in state) {
    let n = state[i];
    digits[n] = 1;
  }
  // the long way around getting a range
  let range = Array(10)
    .fill()
    .map((n, i) => i);
  // yes, I could've probably written a filter,
  // but this is understandable
  for (let i in range) {
    if (digits[i] === undefined) {
      numbers.push(i);
    }
  }
  // the duplicates issue was related to
  // losing track of the parens, so that
  // this loop was inside the range loop
  // above, but it works and I've featured
  // the cool indexOf method, so I'll let
  // the belt-and-suspenders solution stand.
  for (let i in numbers) {
    let n = numbers[i];
    let newstate = [...state];
    newstate.push(n);
    pandigital(newstate);
  }
}
