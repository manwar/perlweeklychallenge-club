#!/usr/bin/env python
# -*- coding: utf-8 -*-


# Define a function to add two numbers
def add(a, b):
    return a + b


# Define a function to subtract two numbers
def subtract(a, b):
    return a - b


# Define a function to multiply two numbers
def multiply(a, b):
    return a * b


# Define a function to divide two numbers
def divide(a, b):
    return a / b


# Define a dispatch table that maps operation names to functions
operation_table = {
    "add": add,
    "subtract": subtract,
    "multiply": multiply,
    "divide": divide,
}


# Define a function that takes an operation name and two numbers, and performs the operation
def perform_operation(operation, a, b):
    if operation in operation_table:
        return operation_table[operation](a, b)
    else:
        raise ValueError(f"Unknown operation '{operation}'")


# Test the dispatch table by performing some operations
print(perform_operation("add", 2, 3))  # Output: 5
print(perform_operation("subtract", 5, 1))  # Output: 4
print(perform_operation("multiply", 4, 6))  # Output: 24
print(perform_operation("divide", 10, 2))  # Output: 5
