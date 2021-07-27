#  DESCRIPTION: The Weekly Challenge 122
#               Task 1 - Average of Stream
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 07/24/2021 10:27:06 AM
# ===============================================================================

def print_moving_average(what):

    total = what[0]
    arr_str = str(what[0])

    # print the first MA to avoid unnecessary IF in the loop for each number
    print(f"Average of the first number is {total}")

    for pos, i in enumerate(what[1:]):
        total += i
        arr_str += f"+{str(i)}"
        print(f"Average of the first {pos+1} numbers ({arr_str})/{pos+2} = {total/(pos+2)}")

    return total/len(what)


assert print_moving_average([10, 20, 30, 40, 50, 60, 70, 80, 90]) == 50
