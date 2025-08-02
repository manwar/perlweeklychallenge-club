function vigenere(mode, key, msg) {
    let alph = "abcdefghijklmnopqrstuvwxyz";
    let q = msg.length / key.length;
    while (q > 0) {
        key += key;
        q--;
    }
    while (key.length > msg.length) {
        key = key.substr(0,key.length-1);
    }

    let msg_letters = msg.split('');
    let key_letters = key.split('');
    let rots = [];
    for (let i = 0; i < key_letters.length; i++) {
	rots.push(alph.indexOf(i));
    }
    let ans_letters = [];
    for (let i = 0; i < msg_letters.length; i++) {
	if (!msg_letters[i].match(/[a-z]/)) {
	    ans_letters.push(msg_letters[i]);
	    continue;
	}
	let v = alph.indexOf(msg_letters[i]);
	let x = 0;
	if (mode == 0)
	    x = (v + rots[i]) % 26;
	else 
	    x = (v - rots[i]) % 26;
	let letter = alph.substr(x,1);
	ans_letters.push(letter);
    }
    return ans_letters.join('');
}
let msg = "hello world";
let key = "test";
let enc = vigenere(0, key, msg);
let dec = vigenere(1, key, enc);
console.log(enc);
console.log(dec);
