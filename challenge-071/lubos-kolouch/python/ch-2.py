class Node:
    def __init__(self, data=None):
        self.data = data
        self.next = None


class LinkedList:
    def __init__(self):
        self.head = None

    def append(self, data):
        if not self.head:
            self.head = Node(data)
        else:
            cur = self.head
            while cur.next:
                cur = cur.next
            cur.next = Node(data)

    def remove_from_end(self, n):
        if self.head is None:
            return
        size = 0
        cur = self.head
        while cur:
            size += 1
            cur = cur.next
        if n >= size:
            self.head = self.head.next if self.head.next else None
        else:
            cur = self.head
            for _ in range(size - n - 1):
                cur = cur.next
            cur.next = cur.next.next if cur.next and cur.next.next else None

    def __str__(self):
        values = []
        cur = self.head
        while cur:
            values.append(str(cur.data))
            cur = cur.next
        return ' -> '.join(values)


# Tests
ll = LinkedList()
for i in range(1, 6):
    ll.append(i)

for i in range(1, 7):
    ll.remove_from_end(i)
    print(ll)
