### https://theweeklychallenge.org/blog/perl-weekly-challenge-236/
"""

Task 1: Exact Change

Submitted by: [45]Mohammad S Anwar
     __________________________________________________________________

   You are asked to sell juice each costs $5. You are given an array of
   bills. You can only sell ONE juice to each customer but make sure you
   return exact change back. You only have $5, $10 and $20 notes. You do
   not have any change in hand at first.

   Write a script to find out if it is possible to sell to each customers
   with correct change.

Example 1

Input: @bills = (5, 5, 5, 10, 20)
Output: true

From the first 3 customers, we collect three $5 bills in order.
From the fourth customer, we collect a $10 bill and give back a $5.
From the fifth customer, we give a $10 bill and a $5 bill.
Since all customers got correct change, we output true.

Example 2

Input: @bills = (5, 5, 10, 10, 20)
Output: false

From the first two customers in order, we collect two $5 bills.
For the next two customers in order, we collect a $10 bill and give back a $5 bi
ll.
For the last customer, we can not give the change of $15 back because we only ha
ve two $10 bills.
Since not every customer received the correct change, the answer is false.

Example 3

Input: @bills = (5, 5, 5, 20)
Output: true

Task 2: Array Loops
"""
### solution by pokgopun@gmail.com

def sellable(pays):
    bills = dict.fromkeys((20, 10, 5), 0)
    #print(bills)
    for pay in pays:
        #print(f'pay = {pay}')
        if pay not in bills: return False
        bills[pay] += 1
        pay -= 5
        for bill in bills:
            if bill > pay: continue
            if bills[bill] > 0:
                count = pay // bill
                if count > bills[bill]:
                    pay -= bill*bills[bill]
                    bills[bill] = 0
                    continue
                else:
                    bills[bill] -= count
                    pay -= bill*count
                    continue
        #print(bills)
        if pay > 0: return False
    return True

for inpt, otpt in {
        (5, 5, 5, 10, 20): True,
        (5, 5, 10, 10, 20): False,
        (5, 5, 5, 20): True,
        }.items():
    print(sellable(inpt)==otpt)
