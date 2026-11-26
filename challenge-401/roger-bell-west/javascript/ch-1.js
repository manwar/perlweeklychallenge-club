#! /usr/bin/node

"use strict"

function gcd (m0,n0) {
    let m = m0;
    let n = n0;
    while (n != 0) {
        [m, n] = [n, m % n];
    }
    return m;
}

function lcm (m,n) {
    return m/gcd(m,n)*n;
}

function rational(n, d) {
    let r = Object.create(rational.methods);
    r.n = n;
    r.d = d;
    return r;
}

rational.methods = {
    stringify() {
        const xf = gcd(this.n, this.d);
        if (xf > 1) {
            this.n /= xf;
            this.d /= xf;
        }
        return `${this.n}/${this.d}`;
    },

    add(other) {
        const xd = lcm(this.d, other.d);
        const xn = this.n * xd / this.d + other.n * xd / other.d;
        return rational(xn, xd);
    }
}

function fractionaladditionsubstraction(a) {
    let terms = [];
    let state = 0;
    let n = 0;
    let num = 0;
    let sign = 0;
    const cv = a.split("");
    let i = 0;
    while (i < cv.length) {
        switch(state) {
        case 0:
            switch(cv[i]) {
            case "+":
                state = 0;
                i += 1;
                break;
            case "0":
            case "1":
            case "2":
            case "3":
            case "4":
            case "5":
            case "6":
            case "7":
            case "8":
            case "9":
                sign = 1;
                state = 1;
                n = parseInt(cv[i], 10);
                i += 1;
                break;
            case "-":
                sign = -1;
                state = 1;
                n = 0;
                i += 1;
                break;
            }
            break;
        case 1:
            switch(cv[i]) {
            case "0":
            case "1":
            case "2":
            case "3":
            case "4":
            case "5":
            case "6":
            case "7":
            case "8":
            case "9":
                n = n * 10 + parseInt(cv[i], 10);
                i += 1;
                break;
            case "/":
                num = n * sign;
                n = 0;
                state = 2;
                i += 1;
                break;
            }
            break;
        case 2:
            switch(cv[i]) {
            case "0":
            case "1":
            case "2":
            case "3":
            case "4":
            case "5":
            case "6":
            case "7":
            case "8":
            case "9":
                n = n * 10 + parseInt(cv[i], 10);
                i += 1;
                break;
            default:
                terms.push(rational(num, n));
                state = 0;
                break;
            }
            break;
        }
    }
    if (state == 2) {
        terms.push(rational(num, n));
    }
    let out = rational(terms[0].n, terms[0].d);
    for (let nti = 1; nti < terms.length; nti += 1) {
        out = out.add(terms[nti]);
    }
    return out.stringify();
}

if (fractionaladditionsubstraction('1/2+3/2') == '2/1') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (fractionaladditionsubstraction('-5/2-3/2') == '-4/1') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (fractionaladditionsubstraction('5/3-5/3') == '0/1') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (fractionaladditionsubstraction('10/10-1/10+2/5') == '13/10') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (fractionaladditionsubstraction('1/6+1/6+1/6') == '1/2') {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
