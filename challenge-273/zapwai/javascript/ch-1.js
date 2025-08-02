let mystr = "perl"; let mychar = "e";
proc(mystr, mychar);
mystr = "java"; mychar = "a";
proc(mystr, mychar);
mystr = "python"; mychar = "m";
proc(mystr, mychar);
mystr = "ada"; mychar = "a";
proc(mystr, mychar);
mystr = "ballerina"; mychar = "l";
proc(mystr, mychar);
mystr = "analitik"; mychar = "k";
proc(mystr, mychar);    

function proc(mystr, mychar) {
    console.log("Input: mystr =", mystr, "mychar =", mychar);
    let cnt = 0;
    for (let l of mystr) {
	if (l == mychar) {
	    cnt++;
	}
    }
    let i = 100*(cnt / mystr.length);
    console.log( "Output:", Math.round(i));
}
