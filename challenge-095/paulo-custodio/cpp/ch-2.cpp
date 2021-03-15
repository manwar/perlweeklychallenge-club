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

#include <iostream>
#include <vector>

class Stack {
public:
    void push(int n) { data.push_back(n); }
    void pop() { data.pop_back(); }
    int top() { return data.back(); }
    int min() {
        int m = data.front();
        for (auto& d : data)
            if (m > d)
                m = d;
        return m;
    }
private:
    std::vector<int> data;
};

int main() {
    Stack s;                            // my $stack = Stack->new;
    s.push(2);                          // $stack->push(2);
    s.push(-1);                         // $stack->push(-1);
    s.push(0);                          // $stack->push(0);
    s.pop();                            // $stack->pop;       # removes 0
    std::cout << s.top() << std::endl;  // print $stack->top; # prints -1
    s.push(0);                          // $stack->push(0);
    std::cout << s.min() << std::endl;  // print $stack->min; # prints -1
}
