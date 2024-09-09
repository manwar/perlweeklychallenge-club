let routes = [["B","C"], ["D","B"], ["C","A"]];
proc(routes);
routes = [["A","Z"]];
proc(routes);

function proc(routes) {
    console.log("Input: ");
    for (let j = 0; j < routes.length; j++) {
	console.log(routes[j]);
    }
    let inlist = [];
    let outlist = [];
    for (let j of routes) {
	inlist.push(j[0]);
	outlist.push(j[1]);
    }
    let ans = "a";
    for (let needle of outlist) {
	let found = 0;
	for (let hay of inlist) {
	    if (needle == hay) {
		found = 1;
		break;
	    }
	}
	if (found == 0) {
	    ans = needle;
	}
    }
    console.log( "Output:", ans);
}

