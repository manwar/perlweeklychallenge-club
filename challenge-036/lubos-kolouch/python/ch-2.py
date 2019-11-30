#! python

from itertools import combinations
from pprint import pprint

weight = {'R':1, 'B':1, 'G':2, 'Y':12, 'P':4}
value  = {'R':1, 'B':2, 'G':2, 'Y':4, 'P':10}

weight_limit=15

def calculate_value(boxes):
    total_weight = 0
    total_value = 0
    for box in boxes:
        total_weight += weight[box]
        total_value += value[box] 

    if total_weight <= weight_limit:
        return total_value

    return 0

list = ['R','B','G','Y','P']

for count in range(1, len(list)+1):
    max_value = 0
    max_boxes = 0

    for comb in combinations(list,count):
        val = calculate_value(comb);
        if (val > max_value):
            max_value = val
            max_boxes = str(comb)

    if (max_value):
        pprint("Best combination for "+str(count)+" boxes is "+max_boxes+" with value "+str(max_value))
    else:
        pprint("There is no possible combination for "+str(count)+" boxes under or equal weight "+str(weight_limit))

