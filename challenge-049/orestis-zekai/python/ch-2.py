capacity = 3
cache = [None for x in range(capacity)]
print(cache)

def get(pos):
	global cache
	if (pos > capacity - 1):
		return -1
	val = cache[pos-1]
	shift(pos)
	return val


def set(pos, n):
	global cache
	cache[pos-1] = n


def shift(pos1):
	global cache
	temp = cache.pop(pos1-1)
	cache.append(temp)


set(1, 3)
print(cache)
set(2, 5)
print(cache)
set(3, 7)
print(cache)

print(get(2))
print(cache)
print(get(1))
print(cache)
print(get(9))
print(cache)