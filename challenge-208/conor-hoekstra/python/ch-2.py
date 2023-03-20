
from collections import Counter, defaultdict

def find_duplicate(nums):
    return defaultdict(lambda:-1, map(reversed, Counter(nums).items()))[2]

print(find_duplicate([1,2,2,4])) # 2
print(find_duplicate([1,2,3,4])) # -1
print(find_duplicate([1,2,3,3])) # 3
