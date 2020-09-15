
// Input
const list = [9, 10, 7, 5, 6, 1];

// Get leader elements
let arr = [];
list.forEach(item => {
  arr = arr.filter(elem => elem > item);
  arr.push(item);
});

// Output
console.log(arr.join(', '));