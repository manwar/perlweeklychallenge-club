let ints = [1, 2, 3, 4];
let ints2 = [2, 7, 1, 19, 18, 3];

proc(ints);
proc(ints2);

function total( list ) {
    let sum = 0;
    for (let i of list) {
	sum += i*i;
    }
    return sum;
}

function proc( ints ) {
    let n = ints.length;
    let spec = [];
    for (let i = 0; i < n; i++) {
	if (n % (i + 1) == 0) {
	    spec.push(ints[i]);
	}
    }
    console.log("Input:", ints);
    console.log("Output:", total( spec ));
}
