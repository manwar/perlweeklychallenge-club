def proc(str1, str2):
    print(f"Input: str1 = {str1}, str2 = {str2}")
    n1 = len(str1)
    n2 = len(str2)
    if n1 < n2:
        m = n1
        ending = str2[m:]
    else:
        m = n2
        ending = str1[m:]
    print("Output: ", end='')
    for i in range(m):
        print(str1[i]+str2[i], end='')
    print(ending)
str1 = "abcd"; str2 = "1234"
proc(str1, str2)
str1 = "abc"; str2 = "12345"
proc(str1, str2)
str1 = "abcde"; str2 = "123"
proc(str1, str2)
