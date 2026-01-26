#!/usr/bin/env python3
def kaprekar_steps(n: int) -> int:
    if n == 6174:
        return 0
    
    seen = set()
    steps = 0
    
    while n != 0 and n not in seen:
        seen.add(n)
        
        s = f"{n:04d}"
        desc = int(''.join(sorted(s, reverse=True)))
        asc = int(''.join(sorted(s)))
        
        n = desc - asc
        steps += 1
        
        if n == 6174:
            return steps
    
    return -1

def show_iterations(input_num: int, expected_steps: int):
    print(f"Input: {input_num}")
    print(f"Output: {kaprekar_steps(input_num)}")
    
    steps = kaprekar_steps(input_num)
    if steps == 0 or steps == -1:
        print()
        return
    
    print("Iteration 1: ", end="")
    current = input_num
    step = 1
    
    while current != 6174 and step <= expected_steps:
        s = f"{current:04d}"
        desc_list = sorted(s, reverse=True)
        asc_list = sorted(s)
        
        desc_num = int(''.join(desc_list))
        asc_num = int(''.join(asc_list))
        next_num = desc_num - asc_num
        
        print(f"{desc_num:04d} - {asc_num:04d} = {next_num:04d}", end="")
        
        current = next_num
        step += 1
        
        if current != 6174:
            print("\nIteration", step, ":", end=" ")
        else:
            print()
    
    print()

examples = [3524, 6174, 9998, 1001, 9000, 1111]
expected = [3, 0, 5, 4, 4, -1]

for i in range(len(examples)):
    show_iterations(examples[i], expected[i])
