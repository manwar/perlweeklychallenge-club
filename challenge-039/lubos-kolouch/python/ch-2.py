#!/usr/bin/env python
# -*- coding: utf-8 -*-


def evaluate_rpn(expression: str) -> float:
    stack = []

    for token in expression.split():
        if token in "+-*/":
            b = stack.pop()
            a = stack.pop()

            if token == "+":
                stack.append(a + b)
            elif token == "-":
                stack.append(a - b)
            elif token == "*":
                stack.append(a * b)
            else:  # token == "/"
                stack.append(a / b)
        else:
            stack.append(float(token))

    return stack[0]


if __name__ == "__main__":
    rpn_expression = "3 4 + 2 * 1 +"
    result = evaluate_rpn(rpn_expression)
    print(f"RPN expression: {rpn_expression}")
    print(f"Result: {result}")
