def product_sign(ints):
    z = list(filter(lambda x: x == 0, ints))
    if(len(z) > 0):
        return 0
    n = list(filter(lambda x: x < 0, ints))
    if(len(n) % 2 == 1):
        return -1 
    elif(len(n) > 0 and len(n) % 2 == 0):
        return 1 

ints = (-1, -2, -3, -4, 3, 2, 1)
print(product_sign(ints))  
ints = (1, 2, 0, -2, -1)
print(product_sign(ints)) 
ints = (-1, -1, 1, -1, 2)
print(product_sign(ints)) 
