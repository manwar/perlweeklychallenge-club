proc hIndex(s:seq[int]):int =
  for i in 0..<s.len:
    if i >= s[i]: return i
    
echo hIndex(@[10,8,5,4,3])
echo hIndex(@[25,8,5,3,3])

