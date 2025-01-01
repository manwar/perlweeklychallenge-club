from itertools import combinations

def return_subset(strs: list[list], x: int, y: int) -> int | None:
    for r in range(len(strs) - 1, 1, -1):
        subsets = combinations(strs, r)
        for subset in subsets:
            total_zeros = 0
            total_ones = 0
            for element in subset:
                total_zeros += element.count('0')
                total_ones += element.count('1')
            if total_zeros <= x and total_ones <= y:
                return len(subset)
    return None
