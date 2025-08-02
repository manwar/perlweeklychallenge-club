let ints1 = [2, 5, 9, 11, 3]; let k1 = 1;
let ints2 = [2, 5, 9, 11, 3]; let k2 = 2;
let ints3 = [2, 5, 9, 11, 3]; let k3 = 0;
proc(k1, ints1);
proc(k2, ints2);
proc(k3, ints3);
function proc(k, ints) {
    console.log("Input:", ints, "k:", k);
    let sum = 0;
    for (let i in ints) {
	let tally = 0;
	let x = Number(i).toString(2);
	for (let c of x.split("")) {
	    if (c == '1') {
		tally += 1;
	    }
	}
	if (tally == k) {
	    sum += ints[i];
	}
    }
    console.log("Output:", sum);
}
