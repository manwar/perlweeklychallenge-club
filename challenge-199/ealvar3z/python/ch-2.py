from itertools import combinations


def solve(arr, a, b, c):
    total = 0
    for i,j,k in combinations(arr,3):
        if ((abs(i-j) <= a) and 
            (abs(j-k) <= b) and 
            (abs(i-k) <= c)):
            total += 1
    return total


if __name__ == '__main__':
    test1 = [3, 0, 1, 1, 9, 7]
    test2 = [1, 1, 2, 2, 3]
    a, b, c = [7, 2, 3] 
    d, e, f = [0, 0, 1] 
    
    print("Output: ", solve(test1, a, b, c))
    print("Output: ", solve(test2, d, e, f))
