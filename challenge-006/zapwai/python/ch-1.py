def proc(list):
    print("Input: list = ", list)
    print("Output: ", end='')
    
    init_flag = False
    cont_flag = False
    
    for i in range(-1 + len(list)):
        diff = list[i+1] - list[i]
        if (init_flag and cont_flag):
            if (diff != 1):
                init_flag = False
                cont_flag = False
                print("-", list[i], end='', sep='')
                
        elif (init_flag):
            if (diff == 1):
                cont_flag = True
            else:
                init_flag = False
                print(",", list[i], end='')

        else:
            if (i != 0):
                print(", ", end='')
            print(list[i], end='')
            if (diff == 1):
                init_flag = True
    if (init_flag and cont_flag):
        print("-", list[len(list) -  1], sep='')
    else:
        print(", ", list[len(list)- 1])
                        
list = [1,2,3,4,9,10,14,15,16]
proc(list)
