def proc(ip):
    nums = ip.split('.')
    out = ''
    for i in range(len(nums)):
        str = nums[i]
        if i < len(nums) - 1:
            str += "[.]"
        out += str
    print("Input:", ip)
    print("Output:", out)

ip = "1.1.1.1"
proc(ip)
ip = "255.101.1.0"
proc(ip)
