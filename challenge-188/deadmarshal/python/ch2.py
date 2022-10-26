def total_zero(x,y):
  count = 0
  while x > 0 and y > 0:
    if x >= y: x -= y
    else: y -= x
    count += 1
  return count

print(total_zero(5,4))
print(total_zero(4,6))
print(total_zero(2,5))
print(total_zero(3,1))
print(total_zero(7,4))

