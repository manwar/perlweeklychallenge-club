let m =  [ [ 3,  7,  8],
	   [ 9, 11, 13],
	   [15, 16, 17] ];

let m2 = [ [ 1, 10,  4,  2],
           [ 9,  3,  8,  7],
           [15, 16, 17, 12] ];

let m3 = [ [7 ,8],
           [1 ,2] ];

proc(m);
proc(m2);
proc(m3);

function proc(m) {
    let mins = [];
    for (let row of m) {
	mins.push(Math.min(...row));
    }
    let maxs = [];
    for (let j = 0; j < m[0].length; j++) {
	let col = [];
	for (let i = 0; i < m.length; i++) {
	    col.push(m[i][j]);
	}
	maxs.push(Math.max(...col));
    }
    let x;
    for (let i of mins) {
	for (let j of maxs) {
	    if (i == j) {
		x = i;
	    }
	}
    }
    console.log("Input: m =", m);
    console.log("Output:", x);
}
