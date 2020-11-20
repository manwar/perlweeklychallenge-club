// Input
const N = [20, 19, 9, 11, 10];

// Longest Consecutive Sequence
const nums = {};
let end = -1;
let counter = 1;

for (const num of N.sort((a, b) => a - b)) {
  if(nums[num - 1]) {
    const val = nums[num - 1] + 1;
    nums[num] = val;

    if (val >= counter) {
      counter = val;
      end = num;
    }
  } else {
    nums[num] = 1;
    if(counter === 1) end = num;
  }
}

// Output
const start = end - counter;
console.log(Array.from({ length: counter }, (v, k) => start + k + 1));