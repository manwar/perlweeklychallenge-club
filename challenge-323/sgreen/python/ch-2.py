#!/usr/bin/env python3

import sys


def tax_amount(income, tax_brackets: list) -> float:
    """
    Calculate the total tax amount based on income and tax brackets.
    :param income: The income for which tax is to be calculated
    :param tax_brackets: A list of tax brackets, where each bracket is a list containing
                         the upper limit of the bracket and the tax rate for that bracket.
    :return: The total tax amount as a Decimal
    """
    # Check income does not exceed the last tax bracket
    if income > tax_brackets[-1][0]:
        raise ValueError("Income exceeds the last tax bracket limit.")

    # Add a zero tax bracket
    tax_brackets.insert(0, [0, 0])

    # Initialize total tax amount
    total_tax = 0

    # Iterate through tax brackets
    for idx in range(1, len(tax_brackets)):
        tax_threshold, tax_rate = tax_brackets[idx]
        total_tax += (min(income, tax_threshold) - tax_brackets[idx - 1][0]) * (tax_rate / 100)

        # We don't need to look at further brackets if income is less than
        #  or equal to the current threshold
        if income <= tax_threshold:
            break

    return round(total_tax, 2)

def main():
    # Convert input into floating point numbers
    array = [float(n) for n in sys.argv[1:]]

    if len(array) < 3 or len(array) % 2 == 0:
        raise ValueError("Input must contain at least one income and at least one tax bracket.")
    income = array[0]
    tax_brackets = [array[i:i + 2] for i in range(1, len(array), 2)]

    result = tax_amount(income, tax_brackets)
    print(result)


if __name__ == '__main__':
    main()
