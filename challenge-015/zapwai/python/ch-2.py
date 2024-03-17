def vigenere(mode, key, msg):
    alph = "abcdefghijklmnopqrstuvwxyz"
    q = len(msg) / len(key)
    while (q > 0):
        key += key
        q -= 1
    while len(key) > len(msg):
        key = key[:-1]
    msg_letters = list(msg)
    key_letters = list(key)
    rots = []
    for i in key_letters:
        rots.append(alph.index(i))
    ans_letters = []
    for i in range(len(msg_letters)):
        if not msg_letters[i].isalpha():
            ans_letters.append(msg_letters[i])
            continue
        v = alph.index(msg_letters[i])
        if mode == 0:
            x = (v + rots[i]) % 26
        else:
            x = (v - rots[i]) % 26
        let = alph[x:x+1]
        ans_letters.append(let)
    return ''.join(ans_letters)
msg = "hello world"
key = "test"
enc = vigenere(0, key, msg)
dec = vigenere(1, key, enc)
print(enc)
print(dec)
