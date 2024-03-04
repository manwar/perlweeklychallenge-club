def proc(line):
    if line[0] == '{':
        line = line[3:-3]
        name = line.split("=")[0].split()[0]
        if name[0:3] == "end":
            return
        line = line[len(name)+1:]
        field = []
        chunk = line.split("=")
        for i in range(len(chunk) - 1):
            field.append(chunk[i].split().pop())
        value = []
        for i in range(1, len(chunk) - 1):
            s = chunk[i][:-len(field[i])]
            value.append(s)
        value.append(chunk[len(chunk)-1])
        print("Name =>", name)
        print("Fields =>")
        for i in range(len(field)):
            print("\t",field[i],"->",value[i])
        print()
    else:
        print("Text =>", line)
    

line1 = '{%  id   field1="value1"    field2="value2"  field3=42 %}'
line2 = '{%  youtube title="Title \"quoted\" done" foo="bar" baz=31 %}'
line3 = '{%  youtube title="Title with escaped backslash \\" %}'
line4 = '{% id field="val1" field2="val2" %}'
line5 = '{% test field1="value1" df=42 %}'
line6 = 'LINES'
line7 = 'More Lines'
line8 = '{% endtest %}'

lines = [line1, line2, line3, line4, line5, line6, line7, line8]

for line in lines:
    proc(line)
