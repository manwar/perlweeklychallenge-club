#!/usr/bin/env python
# -*- coding: utf-8 -*-

def number_to_excel_column(num: int) -> str:
    column = ""
    while num > 0:
        num -= 1
        column = chr((num % 26) + ord("A")) + column
        num //= 26
    return column

def excel_column_to_number(column: str) -> int:
    num = 0
    for char in column:
        num = num * 26 + (ord(char) - ord("A") + 1)
    return num

if __name__ == "__main__":
    input_number = 28
    print(f"Input Number: {input_number}")
    output_column = number_to_excel_column(input_number)
    print(f"Output: {output_column}")

    input_column = "AD"
    print(f"Input Column Name: {input_column}")
    output_number = excel_column_to_number(input_column)
    print(f"Output: {output_number}")
