N = 50
people = [i for i in range(0, N)]
while len(people) > 1:
    tmp = people[0]
    del people[0]
    del people[0]
    people.append(tmp)

print('Last man standing is: ' + str(people[0] + 1))