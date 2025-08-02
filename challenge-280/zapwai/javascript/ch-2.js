let mystr = "p|*e*rl|w**e|*ekly|";
proc(mystr);
mystr = "perl";
proc(mystr);
mystr = "th|ewe|e**|k|l***ych|alleng|e";
proc(mystr);
function proc(mystr) {
    console.log("Input:", mystr);
    let cnt = 0;
    let words = mystr.split('|');
    for (let i = 0; i < words.length; i++) {
	if (i % 2 == 0) {
	    for (let l of words[i].split("")) {
		if (l == "*") {
		    cnt += 1;
		}
	    }
	}
    }
    console.log("Output:", cnt);
}
