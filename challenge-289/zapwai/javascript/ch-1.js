let ints = [5, 6, 4, 1];
proc(ints);
ints = [4, 5];
proc(ints);
ints = [1, 2, 2, 3];
proc(ints);

function proc(ints) {
    console.log( "Input:", ints);
    let ans = Math.max(...ints);
    let new1 = [];
    for (let i = 0; i < ints.length; i++) {
	if (ints[i] != ans) {
	    new1.push(ints[i]);
	}
    }
    if (new1.length > 0) {
	let m2 = Math.max(...new1);
	let new2 = [];
	for (let i = 0; i < new1.length; i++) {
	    if (new1[i] != m2) {
		new2.push(new1[i]);
	    }
	}
	if (new2.length > 0) {
	    ans = Math.max(...new2);
	}
    }
    console.log( "Output:", ans);
}
