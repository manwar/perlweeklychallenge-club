let alph = ["perl", "2", "000", "python", "r4ku"];
let alph2 = ["001", "1", "000", "0001"];

proc(alph);
proc(alph2);

function proc(alph) {
    let max = 0;
    for (let word of alph) {
	let reg = /^\d+$/;
	let n = word.match(reg);
	if (n == null) {
	    n = word.length;
	} else {
	    n = Math.max(n);
	}
	if (max < n) {
	    max = n;
	}
    }
    console.log("Input:",alph);
    console.log("Output:",max);
}
