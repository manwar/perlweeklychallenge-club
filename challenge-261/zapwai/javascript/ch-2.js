function double_me (ints, start) {
    flag = true;
    while (flag) {
	flag = false;
	for (let i = 0; i < ints.length; i++) {
	    if (ints[i] == start) {
		flag = true;
		start *= 2;
	    }
	}
    }
    return start;
}

function main() {
    let ints = [5, 3, 6, 1, 12];
    let start = 3;
    console.log("Input: ints:", ints, "start:", start);
    console.log("Output:", double_me(ints, start));
}

main();
