import std/[strutils]
  
proc keyboardWord(strseq:var seq[string]):seq[string] =
  var
    s1:set[char] = {'q','w','e','r','t','y','u','i','o','p'}
    s2:set[char] = {'a','s','d','f','g','h','j','k','l'}
    s3:set[char] = {'z','x','c','v','b','n','m'}
  for s in strseq.mitems: s = toLowerAscii(s)
  for myset in [s1,s2,s3]:
    for s in strseq:
      if allCharsInSet(s,myset): result.add(s)
var
  s1:seq[string] = @["Hello","Alaska","Dad","Peace"]
  s2:seq[string] = @["OMG","Bye"]
    
echo keyboardWord(s1)
echo keyboardWord(s2)

