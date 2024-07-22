def proc(l, w):
    print("Input: letters =", l, "weights =", w)
    ans = []
    for i in range(len(l)):
        ans.append("")
    for i in range(len(l)):
        ans[w[i] - 1] = l[i]
    print("Output: ", ans)

letters = ['R', 'E', 'P', 'L']
weights = [3, 2, 1, 4]
proc(letters, weights)
letters = ['A', 'U', 'R', 'K']
weights = [2, 4, 1, 3]
proc(letters, weights)
letters = ['O', 'H', 'Y', 'N', 'P', 'T']
weights = [5, 4, 2, 6, 1, 3]
proc(letters, weights)
