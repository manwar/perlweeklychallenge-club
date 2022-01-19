#!/usr/bin/python3

# Challenge 027
#
# Task #2
# Write a script that allows you to capture/display historical data. It could
# be an object or a scalar. For example
#
# my $x = 10; $x = 20; $x -= 5;
#
# After the above operations, it should list $x historical value in order.

class LoggingScalar:
    def __init__(self, value):
        self.values = [value]
    def set(self, value):
        self.values.append(value)
    def get(self):
        return self.values[-1]
    def show_hist(self):
        print(" ".join([str(x) for x in self.values]))

x = LoggingScalar(10)
x.set(20)
x.set(x.get()-5)
x.show_hist()
