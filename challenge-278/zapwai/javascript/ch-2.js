let str = "challenge";
let mychar = "e";
proc(str, mychar);
str = "programming";
mychar = "a";
proc(str, mychar);
str = "champion";
mychar = "b";
proc(str, mychar);
function proc(str, mychar) {
    console.log("Input: str =", str, "mychar =", mychar);
    let ind = str.indexOf(mychar);
    if (ind == -1) {
	console.log("Output:",str);
    } else {
	let begin = str.substr(0, ind + 1);
	let endy = str.substr(ind + 1);
	console.log(arrange(begin)+endy);
    }
}
function arrange(word) {
    let arr = word.split("");
    return arr.sort().join(separator='');
}
