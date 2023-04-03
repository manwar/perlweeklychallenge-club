def insert_operators(s, target):
    results = []

    def helper(s, expr):
        if not s:
            if eval(expr) == target:
                results.append(expr)
            return
        for i in range(1, len(s) + 1):
            left, right = s[:i], s[i:]
            helper(right, expr + "+" + left)
            helper(right, expr + "-" + left)

    helper(s, "")
    return results


results = insert_operators("123456789", 100)
for r in results:
    print(r)
