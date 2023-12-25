#! /usr/bin/python3
class DiStringMatch:
    def __init__(self):
        self.p = [0]
        self.mx = 1

    def process(self, s):
        def inc():
            self.p.append(self.mx)
            self.mx += 1

        def dec():
            self.p = [x + 1 for x in self.p]
            self.mx += 1
            self.p.append(0)

        for ch in s:
            inc() if ch == 'I' else dec()
        return self.p

assert DiStringMatch().process('IDID') == [2, 3, 1, 4, 0]
assert DiStringMatch().process('III')  == [0, 1, 2, 3]
assert DiStringMatch().process('DDI')  == [2, 1, 0, 3]
