#!/usr/bin/env python

# run <script>

dct = {
    100: (4,1210),
    136: (4,2020),
    1425: (5,21200),
}

for k in dct.keys():
    print(f"Base 10: {k}")
    print(f"Base {dct[k][0]}: {dct[k][1]}\n")
