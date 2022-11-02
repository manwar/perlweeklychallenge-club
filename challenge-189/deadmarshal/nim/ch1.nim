import std/algorithm

proc greaterCharacter(s:var seq[char];target:char):char =
  s.sort()
  for i in 0..<s.len:
    if s[i] > target: return s[i]
  return target

var
  s1 = @['e','m','u','g']
  s2 = @['d','c','e','f']
  s3 = @['j','a','r']
  s4 = @['d','c','a','f']
  s5 = @['t','g','a','l']
  
echo greater_character(s1,'b')
echo greater_character(s2,'a')
echo greater_character(s3,'o')
echo greater_character(s4,'a')
echo greater_character(s5,'v')
