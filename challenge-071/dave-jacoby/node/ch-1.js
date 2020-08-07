"use strict;";

// get N

// argv[0] = node
// argv[1] = this program
let n = process.argv[2];
n = parseInt(n);

process.on("exit", function (code) {
  if (code != 0) {
    return console.log(`About to exit with code ${code}`);
  }
});

if (!Number.isInteger(n)) {
  n = 7;
}

// control number range;
if (n < 1 || n > 50) {
  process.exit(22);
}

// do the work
let values = create_array(n);
let peaks = find_peaks(values);

// remove the beginning and ending 0
values.pop();
values.shift();

console.log('VALUES');
console.dir(values);
console.log('');
console.log('PEAKS');
console.dir(peaks);

// find peak values in the array
function find_peaks(values) {
  let output = [];
  for (let i = 0; i < values.length; i++) {
    if (i > 0 && i < values.length - 1) {
      if (values[i] > values[i - 1] && values[i] > values[i + 1]) {
        output.push(values[i]);
      }
    }
  }
  return output;
}

// create array
function create_array(max) {
  let values = [];
  while (values.length < max) {
    let value = 1 + Math.floor(50 * Math.random());
    if (!values.includes(value)) {
      values.push(value);
    }
  }

  // adding zero to beginning to end removes odd cases
  values.unshift(0);
  values.push(0);
  return values;
}
