let ints = [0, 1, 2];
let ints2 = [4, 3, 2, 1];
let ints3 = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];

proc(ints);
proc(ints2);
proc(ints3);

function proc(ints) {
    let k = -1;
    for (let i = 0; i < ints.length; i++) {
	if (i % 10 == ints[i]) {
	    k = i;
	    break;
	}
    }
    console.log("Input:",ints);
    console.log("Output:",k);
}
