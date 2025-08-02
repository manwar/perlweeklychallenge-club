alph = "abcdefghijklmnopqrstuvwxyz"

def proc(string, widths):
    print("Input: string =", string,"\n widths =", widths)
    pixwidth = 100
    width = pixwidth
    lines = 1
    for s in list(string):
        w = widths[alph.index(s)]
        if width - w < 0:
            lines += 1
            width = pixwidth
        width -= w
    print("Output:", lines, (pixwidth - width))

string = "abcdefghijklmnopqrstuvwxyz"
widths = [10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
proc(string, widths)

string = "bbbcccdddaaa"
widths = [4,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10,10]
proc(string, widths)
