def divisible_pairs(arr, k):
  count = 0
  for i in range(0, len(arr)):
    for j in range(i+1, len(arr)):
      if (arr[i] + arr[j]) % k == 0: count += 1
  return count

print(divisible_pairs([4,5,1,6], 2));
print(divisible_pairs([1,2,3,4], 2));
print(divisible_pairs([1,3,4,5], 3));
print(divisible_pairs([5,1,2,3], 4));
print(divisible_pairs([7,2,4,5], 4));
