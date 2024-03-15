const alph = "0123456789abcdefghijklmnopqrstuvwxy";

// input a base-35 number (a string), output base-10
const from35 = function(s) {
    let n = s.length - 1;
    let sum = 0;
    for (let d of s) {
	sum += alph.indexOf(d) * Math.pow(35,n);
	n--;
    }
    return sum;
};

// input base-10, output base-35
const to35 = function(d) {
    let rem = parseInt(d % "35");
    let n = 0;
    while (true) {
	let q = parseInt(d / String(Math.pow(35, n+1)));
	if ( q < 1 ) {
	    break;
	}
	n++;
    }
    let coeffs = [];
    for (let k = n; k > 0; k--) {
	coeffs.push( Math.floor(d / Math.pow(35, k)) );
    }
    coeffs.push(rem);

    let s = "";
    for (let c of coeffs) {
	s += alph.charAt(c);
    }
    return s;
};

// 2u <- 2(35) + 30 = 100
let num = "1000";
console.log("Input: (base-10) ", num);
console.log("Output: (base-35) ", to35(num));
// 120 = 105 + 15 -> 3(35) + 15
let x = "3f";
console.log("Input: (base-35) ", x);
console.log("Output: (base-10)", from35(x));

// // // // // // // // // // // // 
//  Proper way (would work for bases up to 36):

// function to35(d) {
//     return d.toString(35);
// }

// function to10(s) {
//     return parseInt(s, 35);
// }

// example
// let d = 100;
// let x = d.toString(35);		// a base-35 number
// console.log(x);			// 2u
// console.log(parseInt(x, 35));	// 100   base-35 -> base-10

