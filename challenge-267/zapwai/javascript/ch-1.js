let ints = [-1, -2, -3, -4, 3, 2, 1];
proc(ints);
ints = [1, 2, 0, -2, -1];
proc(ints);
ints = [-1, -1, 1, -1, 2];
proc(ints);

function proc(ints) {
    console.log("Input: ints =",ints);
    console.log("Output: ", sign_of_prod(ints));
}

function sign_of_prod(ints) {
    let num_of_negs = 0;
    for (let i of ints) {
	if (i < 0) {
	    num_of_negs++;
	} else if (i == 0) {
	    return 0;
	}
    }
    return (num_of_negs % 2 == 0) ? 1 : -1;
}
