// Binary Tree to Linked List
const createLinkedList = (btree) => {
  const res = { next: null, value: btree.value };

  if(btree.left || btree.right) {
    let node = res;

    if(btree.left) {
      node.next = createLinkedList(btree.left);

      while(node.next) node = node.next;
    }

    if(btree.right) {
      node.next = createLinkedList(btree.right);
    }
  }

  return res;
}

// Print Linked List
const printLinkedList = (linkedList) => {
  let node = { ...linkedList };

  while(node.next) {
    process.stdout.write(`${node.value} -> `);
    node = node.next;
  }

  process.stdout.write(`${node.value}`);
}

// Input
const btree = {
  left: {
    left: { value: 4 },
    right: {
      value: 5,
      left: { value: 6 },
      right: { value: 7 }
    },
    value: 2
  },
  right: { value: 3 },
  value: 1
};

// Output
printLinkedList(createLinkedList(btree));