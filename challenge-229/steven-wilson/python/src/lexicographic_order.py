#!/usr/bin/env python3

def not_in_order ( elements ):
    not_in_order = []
    for elem in elements:
        elem_sorted = "".join(sorted(elem))
        elem_reverse_sorted = "".join(sorted(elem, reverse=True))
        if not ((elem == elem_sorted) or (elem == elem_reverse_sorted)):
            not_in_order.append(elem)
            elements.remove(elem)
    print(elements)
    return len(not_in_order)
