let str = "hello";
proc(str);
str = "perl";
proc(str);
str = "raku";
proc(str);

function proc(str) {
    let ords = [];
    for (let i = 0; i < str.length; i++) {
	ords.push(str.charCodeAt(i));
    }
    let sum = 0;
    for (let i = 0; i < ords.length - 1; i++) {
	sum += Math.abs(ords[i] - ords[i + 1]);
    }
    console.log( "Input:", str);
    console.log( "Output:", sum);
}
