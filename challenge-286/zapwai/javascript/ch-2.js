let ints = [2, 1, 4, 5, 6, 3, 0, 2];
proc(ints);
ints = [0, 5, 3, 2];
proc(ints);
ints = [9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8];
proc(ints);

function proc(ints) {
    console.log("Input: ints =", ints);
    while (ints.length > 2) {
	let L = [];
	for (let i = 0; i < ints.length/2; i++) {
	    if (i % 2 == 0) {
		L.push(Math.min(ints[2*i], ints[2*i + 1]));
	    } else {
		L.push(Math.max(ints[2*i], ints[2*i + 1]));
	    }
	}
	ints = L;
    }
    console.log("Output:", Math.min(ints[0], ints[1]));
}
