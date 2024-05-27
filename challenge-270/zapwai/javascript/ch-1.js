let matrix = [ [1, 0, 0],
	       [0, 0, 1],
	       [1, 0, 0],
	     ];

let matrix2 = [ [1, 0, 0],
		[0, 1, 0],
		[0, 0, 1],
	      ];

proc(matrix);
proc(matrix2);

function is_special(m, M, N, i, j) {
    if (m[i][j] != 1) {
	return 0;
    }
    for (let k = 0; k < M; k++) {
	if (k == i) {
	    continue;
	}
	if (m[k][j] != 0) {
	    return 0;
	}
    }
    for (let k = 0; k < N; k++) {
	if (k == j) {
	    continue;
	}
	if (m[i][k] != 0) {
	    return 0;
	}
    }
    return 1;
}

function proc(m) {
    let M = m.length;
    let N = m[0].length;
    console.log("Input: m = ", m);
    let cnt = 0;
    for (let i = 0; i < M; i++) {
	for (let j = 0; j < N; j++) {
	    if (is_special(m, M, N, i, j)) {
		cnt++;
	    }
	}
    }
    console.log("Output: ", cnt);
}
