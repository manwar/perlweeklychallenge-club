def divide(m, n):
    quotient, c = str(m // n) + ".", 10 * (m % n)
    while c and c < n:
        c *= 10
        quotient += "0"
    digits = ""
    passed = {}
    i = 0
    while True:
        if c in passed:
            prefix = digits[:passed[c]]
            cycle = digits[passed[c]:]
            result = quotient + prefix + "(" + cycle + ")"
            return result.replace("(0)", "").rstrip(".")
        q, r = c // n, c % n
        passed[c] = i
        digits += str(q)
        i += 1
        c = 10 * r
