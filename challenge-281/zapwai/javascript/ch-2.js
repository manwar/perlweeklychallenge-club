let start = "g2";
let end = "a8";
proc(start, end);

start = "g2";
end = "h2";
proc(start, end);

function proc(start, end) {
    console.log("Input:", start,"to", end);
    let list = [moves(start)];
    let round = -1;
    let found = 0;
    while (found == 0) {
	round++;
	for (let old_move of list[round]) {
	    if (old_move == end) {
		found = 1;
	    }
	}

	if (found == 1) {
	    break;
	} else {
	    let L = [];
	    for (let old_move of list[round]) {
		for (let move of moves(old_move)) {
		    L.push(move);
		}
	    }
	    list.push(L);
	}
    }
    round++;
    console.log("Output:", round);
}

function moves(coord) {
    let l = coord.charAt(0);
    let row = parseInt(coord.charAt(1), 10);
    let cols = "abcdefgh";
    let col = 1 + cols.indexOf(l);
    let r = [];
    let c = [];
    for (let i of [-2, 2]) {
	for (let j of [-1, 1]) {
	    c.push(col + i);
	    r.push(row + j);
	}
    }
    for (let i of [-1, 1]) {
	for (let j of [-2, 2]) {
	    c.push(col + i);
	    r.push(row + j);
	}
    }
    let list = [];
    for (let i = 0; i <= 7; i++) {
	if (c[i] < 1 || c[i] > 8) {
	    continue;
	}
	if (r[i] < 1 || r[i] > 8) {
	    continue;
	}
	let move = cols.charAt(c[i]-1)+r[i];
	list.push(move);
    }
    return list;
}
