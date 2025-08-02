from sys import argv

missing = set(range(1, len(argv))) - set(map(int, argv[1:]))
print(missing)
