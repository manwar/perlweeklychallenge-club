let str = 'PeRlwEKLy';
console.log("Input:", str);
console.log("Output:", proc(str));

function proc(str) {
    letters = str.split("");
    let upper = [];
    let lower = [];
    for (let l of letters) {
	if (l.toUpperCase() == l) {
	    upper.push(l);
	} else {
	    lower.push(l);
	}
    }
    common = [];
    for (let u of upper) {
	for (let l of lower) {
	    if (u.toLowerCase() == l) {
		common.push(u);
	    }
	}
    }
    common = common.sort();
    return common[common.length-1];
}
