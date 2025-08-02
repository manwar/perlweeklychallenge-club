let r = ["I", "V", "X", "L", "C", "D", "M"];
let v = [1, 5, 10, 50, 100, 500, 1000];

function roman(c) {
    for (let i = 0; i < r.length; i++) 
        if (r[i] == c) 
            return v[i];
}

let basic = [ "IIII", "VIIII", "XXXX", "LXXXX", "CCCC", "DCCCC" ];
let modern = [ "IV", "IX", "XL", "XC", "CD", "CM" ];

function convert_from_roman(s) {
    console.log("Input:",s);
    for (let i = 0; i < basic.length; i++) {
        let key = modern[i];
        let val = basic[i];
        s = s.replace(key, val);
    }
    let sum = 0;
    for (let c of s)
        sum += roman(c);
    console.log("Output:", sum);
}

function convert_to_roman(num) {
    console.log("Input:", num);
    let ans = "";
    let stack = [];
    for (let i = 0; i < r.length; i++) 
        if (num >= v[i])
	    stack.push(v[i]);
    let i = stack.length - 1
    while (i >= 0) {
        let x = stack.pop();
        let d = Math.floor(num/x);
        for (let j = 0; j < d; j++)
            ans += r[i];
        num -= d*x;
        i -= 1;
    }
    for (let j = 0; j < basic.length; j++) {
        key = basic[basic.length - 1 - j];
        val = modern[basic.length - 1 - j];
        ans = ans.replace(key, val);
    }
    console.log("Output:", ans);
}
convert_from_roman("CCXLVI");
convert_to_roman(39);

