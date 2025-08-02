let m1 = [
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 0],
    [1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 1]
];

let m2 = [
    [1, 0, 0, 0],
    [1, 1, 1, 1],
    [1, 0, 0, 0],
    [1, 0, 0, 0]
];

proc(m1);
proc(m2);

function tally_row(m, i) {
    let sum = 0;
    for (let j = 0; j < m[0].length; j++) {
	sum += m[i][j];
    }
    return sum;
}

// Return True if i is weaker than j
function is_weaker(m, i, j) {
    let ti = tally_row(m, i);
    let tj = tally_row(m, j);
    if (ti  < tj) {
	return true;
    } else if (ti == tj) {
	return i < j;
    } else {
	return false;
    }
}

function mysort(m, list) {
    let cnt = 0;
    do {
	cnt = 0;
	for (let i = 0; i < list.length - 1; i++) {
	    if (is_weaker(m, list[i], list[i+1])) {
		cnt++;
		let tmp = list[i];
		list[i] = list[i+1];
		list[i+1] = tmp;
	    }
	}
    } while (cnt > 0);
    return list;
}

function proc(m) {
    console.log("Input:", m);
    let list = [];
    for (let i = 0; i < m.length; i++) {
	list.push(i);
    }
    mysort(m, list);
    list.reverse();
    console.log("Output:",list);
}

