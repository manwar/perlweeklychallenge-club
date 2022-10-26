proc divisible_pairs(s:seq[int];k:int):int =
  for i in 0..<s.len:
    for j in i+1..<s.len:
      if (s[i] + s[j]) mod k == 0: inc(result)
      
echo divisible_pairs(@[4,5,1,6], 2)
echo divisible_pairs(@[1,2,3,4], 2)
echo divisible_pairs(@[1,3,4,5], 3)
echo divisible_pairs(@[5,1,2,3], 4)
echo divisible_pairs(@[7,2,4,5], 4)
