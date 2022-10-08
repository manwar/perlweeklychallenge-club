import strutils

proc mask_code(strs:var seq[string]) =
  var
    count:int
  for str in mitems(strs):
    for c in mitems(str):
      if isAlphaNumeric(c):
        c = 'x'
        count += 1
      if count == 4: break
    count = 0

var
  list = @["ab-cde-123", "123.abc.420", "3abc-0010.xy"]
  list2 = @["1234567.a", "a-1234-bc", "a.b.c.d.e.f"]
  
mask_code(list)
mask_code(list2)
echo list
echo list2
