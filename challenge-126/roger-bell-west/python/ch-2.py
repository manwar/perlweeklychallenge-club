#! /usr/bin/python3

ina=[
  ['x','*','*','*','x','*','x','x','x','x'],
  ['*','*','*','*','*','*','*','*','*','x'],
  ['*','*','*','*','x','*','x','*','x','*'],
  ['*','*','*','x','x','*','*','*','*','*'],
  ['x','*','*','*','x','*','*','*','*','x']
]

ysiz=len(ina)
xsiz=len(ina[0])

mn=[]
for i in range(ysiz):
  mn.append([0] * xsiz)
  
for y in range(ysiz):
  sy=range(max(0,y-1),min(ysiz,y+2))
  for x in range(xsiz):
    sx=range(max(0,x-1),min(xsiz,x+2))
    if ina[y][x] == 'x':
      for yi in sy:
        for xi in sx:
          if xi==x and yi==y:
            continue
          mn[yi][xi] += 1

for y in range(ysiz):
  for x in range(xsiz):
    if ina[y][x] == 'x':
      mn[y][x] = 'x'
    else:
      mn[y][x] = str(mn[y][x])
  print(" ".join(mn[y]))
