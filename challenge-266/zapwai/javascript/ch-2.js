function proc(N, matrix) {
    let fail = false;
    console.log("Input: matrix =", matrix);
    for (let i = 0; i < N; i++) {
	for (let j = 0; j < N; j++) {
	    if ((i == j) || (i == N - j - 1)) {
		if (matrix[i][j] == 0){
		    fail = true;
		}
	    } else {
		if (matrix[i][j] != 0) {
		    fail = true;
		}
	    }
	}
    }
    let output = !fail ? "True" : "False";
    console.log("Output:", output);
}

let matrix = [ [1, 0, 0, 2],
	       [0, 3, 4, 0],
	       [0, 5, 6, 0],
	       [7, 0, 0, 1],
	     ];
proc(4, matrix);

let matrix2 = [ [1, 2, 3],
		[4, 5, 6],
		[7, 8, 9],
	      ];
proc(3, matrix2);

let matrix3 = [ [1, 0, 2],
		[0, 3, 0],
		[4, 0, 5],
	      ];
proc(3, matrix3);
