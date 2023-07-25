#! /usr/bin/node

"use strict"

function roman2int(roman) {
    if (roman == "") {
        return 0;
    }
    for (let s of [
        [ 'M', 1000 ],
        [ 'CM', 900 ],
        [ 'D', 500 ],
        [ 'CD', 400 ],
        [ 'C', 100 ],
        [ 'XC', 90 ],
        [ 'L', 50 ],
        [ 'XL', 40 ],
        [ 'X', 10 ],
        [ 'IX', 9 ],
        [ 'V', 5 ],
        [ 'IV', 4 ],
        [ 'I', 1 ],
    ]) {
        if (roman.startsWith(s[0])) {
            return s[1] + roman2int(roman.slice(s[0].length));
        }
    }
    return 0;
}

function int2roman(n0) {
    let number = n0;
    let mn = "";
    for (let s of [
        [ 'M', 1000 ],
        [ 'CM', 900 ],
        [ 'D', 500 ],
        [ 'CD', 400 ],
        [ 'C', 100 ],
        [ 'XC', 90 ],
        [ 'L', 50 ],
        [ 'XL', 40 ],
        [ 'X', 10 ],
        [ 'IX', 9 ],
        [ 'V', 5 ],
        [ 'IV', 4 ],
        [ 'I', 1 ],
    ]) {
        while (s[1] <= number) {
            mn += s[0]
            number -= s[1];
        }
    }
    return mn;
}

function romanmaths(ax) {
    const elems = ax.split(" ");
    const a = roman2int(elems[0]);
    const b = roman2int(elems[2]);
    let c = -1;
    if (elems[1] == "+") {
        c = a + b;
    } else if (elems[1] == "-") {
        c = a - b;
    } else if (elems[1] == "*") {
        c = a * b;
    } else if (elems[1] == "/") {
        if (a % b == 0) {
            c = a / b;
        }
    } else if (elems[1] == "**") {
        c = a ** b;
    }
    if (c > 3999 || c < 0) {
        return 'non potest';
    } else if (c == 0) {
        return 'nulla';
    } else {
        return int2roman(c);
    }
}

if (roman2int('I') == 1) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (roman2int('II') == 2) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (roman2int('IV') == 4) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (roman2int('IX') == 9) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (roman2int('XXX') == 30) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (roman2int('MDCLXVI') == 1666) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (int2roman(1) == 'I') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (int2roman(2) == 'II') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (int2roman(4) == 'IV') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (int2roman(9) == 'IX') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (int2roman(30) == 'XXX') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (int2roman(1666) == 'MDCLXVI') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('IV + V') == 'IX') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('M - I') == 'CMXCIX') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('X / II') == 'V') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('XI * VI') == 'LXVI') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('VII ** III') == 'CCCXLIII') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('V - V') == 'nulla') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('V / II') == 'non potest') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('MMM + M') == 'non potest') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (romanmaths('V - X') == 'non potest') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
