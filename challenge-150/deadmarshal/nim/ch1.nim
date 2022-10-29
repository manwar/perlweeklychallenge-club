import std/strutils

proc fibonacci_words(a,b:string):int =
  var s:seq[string] = @[a,b]
  while s[s.high].len < 52:
    s.add(s[s.high-1] & s[s.high])
  return parseInt($s[s.high][50])
  
echo fibonacci_words("1234", "5678")
