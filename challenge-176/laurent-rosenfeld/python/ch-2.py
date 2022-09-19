from re import search
pattern = r"[02468]"
for i in range(1, 100):
    tested = str(i + int(str(i)[::-1]))
    if not search(pattern, tested):
        print(i, end=' ')
