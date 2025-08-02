import random
fil=open("ch-1.py","r") 
words=fil.read().split()
print(words[random.randint(0,len(words)-1)])
