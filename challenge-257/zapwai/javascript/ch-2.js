let m0 = [
    [1,0,0,1],
    [0,1,0,2],
    [0,0,1,3]
];

let m1 = [
    [1, 1, 0],
    [0, 1, 0],
    [0, 0, 0]
];



let m2 = [
    [0, 1,-2, 0, 1],
    [0, 0, 0, 1, 3],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0]
];


let m3 = [
    [1, 0, 0, 4],
    [0, 1, 0, 7],
    [0, 0, 1,-1]
];



let m4 = [
    [0, 1,-2, 0, 1],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 1, 3],
    [0, 0, 0, 0, 0]
];


let m5 = [
    [0, 1, 0],
    [1, 0, 0],
    [0, 0, 0]
];

let m6 = [
    [4, 0, 0, 0],
    [0, 1, 0, 7],
    [0, 0, 1,-1]
];

for (let m of [m0, m1, m2, m3, m4, m5, m6]) {
    proc(m);
}

function proc(m) {
    console.log("Input m = [");
    for (let row of m) {
	frow = "[";
	for (let c of row) {
	    frow += c + ", ";
	}
	let newrow = frow.slice(0, -2);
	newrow += "]";
	console.log(newrow);
    }
    console.log("]");
    console.log("Output: ", check(m));
}

function is_reduced(m) {
    // Check for leading ones
    for (let row of m) {
	for (let c of row) {
	    if (c == 0) {
		continue;
	    }
	    if (c == 1) {
		break;
	    }
	    else {
		return false;
	    }
	}
    }
    // Check for zero entries
    let fv = m[0].length - m.length;
    for (let j = 0; j < m[0].length - fv; j++) {
	let cnt = 0;
	for (let i = 0; i < m.length; i++) {
	    if (m[i][j] != 0) {
		cnt++;
	    }
	}
	if (cnt > 1) {
	    return false;
	}
    }
    return true;
}

function is_echelon(m) {
    let zcnt = 0;
    for (let row of m) {
	let cnt = 0;
	for (let i = 0; i < row.length; i++) {
	    if (row[i] == 0) {
		cnt++;
	    } else {
		break;
	    }
	}
	if (zcnt > cnt) {
	    return false;
	} else {
	    zcnt = cnt;
	}
    }
    return true;
}

function check(m) {
    return is_reduced(m) && is_echelon(m);
}
