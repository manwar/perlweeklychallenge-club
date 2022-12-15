def digital_clock(s):
  arr = list(s)
  if arr[0] == '?':
    if int(arr[1]) < 4:
      return 2
    else:
      return 1
  elif arr[1] == '?':
    if int(arr[0]) < 2:
      return 9
    else:
      return 3
  elif arr[3] == '?':
    return 5
  else:
    return 9
  
print(digital_clock('?5:00'))
print(digital_clock('?3:00'))
print(digital_clock('1?:00'))
print(digital_clock('2?:00'))
print(digital_clock('12:?5'))
print(digital_clock('12:5?'))

