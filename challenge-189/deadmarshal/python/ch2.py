def array_degree(arr):
  left,count = {},{}
  mx,mn,index = 0,0,0
  for i in range(0,len(arr)):
    x = arr[i]
    if x not in count:
      left[x] = i
      count[x] = 1
    else: count[x] += 1

    if count[x] > mx:
      mx = count[x]
      mn = i - left[x] + 1
      index = left[x]
    elif count[x] == mx and i - left[x] + 1 < mn:
      mn = i - left[x] + 1
      index = left[x]
      
  for i in range(index,index+mn):
    print(arr[i], end=' ')
  print()
  
array_degree([1,3,3,2])
array_degree([1,2,1,3])
array_degree([1,3,2,1,2])
array_degree([1,1,2,3,2])
array_degree([2,1,2,1,1])

