mystr = "pPeERrLl";
proc(mystr);
mystr = "rRr";
proc(mystr);
mystr = "GoO";
proc(mystr);
function proc(mystr) {
    console.log("Input:", mystr);
    lets = mystr.split("");
    let prev = "0";
    let curr = "";
    let cnt = -1;
    for (let i = 0; i < mystr.length; i++) {
	curr = lets[i];
	if (prev.toLowerCase() != curr.toLowerCase()) {
	    cnt++;
	}
	prev = curr;
    }
    console.log("Output:", cnt);
}
