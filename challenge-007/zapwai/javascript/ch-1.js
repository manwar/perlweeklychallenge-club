for (let i = 1; i < 51; i++) {
    let num = i;
    let tally = 0;
    while (num > 0) {
	tally += num % 10;
	num = Math.floor(num / 10);
    }
    if (i % tally == 0)
	console.log(i);
}
