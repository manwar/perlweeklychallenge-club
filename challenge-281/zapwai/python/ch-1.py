def proc(coord):
    print("Input:", coord)
    a = list(coord)
    l = a[0]
    n = int(a[1])
    if l == "a" or l == "c" or l == "e" or l == "g":
        if n % 2 == 0:
            print("Output: True")
        else:
            print("Output: False")
    else:
        if n % 2 == 1:
            print("Output: True")
        else:
            print("Output: False")

coord = "d3"
proc(coord)
coord = "g5"
proc(coord)
coord = "e6"
proc(coord)

