let str = "perl";
proc(str);
str = "book";
proc(str);
str = "goodmorning";
proc(str);

function is_vowel(c) {
    if (c == 'a' ||
	c == 'e' ||
	c == 'i' ||
	c == 'o' ||
	c == 'u') {
	return true;
    }
    return false;
}

function proc(str) {
    console.log("Input: str = ", str);
    let cnt = 0;
    for (let c of str) {
	if (is_vowel(c)) {
	    cnt++;
	}
    }
    if (cnt % 2 == 0) {
	console.log("Output: true");
    } else {
	console.log("Output: false");
    }
}
    
