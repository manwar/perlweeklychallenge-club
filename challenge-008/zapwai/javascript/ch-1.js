function is_perfect(num) {
    let divs = list_divisors(num);
    let sum = 0;
    divs.forEach(item => {
	sum += item;
    });
    return (num == sum);
}

function list_divisors(num) {
    let divs = [1];
    for (let i = 2; i <= num/2; i++) {
	if (num % i == 0)
	    divs.push(i);
    }
    return divs;
}

let perfect_numbers = [];

for (let p = 2; p <= 15; p++) {
    let num = Math.pow(2, p-1) * (Math.pow(2,p) - 1);
    if (is_perfect(num))
	perfect_numbers.push(num);
    if (perfect_numbers.length == 5)
	break;
}

console.log(perfect_numbers);

