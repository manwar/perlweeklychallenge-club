import fileinput

stack = []
error = "Stack is empty"
for line in fileinput . input ():
    chunks  = line . split ()
    command = chunks [0]
    
    if command == "push":
        stack . append (int (chunks [1]))

    if command == "pop":
        if len (stack):
            stack . pop ()

    if command == "top":
        if len (stack):
            print stack [len (stack) - 1]
        else:
            print error

    if command == "min":
        if len (stack):
            print min (stack)
        else:
            print error
