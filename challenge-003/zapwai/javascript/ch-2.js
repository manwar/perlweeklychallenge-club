let n = prompt("Please enter # of rows: ");
m = [];
m.push([1]);
m.push([1, 1]);
for (let i = 2; i < n; i++) {
    row = [];
    for (let j = 0; j <= i; j++) {
	if ( (j == 0) || (j == i) ) {
	    row.push(1);
	} else {
	    row.push(m[i-1][j-1] + m[i-1][j]);
	}
    }
    m.push(row);
}
console.log(m);
for (let i = 0; i < n; i++) {
    let space = "";
    for (let sp = 0; sp < n - i; sp++) {
	space += "&nbsp";
    }
    document.write(space);
    for (let j = 0; j <= i; j++) {
	document.write(`${m[i][j]} `);
    }
    document.write("<br>");
}

