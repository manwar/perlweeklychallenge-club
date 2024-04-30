let alph = "abcdefghijklmnopqrstuvwxyz";

function proc(string, widths) {
    console.log("Input: string =", string,"\n widths =", widths);
    let pixwidth = 100;
    let width = pixwidth;
    let lines = 1;
    for (let s of string.split('')) {
        w = widths[alph.indexOf(s)]
        if (width - w < 0) {
            lines++;
            width = pixwidth;
	}
        width -= w
    }
    console.log("Output:", lines, pixwidth - width);
}

let string = "abcdefghijklmnopqrstuvwxyz";
let widths = [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10];
proc(string, widths);

string = "bbbcccdddaaa";
widths = [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10];
proc(string, widths);
