function center(words) {
    let lens = [];
    for (let word of words)
	lens.push(word.length);
    let m = max(lens);
    let ind = 0;
    for (let l of lens) {
	let sp = (m - l) / 2;
	let s = "";
	for (let i = 0; i < sp; i++)
	    s += "&nbsp";
	s += words[ind] + "<br>";
	ind++;
	document.write(s);
    }
}


function max (nums) {
    let max = 0;
    for (let n of nums) {
	if (max < n)
	    max = n;
    }
    return max;
}

let words = ["This", "is", "a test of the", "center function"];
center(words);
console.log(max([3, 5, 7, 1, 15]));
