'''

TASK #1 › Chinese Zodiac
Submitted by: Mohammad S Anwar
You are given a year $year.

Write a script to determine the Chinese Zodiac for the given year $year. Please check out wikipage for more information about it.

The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey, Rooster, Dog, Pig.
The element cycle: Wood, Fire, Earth, Metal, Water.

Example 1:
    Input: 2017
    Output: Fire Rooster
Example 2:
    Input: 1938
    Output: Earth Tiger

'''

#Firt year to start: 1924 wood rat


animals = ["Rat", "Ox", "Tiger", "Rabbit", "Dragon", "Snake", "Horse", "Goat", "Monkey", "Rooster", "Dog", "Pig"]
year = '2017'


def calculateElement():
    if (year[-1] == '0' or year[-1] == '1'):
        return "Metal"
    elif (year[-1] == '2' or year[-1] == '3'):
        return "Water"
    elif (year[-1] == '4' or year[-1] == '5'):
        return "Wood"
    elif (year[-1] == '6' or year[-1] == '7'):
        return "Fire"
    else:
        return "Earth"

def calculateAnimal():
    start = 1924
    counter = 0
    while start < int(year):
        if (counter == 11):
            counter = 0
        else:
            counter += 1
        start += 1
    return animals[counter]
    
print( calculateElement(), calculateAnimal())
