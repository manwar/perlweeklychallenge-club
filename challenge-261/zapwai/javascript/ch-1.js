function digits_sum(ints) {
    let sum = 0;
    for (let i = 0; i < ints.length; i++) {
	do {
	    sum += ints[i] % 10;
	    ints[i] = Math.floor(ints[i] / 10);
	} while (ints[i] != 0);
    }
    return sum;
}

function sum(ints) {
    let sum = 0;
    for (let i = 0; i < ints.length; i++)
	sum += ints[i];
    return sum;
}

function main() {
    let ints = [1,2,3,45];
    console.log("Input:", ints);
    console.log("Output:", Math.abs(sum(ints) - digits_sum(ints)));
}

main();
