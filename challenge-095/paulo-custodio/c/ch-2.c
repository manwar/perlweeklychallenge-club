/*
Challenge 095

TASK #2 › Demo Stack
Submitted by: Mohammad S Anwar
Write a script to demonstrate Stack operations like below:

push($n) - add $n to the stack
pop() - remove the top element
top() - get the top element
min() - return the minimum element

Example:
my $stack = Stack->new;
$stack->push(2);
$stack->push(-1);
$stack->push(0);
$stack->pop;       # removes 0
print $stack->top; # prints -1
$stack->push(0);
print $stack->min; # prints -1
*/

#include <stdio.h>

#define STACK_SIZE 100

typedef struct Stack {
    int data[STACK_SIZE];
    int sp;
} Stack;

void stack_init(Stack* s) {
    s->sp = -1;
}

void stack_push(Stack* s, int n) {
    s->data[++s->sp] = n;
}

void stack_pop(Stack* s) {
    s->sp--;
}

int stack_top(Stack* s) {
    return s->data[s->sp];
}

int stack_min(Stack* s) {
    int min = s->data[0];
    for (int i=1; i<=s->sp; i++)
        if (min > s->data[i])
            min = s->data[i];
    return min;
}

int main() {
    Stack s;
    stack_init(&s);                 // my $stack = Stack->new;
    stack_push(&s, 2);              // $stack->push(2);
    stack_push(&s, -1);             // $stack->push(-1);
    stack_push(&s, 0);              // $stack->push(0);
    stack_pop(&s);                  // $stack->pop;       # removes 0
    printf("%d\n", stack_top(&s));  // print $stack->top; # prints -1
    stack_push(&s, 0);              // $stack->push(0);
    printf("%d\n", stack_min(&s));  // print $stack->min; # prints -1
}
