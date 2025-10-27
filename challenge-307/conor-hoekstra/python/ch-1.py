import numpy as np


def check_order(lst):
    return [c for c, (a, b) in enumerate(zip(lst, sorted(lst))) if a != b]


# NumPy Solution
def check_order_np(lst):
    l = np.array(lst)
    return np.where(l != sorted(l))[0]
