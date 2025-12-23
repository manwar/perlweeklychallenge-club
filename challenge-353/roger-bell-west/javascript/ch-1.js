#! /usr/bin/node

"use strict"

function maxwords(a) {
    return Math.max(...a.map(x => x.split(" ").length ));
}

if (maxwords(['Hello world', 'This is a test', 'Perl is great']) == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxwords(['Single']) == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxwords(['Short', 'This sentence has six words in total', 'A B C', 'Just four words here']) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxwords(['One', 'Two parts', 'Three part phrase', '']) == 3) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxwords(['The quick brown fox jumps over the lazy dog', 'A', 'She sells seashells by the seashore', 'To be or not to be that is the question']) == 10) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
