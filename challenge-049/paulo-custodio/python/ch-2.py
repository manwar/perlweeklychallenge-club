#!/usr/bin/env python3

# Challenge 049
#
# TASK #2
# LRU Cache
# Write a script to demonstrate LRU Cache feature. It should support operations
# get and set. Accept the capacity of the LRU Cache as command line argument.
#
# Definition of LRU: An access to an item is defined as a get or a set operation
# of the item. "Least recently used" item is the one with the oldest access time.
#
# For example:
#
# capacity = 3
# set(1, 3)
# set(2, 5)
# set(3, 7)
#
# Cache at this point:
# [Least recently used] 1,2,3 [most recently used]
#
# get(2)      # returns 5
#
# Cache looks like now:
# [Least recently used] 1,3,2 [most recently used]
#
# get(1)      # returns 3
#
# Cache looks like now:
# [Least recently used] 3,2,1 [most recently used]
#
# get(4)      # returns -1
#
# Cache unchanged:
# [Least recently used] 3,2,1 [most recently used]
#
# set(4, 9)
#
# Cache is full, so pushes out key = 3:
# [Least recently used] 2,1,4 [most recently used]
#
# get(3)      # returns -1

class Cache():
    capacity = 0
    cache = []

    def __init__(self, capacity):
        self.capacity = capacity
        self.cache = []

    def __str__(self):
        out = ""
        for x in self.cache:
            out += "(" + str(x[0]) + "=>" + str(x[1]) + ")"
        return out

    def get(self, k):
        for i in range(len(self.cache)):
            if self.cache[i][0] == k:
                v = self.cache[i][1]
                self.cache = self.cache[0:i] + self.cache[i+1:]
                self.cache.append([k,v])
                return v
        return -1

    def set(self, k, v):
        found = self.get(k)
        if found == -1:
            self.cache.append([k,v])
            while len(self.cache) > self.capacity:
                self.cache = self.cache[1:]
        else:
            self.cache[-1][1] = v

print("Create cache, capacity=>3")
cache = Cache(3)
print("Cache="+str(cache))

print("Set cache:1,3")
cache.set(1, 3)
print("Cache="+str(cache))

print("Set cache:2,5")
cache.set(2, 5)
print("Cache="+str(cache))

print("Set cache:3,7")
cache.set(3, 7)
print("Cache="+str(cache))

print("Get cache 2=>"+str(cache.get(2)))
print("Cache="+str(cache))

print("Get cache 1=>"+str(cache.get(1)))
print("Cache="+str(cache))

print("Get cache 4=>"+str(cache.get(4)))
print("Cache="+str(cache))

print("Set cache:4,9")
cache.set(4, 9)
print("Cache="+str(cache))

print("Get cache 3=>"+str(cache.get(3)))
print("Cache="+str(cache))
