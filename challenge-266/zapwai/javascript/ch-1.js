let line1 = 'Mango is sweet';
let line2 = 'Mango is sour';
proc(line1, line2);

line1 = 'Mango Mango';
line2 = 'Orange';
proc(line1, line2);

line1 = 'Mango is Mango';
line2 = 'Orange is Orange';
proc(line1, line2);

function proc(line1, line2) {
    let words = [];
    for (let s of line1.split(" ")) {
	words.push(s);
    }
    for (let s of line2.split(" ")) {
	words.push(s);
    }
    words.sort();
    let match_flag = false;
    let ans = [];
    for (let i = 0; i < words.length; i++) {
	if (match_flag) {
	    if (words[i] != words[i+1]) {
		match_flag = false;
	    }
	    continue;
	}
	if (words[i] == words[i+1]) {
	    match_flag = true;
	    continue;
	}
	ans.push(words[i]);
    }
    if (match_flag) {
	ans.push(words[words.length-1])
    }
    console.log("Input: l1 =", line1, "l2 =", line2);
    console.log("Output:",ans);
}
