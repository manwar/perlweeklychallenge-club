let myint = 123444567;
proc(myint);
myint = 1233334;
proc(myint);
myint = 10020003;
proc(myint);

function proc(myint) {
    console.log( "Input:", myint);
    let numb = -1;
    let current = 0;
    let prev = 0;
    let cnt = 0;
    let num = [];
    t = myint;
    while (t != 0) {
	num.push(t % 10);
	t = Math.floor(t / 10);
    }
    num.reverse();
    for (let i = 0; i < num.length; i++) {
	prev = current;
	current = num[i];
	if (prev == current) {
	    cnt++;
	} else {
	    if (cnt == 2) {
		numb = prev;
		break;
	    } else {
		cnt = 0;
	    }
	}
    }
    console.log( "Output:", numb);
}
