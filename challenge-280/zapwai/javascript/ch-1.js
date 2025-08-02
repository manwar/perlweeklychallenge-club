let mystr = "abcddbca";
proc(mystr);
mystr = "abcd";
proc(mystr);
mystr = "abcdabbb";
proc(mystr);
function proc(mystr) {
    console.log("Input: ", mystr);
    let letter = "";
    let gotten = [];
    for (let l of mystr.split("")) {
	for (let g of gotten) {
	    if (l == g) {
		letter = l;
	    }
	}
	if (letter != "") {
	    break;
	} else {
	    gotten.push(l);
	}
    }
    console.log("Output:", letter);
}
