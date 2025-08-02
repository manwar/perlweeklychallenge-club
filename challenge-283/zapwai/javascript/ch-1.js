let ints = [3, 3, 1];
proc(ints);
ints = [3, 2, 4, 2, 4];
proc(ints);
ints = [1];
proc(ints);
function proc(ints) {
    console.log("Input: ints =", ints);
    let num = 0;
    for (let i = 0; i < ints.length; i++) {
	let found = 0;
	let elem = ints[i];
	for (let j = 0; j < ints.length; j++) {
	    if (i == j) {
		continue;
	    }
	    let new_elem = ints[j];
	    if (elem == new_elem) {
		found = 1;
	    }
	}
	if (found == 0) {
	    num = elem;
	    break;
	}
    }
    console.log("Output:", num);
}
