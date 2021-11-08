#!/usr/bin/env python3

# would want to pass an array reference, but 
# haven't found how you can do that in Python.
# It might not be possible.
output=[]

def main():
    pandigital()

def pandigital():
    # because we see 0123 as 123, we cannot start
    # with 0, so we force the issue by starting with 
    # one
    state=["1"]
    _pandigital(state)
    for o in output:
        print( o )

def _pandigital(state):
    # we're dumping to a global array 
    # so we can know when we've hit five
    # and can just bail
    if len(output)>4:
        return
    # if length is 10, we've used all the
    # digits and can convert the array of
    # digits into a number and append that
    # to output
    if len(state)==10:
        pandigital = int("".join(list(state)))
        output.append(pandigital)
        return
    # dicts are like hashes and useful to 
    # keep you from using the same thing twice
    # (asterisk)
    mydict = {}
    numbers = []
    # thing is, join wants a string, so we have
    # to always treat the digits as strings, and
    # so we must cast to string before adding to
    # the dictionary
    for n in state:
        mydict[str(n)] = 1
    # and also here, so we know that once we've
    # used 0, we don't use it again
    for n in range(10):
        if str(n) not in mydict:
            numbers.append(str(n))
    # and here, we copy the current state array,
    # append what numbers we have, and recurse
    for n in numbers:
        newstate = state.copy()
        newstate.append(n)
        _pandigital(newstate)
    return 

if __name__ == '__main__':
    main()