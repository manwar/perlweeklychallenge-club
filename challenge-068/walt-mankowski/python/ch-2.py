class Node:
    def __init__(self, val):
        self.val = val
        self.next = None

def make_list(a):
    L = Node(a[0])
    cur = L
    for val in range(1, len(a)):
        node = Node(a[val])
        cur.next = node
        cur = node
    return L

def print_list(L):
    while L:
        print(L.val, end='')
        if L.next:
            print(' => ', end='');
        L = L.next
    print()

def reorder_list(L):
    # save the list in an array
    a = []
    while L:
        a.append(L)
        L = L.next

    # now reorder things
    n = len(a)-1
    for i in range(0, int(n/2)):
        a[n-i].next = a[i].next
        a[i].next = a[n-i]
        a[n-i-1].next = None

L = make_list(range(1,11))
print_list(L)
reorder_list(L)
print_list(L)
