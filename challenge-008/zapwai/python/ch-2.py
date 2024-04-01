def max(nums):
    m = 0
    for n in nums:
        if m < n:
            m = n
    return m

def center(words):
    lens = []
    for w in words:
        lens.append(len(w))
    M = max(lens)
    for i in range(len(words)):
        sp = ""
        k = M - len(words[i])
        for j in range(k):
            if j % 2 == 0:
                sp += " "
        print(sp, words[i])
        
words = ["This", "is", "a test of the", "center function"]
center(words)
