WIDTH = 100

def line_counts(s, widths):
    width = 0
    line_count = 1
    for c in s:
        width = width + widths[ord(c) - ord("a")]
        if(width > WIDTH):
            width = widths[ord(c) - ord("a")]
            line_count = line_count + 1
    return line_count, width  

s = "abcdefghijklmnopqrstuvwxyz"
widths = (10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
print(line_counts(s, widths)) 
s = "bbbcccdddaaa"
widths = (4, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10)
print(line_counts(s, widths)) 
