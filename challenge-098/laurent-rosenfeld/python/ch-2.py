def find_insert_pos(target, list):
    for i in range(len(list)):
        if list[i] >= target:
            return i
    return len(list)

in_list = [1, 3, 5, 7]
for j in range (8):
    print('Target: ', j, '->', find_insert_pos(j, in_list))
