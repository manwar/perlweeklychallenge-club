let s = "This supposed Cambridge research is unfortunately an urban legend";
proc(s);

function jumble(word) {
    if (word.length < 4) {
	return word;
    }
    let Let = word.split("");
    let start = Let[0];
    let end = Let[Let.length - 1];
    Let.pop();
    Let.shift();
    let order = [];
    while (order.length < Let.length) {
	let x = Math.floor(Math.random() * Let.length);
	if (!order.includes(x)) {
	    order.push(x);
	}
    }
    let middle = "";
    for (let o of order) {
	middle += Let[o];
    }
    let q = start + middle + end;
    return q;
}

function proc(s) {
    console.log( "Input:", s);
    let words = s.split(" ");
    let newlist = (words.map(x => jumble(x)));
    console.log( "Output:", newlist.join(' ') );
}
