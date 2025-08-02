def print_input(items1, items2):
    print("Input: ", items1, items2)

def print_output(h):
    print("Output: ", end='')
    for i in h.keys():
        print('[', i, ', ', h[i], sep='', end='] ')
    print()
    
def proc(items1, items2):
    print_input(items1, items2)
    h = {}
    for i in items1:
        h[i[0]] = 0
    for i in items2:
        h[i[0]] = 0
    for i in items1:
        h[i[0]] += i[1]
    for i in items2:
        h[i[0]] += i[1]
    print_output(h)

items1c = [ [1,1], [2,1], [3,2] ]
items2c = [ [2,2], [1,3] ]
items1a = [ [1,2], [2,3], [1,3], [3,2] ]
items2a = [ [3,1], [1,3] ]
items1b = [ [1,1], [2,2], [3,3] ]
items2b = [ [2,3], [2,4] ]
proc(items1c, items2c)
proc(items1a, items2a)
proc(items1b, items2b)
