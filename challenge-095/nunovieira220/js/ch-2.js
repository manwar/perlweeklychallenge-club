// Stack class
class Stack {
  constructor() {
    this.stack = [];
  }

  push(elem) {
    this.stack.push(elem);
  }

  pop() {
    return this.stack.pop();
  }

  top() {
    return this.stack[this.stack.length - 1];
  }

  min() {
    return Math.min(...this.stack);
  }

  toString() {
    console.log(this.stack);
  }
}

// Input
const stack = new Stack();
stack.push(2);
stack.push(-1);
stack.push(0);
stack.pop();     // removes 0
console.log(stack.top()); // prints -1
stack.push(0);
console.log(stack.min()); // prints -1
stack.toString();