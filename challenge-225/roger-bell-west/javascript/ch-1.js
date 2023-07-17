#! /usr/bin/node

"use strict"

function maxwords(a) {
    return Math.max(...a.map(x => x.split(" ").length));
}

if (maxwords(['Perl and Raku belong to the same family.', 'I love Perl.', 'The Perl and Raku Conference.']) == 8) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (maxwords(['The Weekly Challenge.', 'Python is the most popular guest language.', 'Team PWC has over 300 members.']) == 7) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
