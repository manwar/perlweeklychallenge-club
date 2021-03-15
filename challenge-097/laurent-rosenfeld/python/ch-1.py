ALPHA_COUNT = 26
MIN = ord('A')

input_string = "THE QUICK BROWN FOR JUMPS OVER THE LAZY DOG"
shift = 3
out = ""
for char in input_string:
    if 'A' <= char <= 'Z':
        asc_code = ord(char) - shift
        if asc_code < MIN:
            asc_code += ALPHA_COUNT
        out += chr(asc_code)
    else:
        out += char
print(out)
