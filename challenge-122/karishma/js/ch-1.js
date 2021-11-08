let input = [10,20,30,40,50];
let sum = 0;
for (let j = 1; j <= 5; j++) {
    sum += input[j-1];
    console.log(sum/j);
}