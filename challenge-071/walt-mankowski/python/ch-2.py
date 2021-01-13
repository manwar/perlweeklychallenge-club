from sys import argv

class Node:
    def __init__(self, val):
        self.val = val
        self.next = None

    def len(self):
        node = self
        l = 0
        while node.next:
            l += 1
            node = node.next
        return l

def make_list(head, a):
    node = head
    for i in a:
        node.next = Node(i)
        node = node.next

def print_list(head):
    node = head.next
    while node:
        print(node.val, end='')
        if node.next:
            print(' -> ', end='')
        node = node.next
    print()

def remove_from_end(head, n):
    pos = head.len()
    node = head
    while pos > n:
        node = node.next
        pos -= 1
    node.next = node.next.next
    
N = int(argv[1])
head = Node(None)
make_list(head, range(1, 6))
print_list(head)
remove_from_end(head, N)
print_list(head)
