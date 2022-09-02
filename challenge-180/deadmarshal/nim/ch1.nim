import strutils,os,strformat

proc FirstUniqueCharacter(Str:string):string =
  var
    Chars:seq[char]
    Hash:array[255,int]

  for I in 0..pred(Str.len):
    Chars.add(Str[I])
  for I in 0..Chars.len-1:
    Hash[ord(Chars[I])] = Hash[ord(Chars[I])] + 1
  for I in 0..Chars.len-1:
    if Hash[ord(Chars[I])] == 1:
      result = &"{I} as {Chars[I]} is the first unique character"
      break
    
proc main() =
  if paramcount() != 1:
    stderr.writeLine("No arg(s) provded!")
    quit(1)
  echo FirstUniqueCharacter(paramstr(1))
  
main()
