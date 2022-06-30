
## Remarks
## https://www.geeksforgeeks.org/first-class-functions-python/
## https://theweeklychallenge.org/blog/perl-weekly-challenge-171/


## Python Program to illustrate Functions can be Passed as Arguments to Other Functions
def getShout(strText):
    return strText.upper()


def getWhisper(strText):
    return strText.lower()


def getGreet(Func_1, Func_2):
    ## f = Func_1
    ## g = Func_2
    ## getGreet = h = compose(f, g)
    return Func_1(Func_2("Hi, I am created by a function passed as an argument."))


## Driver Code
if __name__ == '__main__':

    print (getGreet(getShout, getWhisper))

