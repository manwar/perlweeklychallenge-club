
arrStr = ["abc", "bce", "cae"] ## Example 1
## arrStr = ["yxz", "cba", "mon"] ## Example 2

arrNotLexiOrder = [strLoop for strLoop in arrStr if strLoop != "".join(sorted(strLoop)) and strLoop != "".join(sorted(strLoop, reverse = True))]

print (len(arrNotLexiOrder))
