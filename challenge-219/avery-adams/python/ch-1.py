#!/usr/bin/python

list = [int(input("Num1:")), int(input("Num2:")), int(input("Num3:")), int(input("Num4:")), int(input("Num5:"))]
for index in range(len(list)):
    list[index] = list[index] ** 2
list.sort()
for square in list:
    print(square)
