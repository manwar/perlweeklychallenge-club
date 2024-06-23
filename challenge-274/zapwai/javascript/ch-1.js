let sent = "I love Perl";
proc(sent);
sent = "Perl and Raku are friends";
proc(sent);
sent = "The Weekly Challenge";
proc(sent);

function isVowel(c) {
    let d = c.toLowerCase()
    return (d == 'a' || d == 'e' || d == 'i' || d == 'o' || d == 'u')
}

function proc(sent) {
    console.log("Input:", sent);
    let words = sent.split(" ");
    for (let i = 0; i < words.length; i++) {
	let A = "";
	for (let j = 0; j < i; j++) {
	    A += "a";
	}
	let lets = words[i].split("");
	let first_let = lets[0];
	lets.shift();
	let reword = lets.join('');
	reword += first_let;
	if (isVowel(first_let)) {
	    console.log("Output", words[i]+"ma"+A+" ");
	} else {
	    console.log("Output", reword+"ma"+A+" ");
	}
    }
}
