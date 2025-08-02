matrix = [ [0, 1],
	   [1, 0],
	 ];
proc(matrix);
matrix = [ [0, 0, 0],
	    [1, 0, 1],
	  ];
proc(matrix);
matrix = [ [0, 0],
	    [1, 1],
	    [0, 0],
	  ];
proc(matrix);
function proc(m) {
    console.log( "Input: m = ", m);
    let cnt = [];
    for (let i = 0; i < m.length; i++) {
	cnt.push(0);
    }
    let pres = 0;
    for (let row of m) {
	for (let entry of row) {
	    if (entry == 1) {
		cnt[pres]++;
	    }
	}
	pres++;
    }
    let max = 0;
    let max_index = 0;
    for (let i = 0; i < cnt.length; i++) {
	if (cnt[i] > max) {
	    max_index = i;
	    max = cnt[i];
	}
    }
    console.log( "Output: row ", max_index + 1, " ( count is ", max, ")");
}

