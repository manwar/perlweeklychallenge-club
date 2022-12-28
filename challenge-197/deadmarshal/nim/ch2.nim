proc wiggleSort(s:var seq[int]) =
  for i in 0..s.len-2:
    if (i mod 2 == 0) == (s[i] > s[i+1]): swap(s[i], s[i+1])

var
  s1:seq[int] = @[1,5,1,1,6,4]
  s2:seq[int] = @[1,3,2,2,3,1]

wiggleSort(s1)
wiggleSort(s2)
echo s1
echo s2

