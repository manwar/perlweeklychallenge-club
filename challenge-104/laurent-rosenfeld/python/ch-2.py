heap_count = 12
max_picks = 3
def pick_one_val(count):
    pick = input("There are " + str(count) + " tokens left. How many tokens do you pick? ");
    return pick

who_starts = input("Please say who starts (Y/I):")
if who_starts == "Y":
    pick = pick_one_val(heap_count)
    heap_count = heap_count - int(pick)
while True:
    pick = heap_count % (max_picks + 1)
    if pick == 0:
        pick = 1
    print("I picked ", str(pick), " tokens.")
    heap_count = heap_count - int(pick)
    if heap_count == 0:
        print("I won!");
        break
    pick = pick_one_val(heap_count)
    heap_count = heap_count - int(pick)
    if heap_count == 0:
        print ("You won!")
        break
