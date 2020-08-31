# Python3
# Perl Weekly Challenge #075 Task 2 Largest Rectangle Histogram , Python script
# test cases:
# items = [3, 2, 3, 5, 7, 5] --> 15
# items = [2, 1, 4, 3, 5, 7] --> 12
# items = [1, 2, 3, 4, 5] --> 9

def largest_rectangle_histogram(items):
    max_item = max(items)

    subtract1 = lambda n: n-1 if n > 0 else 0

    temp = items + [0]  # put a zero at the end for ease

    histogram = []
    pair = []
    areas = []

    for i in range(max_item):
        histogram.append(temp)
        temp = list(map(subtract1, temp))

    histogram = histogram[::-1]



    for i in range(max_item):
        j = 0
        while j < length:
            if histogram[i][j] != 0:
                h = j
                k = j
                while True:
                    t = k
                    j = j+1
                    k = k+1
                    if histogram[i][k] == 0:
                        break
                if not([h,t] in pair):
                    areas.append( (t-h+1)*(max_item-i) )
                    pair.append([h,t])
            j = j+1
        histogram[i].pop(-1)   #pop out the assisting zero


    print("Answer:")
    print(max(areas))
    print()


    zeroornumsign = lambda x: "#" if x > 0 else " " 
    for i in range( max_item ):
        print(max_item-i, end=' ')
        templine = list(map(zeroornumsign, histogram[i]));
        for j in range(length):
            print(templine[j], end=' ')        
        print()
    print('  ', end='')
    print("_ " * length)
    print('  ', end='')
    for i in range(length):
        print(str(items[i]), end=' ')
    print()


if __name__ == "__main__":
    length = int(input("Enter number of items of the histogram: \n"))
    print("Enter items of the histogram with line breaks")
    items = []
    for i in range(length):  
        items.append(int(input()))
    largest_rectangle_histogram(items)

#references:
#https://www.csestack.org/unique-elements-from-list-in-python/
#https://coderwall.com/p/q_rd1q/emulate-do-while-loop-in-python
#https://coderwall.com/p/uhskuq/reverse-array-in-python
