import time
import math

def is_empty(queue):
    if not queue:
        print("Queue is empty")
    else:
        print("Queue is not empty")

def insert_with_priority(queue):
    print('Enter the priority of the element you want to insert')
    priority = int(input())
    timestamp = time.time()

    queue.append([priority, timestamp])
    return queue

def pull_highest_prority_element(queue):
    queue.remove(max(queue))
    return queue

available_choices = [1, 2, 3, 4]
queue = []

while 1:
    print('\n\n')
    print('================================')
    print('Current status of queue')
    if not queue:
        print(queue)
    else:
        for i in range(0, len(queue)):
            print(queue[i][0])
    
    
    print('1. Check if queue is empty')
    print('2. Insert with priority')
    print('3. Pull highest priority element')
    print('4. Exit')
    print('Enter the number of your choice')

    choice = int(input())
    while (choice not in available_choices):
        print('Please enter a valid choice')
        choice = int(input())

    if (choice == 1):
        is_empty(queue)
    if (choice == 2):
        queue = insert_with_priority(queue)
    if (choice == 3):
        queue = pull_highest_prority_element(queue)
    if (choice == 4):
        break

