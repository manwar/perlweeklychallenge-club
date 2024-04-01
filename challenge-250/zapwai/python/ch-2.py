import re
def proc(a):
    nums = list( map( lambda x: len(x), a ) )
    pattern = r'\b(\d+)\b'
    for i in range(len(a)):
        if re.search(pattern,a[i]):
            nums[i] = int(re.search(pattern, a[i]).group(1))
    print("Input: ", a)
    print("Output: ", max(nums))
a = ("perl", "2", "000", "python", "r4ku");
proc(a)
a = ("001", "1", "000", "0001");
proc(a)
