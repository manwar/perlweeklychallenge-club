#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def can_sell_with_exact_change(bills: List[int]) -> bool:
    """
    Determines if it is possible to sell juice to each customer with exact change.

    Args:
    - bills (List[int]): List of bills from customers.

    Returns:
    - bool: True if it is possible to give exact change to each customer, False otherwise.
    """
    five, ten = 0, 0  # Initialize counters for $5 and $10 bills

    # Loop through each bill in the list
    for bill in bills:
        if bill == 5:
            five += 1  # No change needed, just collect the $5 bill
        elif bill == 10:
            if five == 0:  # Need a $5 bill to give change
                return False
            five -= 1  # Give a $5 bill as change
            ten += 1  # Collect the $10 bill
        else:  # bill is $20
            if ten > 0 and five > 0:  # First option to give change
                ten -= 1
                five -= 1
            elif five >= 3:  # Second option to give change
                five -= 3
            else:
                return False  # Can't give change

    return True  # All customers received exact change


# Test cases
print(can_sell_with_exact_change([5, 5, 5, 10, 20]))  # Should return True
print(can_sell_with_exact_change([5, 5, 10, 10, 20]))  # Should return False
print(can_sell_with_exact_change([5, 5, 5, 20]))  # Should return True
