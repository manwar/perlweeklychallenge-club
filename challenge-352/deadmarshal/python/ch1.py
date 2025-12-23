def match_string(words):
  result = []
  n = len(words)
  for i in range(n):
    for j in range(n):
      if i != j and words[i] in words[j] and words[i] not in result:
        result.append(words[i])
        break
  return result

print(match_string(["cat","cats","dog","dogcat",
		    "dogcat","rat","ratcatdogcat"]))
print(match_string(["hello","hell","world","wor",
		    "ellow","elloworld"]))
print(match_string(["a", "aa", "aaa", "aaaa"]))
print(match_string(["flower","flow","flight","fl","fli","ig","ght"]))
print(match_string(["car","carpet","carpenter","pet",
		    "enter","pen","pent"]))

