let ints = [0, 1, 2, 3, 4, 5, 6, 7, 8];
proc(ints);
ints = [1024, 512, 256, 128, 64];
proc(ints);
function proc(ints) {
    console.log( "Input: ", ints);
    let count = [];
    for (let i of ints) {
	let bin = i.toString(2);
	let dig = bin.split("");
	let cnt = 0;
	for (let d of dig) {
	    if (d == "1") {
		cnt++;
	    }
	}
	count.push(cnt);
    }
    let ord = ints;
    let c = 1;
    while (c != 0) {
	c = 0;
	for (let i = 0; i < ord.length - 1; i++) {
	    if (count[i] > count[i+1]) {
		c++;
		let tmp_cnt = count[i];
		let tmp_int = ord[i];
		count[i] = count[i+1];
		count[i+1] = tmp_cnt;
		ord[i] = ord[i+1];
		ord[i+1] = tmp_int;
	    }
	}
    }
    c = 1;
    while (c != 0) {
	c = 0;
	for (let i = 0; i < ord.length - 1; i++) {
	    if (count[i] != count[i+1]) {
		continue;
	    }
	    if (ord[i] > ord[i+1]) {
		c++;
		let tmp_int = ord[i];
		ord[i] = ord[i+1];
		ord[i+1] = tmp_int;
		let tmp_cnt = count[i];
		count[i] = count[i+1];
		count[i+1] = tmp_cnt;
	    }
	}
    }
    console.log( "Output:",ord);
}
