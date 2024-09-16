let str = "1";
proc(str);
str = "56e10";
proc(str);
str = "2E32";
proc(str);
str = "a";
proc(str);
str = "1.2";
proc(str);
str = "1.2.6";
proc(str);
str = "3.142e10";
proc(str);
str = "3.142e42B";
proc(str);

function proc(str) {
    console.log( "Input:", str);
    let output = "False";
    let p = str.split(".");
    let dre = /^\d+$/
    let dere = /^\d+e\d+$|^\d+E\d+$/;
    let deere = /^\d+e\d+$|^\d+E\d+$/;
    if (p.length == 1) {
	if (dre.test(str)) {
	    output = "True";
	} else if (dere.test(str)) {
	    output = "True";
	}
    } else if (p.length == 2) {
	if (dre.test(p[0]) && dre.test(p[1])) {
	    output = "True";
	} else if (dre.test(p[0]) && deere.test(p[1])) {
	    output = "True";
	}
    }
    console.log("Output:", output);
}
