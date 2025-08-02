//const letters = ['R', 'E', 'P', 'L'];
//const weights = [3, 2, 1, 4];

//const letters = ['A', 'U', 'R', 'K'];
//const weights = [2, 4, 1, 3];

const letters = ['O', 'H', 'Y', 'N', 'P', 'T'];
const weights = [5, 4, 2, 6, 1, 3];

let outArr = [];

letters.map((letter, index) => {
  outArr[(parseInt(weights[index]))] = letter;
})

console.log( "Output: " + outArr.join('') );
