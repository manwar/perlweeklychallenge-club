let ints = [1, 2, 3, 4, 5];
let ints2 = [2, 3, 8, 16];
let ints3 = [1, 3, 5, 7, 9];
proc(ints);
proc(ints2);
proc(ints3);

function truth(ints) {
    let N = ints.length;
    for (let i = 0; i < Math.pow(2,N) - 1; i++) {
	let d = i.toString(2);
	let D = d.split("");
	while (D.length < N) {
	    if (D.length < N) {
		D.unshift(0);
	    }
	}
	let current_list = [];
	for (let j = 0; j < D.length; j++) {
	    if (1 == D[j]) {
		current_list.push(ints[j]);
	    }
	}
	if (1 >= current_list.length) {
	    continue;
	}
	let tally = 0;
	for (let c of current_list) {
	    tally = tally | c;
	}
	let x = tally.toString(2);
	let last_bin_dig = x.slice(-1);
	console.log(d, x, last_bin_dig);
	if (last_bin_dig == "0") {		
	    console.log(current_list,"->", x);
	    return 1;
	}
    }
    return 0;
}

function proc(ints) {
    console.log("Input:", ints);
    if (truth(ints)) {
	console.log( "Output: true" );
    } else {
	console.log( "Output: false" );
    }
}

