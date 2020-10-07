from sys import argv

def is_base(prefix, s):
    cnt = int(len(s) / len(prefix))
    return prefix * cnt == s

a, b = argv[1:]
max_base_len = min(len(a), len(b))

for i in range(1, max_base_len+1):
    prefix = a[0:i]
    if is_base(prefix, a) and is_base(prefix, b):
        print(prefix)
