tests = ["redivider", "rotors", "challenge"]
for test in tests
    find_palindromes(test)
next

func find_palindromes input
    see input + " : "
    seen = []
    for start = 1 to len(input)
        for length = 1 to len(input) - start
            cand = substr(input, start, length)
            if is_palindrome(cand) and not seen[cand]
                see cand + " "
                add(seen, cand)
            ok
        next
    next
    see " " + nl

func is_palindrome instr
    reverse = ""
    for i = len(instr) to 1 step -1
        reverse = reverse + instr[i]
    next
    return reverse = instr
