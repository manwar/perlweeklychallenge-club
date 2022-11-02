import std/tables

proc arrayDegree(s:seq[int]) =
  var
    left = initTable[int,int]()
    count = initTable[int,int]()
    mx,mn,index,x:int
    
  for i in 0..<s.len:
    x = s[i]
    if x notin count:
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
    
  for i in index..<index+mn:
    stdout.write(s[i], ' ')
  echo ""
       
arrayDegree(@[1,3,3,2]);
arrayDegree(@[1,2,1,3]);
arrayDegree(@[1,3,2,1,2]);
arrayDegree(@[1,1,2,3,2]);
arrayDegree(@[2,1,2,1,1]);
