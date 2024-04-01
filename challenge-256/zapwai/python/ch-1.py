def proc(words):
    print("Input:", words)
    cnt = 0
    for i in range(len(words)-1):
        for j in range(i+1, len(words)):
            if words[i] == words[j][::-1]:
                cnt += 1
    print("Output:", cnt)
words = ['ab', 'de', 'ed', 'bc']
proc(words)
words = ['aa', 'ba', 'ed', 'cd']
proc(words)
words = ['uv', 'qp', 'st', 'vu', 'mn', 'pq']
proc(words)
