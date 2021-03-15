#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    let mut stack=Stack::new();
    stack.push(2);
    stack.push(-1);
    stack.push(0);
    assert_eq!(stack.pop(),0);
}

#[test]
fn test_ex2() {
    let mut stack=Stack::new();
    stack.push(2);
    stack.push(-1);
    stack.push(0);
    let _d=stack.pop();
    assert_eq!(stack.top(),-1);
}

#[test]
fn test_ex3() {
    let mut stack=Stack::new();
    stack.push(2);
    stack.push(-1);
    stack.push(0);
    let _d=stack.pop();
    stack.push(0);
    assert_eq!(stack.min(),-1);
}

pub struct Stack {
    stack: Vec<i64>
}

impl Stack {

    pub fn new() -> Stack {
        Stack { stack: Vec::new() }
    }

    pub fn push(&mut self,op: i64) {
        self.stack.push(op);
    }

    pub fn pop(&mut self) -> i64 {
        if self.stack.len() == 0 {
            println!("Insufficient elements for pop");
            std::process::exit(1);
        }
        return self.stack.pop().unwrap();
    }

    pub fn top(&mut self) -> i64 {
        if self.stack.len() == 0 {
            println!("Insufficient elements for top");
            std::process::exit(1);
        }
        return self.stack[self.stack.len()-1];
    }

    pub fn min(&mut self) -> i64 {
        if self.stack.len() == 0 {
            println!("Insufficient elements for top");
            std::process::exit(1);
        }
        return *self.stack.iter().min().unwrap();
    }

}
