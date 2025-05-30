#!/usr/bin/env python

def fmt(num):
  if num > 0:
    # display to 100ths place
    return '{:0.2f}'.format(num)
  else:
    # format it as a string
    return f"{int(num)}"

def taxAmt(income, tax):
  if income == 0:
    return 0, "" # special case

  last_max = 0
  total = 0
  operations = []
  subtotals = []
  for max_income, rate in tax:
    # adjust the maximum amount at this rate
    # to be relative to the last rate
    max_income -= last_max
    # the amount to be taxed at this rate
    amt = min(income, max_income)
    tax = amt * rate/100
    total += tax
    # make sure we display to 100ths place
    # if we hace a non-zero tax amount
    tax = fmt(tax)
    # save the steps so we can display them at the end
    operations.append(f"({amt} * {rate}/100)")
    subtotals.append(tax)
    # we've just taxed $amt, so remove it from $income
    income -= amt
    # adjust the last rate for the next loop
    last_max += max_income
    # bail if there's no more income
    if income <= 0: break

  return (
    total,
    "Total Tax => " + ' + '.join(operations) + "\n" +
    "          => " + ' + '.join(subtotals) + "\n" +
    "          => " + fmt(total)
  )

def solution(income, tax):
  brackets = [ f"[{t[0]},{t[1]}]" for t in tax ]
  display = ", ".join(brackets)
  print(f'Input: $income = {income}, @tax = ({display})')
  output, explain = taxAmt(income, tax)
  print(f'Output: {output}\n\n{explain}')


print('Example 1:')
solution(10, [[3, 50], [7, 10], [12,25]])

print('\nExample 2:')
solution(2, [[1, 0], [4, 25], [5,50]])

print('\nExample 3:')
solution(0, [[2, 50],])
