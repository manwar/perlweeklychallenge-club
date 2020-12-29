// Sum path
const sumPath = btree => {
  const left = btree.left;
  const right = btree.right;
  const val = btree.value;

  if(left == undefined && right == undefined) return [val, 1];

  let sum = 0;
  let leaves = 0;

  if(left != undefined) {
    const [leftSum, leftLeaves] = sumPath(left);

    sum += leftSum + val * leftLeaves;
    leafs += leftLeaves;
  }

  if(right != undefined) {
    const [rightSum, rightLeaves] = sumPath(right);

    sum += rightSum + val * rightLeaves;
    leafs += rightLeaves;
  }

  return [sum, leaves];
}

// Input
const btree = {
  left: {
    left: { value: 4 },
    value: 2
  },
  right: {
    left: { value: 5 },
    right: { value: 6 },
    value: 3
  },
  value: 1,
};

// Output
console.log(sumPath(btree)[0]);