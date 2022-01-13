#!/usr/bin/python3

# Challenge 018
#
# Task #2
# Write a script to implement Priority Queue. It is like regular queue except
# each element has a priority associated with it. In a priority queue, an
# element with high priority is served before an element with low priority.
# Please check this wiki page for more informations. It should serve the
# following operations:
#
# is_empty: check whether the queue has no elements.
# insert_with_priority: add an element to the queue with an associated priority.
# pull_highest_priority_element: remove the element from the queue that has the
# highest priority, and return it. If two elements have the same priority,
# then return element added first.

# priority queue
class PQueue():
    def __init__(self):
        self.q = []

    def is_empty(self):
        return len(self.q)==0

    def insert(self, pri, elem):
        if self.is_empty():
            self.q.append([pri, [elem]])
        elif pri < self.q[0][0]:
            self.q.insert(0, [pri, [elem]])
        elif pri > self.q[-1][0]:
            self.q.append([pri, [elem]])
        else:
            for i in range(0, len(self.q)):
                if self.q[i][0] == pri:
                    self.q[i][1].append(elem)
                    return
                elif self.q[i][0] > pri:
                    self.q.insert(i, [pri, [elem]])
                    return

    def pull(self):
        if self.is_empty():
            return None
        else:
            elem = self.q[-1][1].pop(0)
            if len(self.q[-1][1]) == 0:
                self.q.pop(-1)
            return elem

# tests
test_num = 0

def ok(f, title):
    global test_num
    test_num += 1
    if f:
        print(f"ok {test_num} - {title}")
    else:
        print(f"nok {test_num} - {title}")

def eq(a, b, title):
    ok(a==b, title)
    if a!=b:
        print("#", a, "!=", b)

def done_testing():
    print(f"1..{test_num}")


# run tests
q = PQueue()

ok(q.is_empty(), "is empty")
ok(q.pull() is None, "pull from empty queue")

# insert same priority
q.insert(1, 123)
ok(not q.is_empty(), "is not empty")

q.insert(1, 456)
ok(not q.is_empty(), "is not empty")

q.insert(1, 789)
ok(not q.is_empty(), "is not empty")

# pull
eq(q.pull(), 123, "got element")
ok(not q.is_empty(), "is not empty")

eq(q.pull(), 456, "got element")
ok(not q.is_empty(), "is not empty")

eq(q.pull(), 789, "got element")
ok(q.is_empty(), "is empty")

# insert higher priority
q.insert(1, 123)
q.insert(1, 456)
q.insert(2, 23)
q.insert(3, 4)

# insert lower priority
q.insert(0, 999)
q.insert(0, 998)

eq(q.pull(), 4, "got element")
eq(q.pull(), 23, "got element")
eq(q.pull(), 123, "got element")
eq(q.pull(), 456, "got element")
eq(q.pull(), 999, "got element")
eq(q.pull(), 998, "got element")
ok(q.is_empty(), "is empty")

done_testing()
