let stringy = 'a1c1e1';
proc(stringy);
stringy = 'a1b2c3d4';
proc(stringy);
stringy = 'b2b';
proc(stringy);

function proc(stringy) {
    console.log("Input: str =", stringy);
    let lets = [];
    let puts = [];
    for (let i = 0; i < stringy.length; i++) {
	if (i % 2 == 0) {
	    let mylet = stringy.charAt(i);
	    lets.push(mylet);
	} else {
	    let put = shifty(lets[lets.length - 1], stringy.charAt(i));
	    puts.push(put);
	}
    }
    output = "Output: ";
    for (let j = 0; j <= (stringy.length)/2 - 1; j++)
	output += lets[j] + puts[j];
    if (stringy.length % 2 == 1)
	output += lets[lets.length - 1];
    console.log(output);
}
    
function shifty(c, d) {
    let alph = 'abcdefghijklmnopqrstuvwxyz';
    let ind = alph.indexOf(c);
    return alph.charAt(+d + +ind);
}
