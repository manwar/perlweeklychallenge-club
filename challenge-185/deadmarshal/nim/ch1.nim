import std/sequtils,strutils

proc mac_address(str:string):string =
  var
    s = filter(toSeq(str.items), proc(c:char):bool = c != '.')
    ret:seq[string] = @[]   
  for i in countUp(0, s.len-2, 2):
    ret.add(s[i] & s[i+1])    
  return ret.join(":")

echo mac_address("1ac2.34f0.b1c2")
echo mac_address("abc1.20f1.345a")
