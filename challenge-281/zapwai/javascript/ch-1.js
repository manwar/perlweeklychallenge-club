let coord = "d3";
proc(coord);
coord = "g5";
proc(coord);
coord = "e6";
proc(coord);

function proc(coord) {
    console.log( "Input:", coord);
    a = coord.split("");
    l = a[0]
    n = a[1]
    if (l == "a" || l == "c" || l == "e" || l == "g") {
	if (n % 2 == 0) {
	    console.log( "Output: True");
	} else {
	    console.log( "Output: False");
	}
    } else {
	if (n % 2 == 1) {
	    console.log( "Output: True" );
	} else {
	    console.log( "Output: False" );
	}
    }
}
