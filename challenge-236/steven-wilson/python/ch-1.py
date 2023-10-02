#!/usr/bin/env python3

JUICE_PRICE = 5


def correct_change_to_each(transactions):
    """ Can correct change be given to each customer
    >>> correct_change_to_each([5, 5, 5, 10, 20])
    True
    >>> correct_change_to_each([5, 5, 10, 10, 20])
    False
    >>> correct_change_to_each([5, 5, 5, 20])
    True
    """
    in_hand = []
    for transaction in transactions:
        if transaction > JUICE_PRICE:
            change = transaction - JUICE_PRICE
            bills = correct_change(change, in_hand)
            if bills == []:
                return False
            else:
                for bill in bills:
                    in_hand.remove(bill)
        in_hand.append(transaction)
    return True


def correct_change(change, bills):
    """ Returns the bills required to give correct change or empty list 
    if not possible
    >>> correct_change(5, [5, 5, 5])
    [5]
    >>> correct_change(15, [5, 5, 10])
    [5, 10]
    >>> correct_change(15, [10, 10])
    []
    >>> correct_change(15, [5, 5, 5])
    [5, 5, 5]
    >>> correct_change(10, [])
    []
    """
    give = []
    bills.sort(reverse=True)
    for bill in bills:
        if (change - bill + sum(give)) >= 0:
            give.append(bill)
        if (sum(give) == change):
            return sorted(give)
    return []


if __name__ == "__main__":
    import doctest

    doctest.testmod()
