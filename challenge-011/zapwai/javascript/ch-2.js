function id_mat(n) {
    let a = [];
    for (let i = 0; i < n; i++) {
	a.push([]);
	for (let j = 0; j < n; j++)
	    a[i].push(0);
	a[i][i] = 1;
    }
    for (let i = 0; i < n; i++) 
	console.log(a[i]);
}

id_mat(3)
