function f(c) {
    let m = (212 - 32) / 100;
    return 32 + m*c;
}

for (let i = -100; i < 212; i++)
    if (f(i) == i)
	console.log(i);

