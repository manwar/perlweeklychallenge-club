
def find_diff (target, int_list):
    my_set = set(int_list)
    for item in my_set:
        if item + target in test:
            # print(item)
            return 1
    return 0

test = (10, 8, 12, 15, 5)
target = 7
print(find_diff(target, test))
