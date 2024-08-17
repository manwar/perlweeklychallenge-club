let mystr = "aabb";
proc(mystr);
mystr = "abab";
proc(mystr);
mystr = "aaa";
proc(mystr);
mystr = "bbb";
proc(mystr);

function proc(mystr) {
    console.log( "Input: mystr =", mystr);
    let ver = 0;
    for (let l of mystr) {
	if (l == 'b') {
	    ver = 1;
	}
    }
    if (ver == 1) {
	let bflag = 0;
	for (let l of mystr) {
	    if (l == 'a' && bflag == 1) {
		ver = 0;
		break;
	    } else {
		if (l == 'b') {
		    bflag = 1;
		}
	    }
	}
    }
    if (ver == 1) {
	console.log("Output: true");
    } else {
	console.log("Output: false");
    }
}
