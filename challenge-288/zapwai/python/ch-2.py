import re

def intersection(a, b):
	for entry1 in a.split(" "):
		for entry2 in b.split(" "):
			if entry1 == entry2:
				return True
	return False

def merge(c):
	for	i1 in range(len(c) - 1):
		for	i2 in range(i1 + 1, len(c)):
			if intersection(c[i1], c[i2]):
				h = {}
				for i in c[i1].split(" "):
					h[i] = 1
				for i in c[i2].split(" "):
					h[i] = 1 
				c[i1] = ""
				c[i2] = " ".join(h.keys())

def contigu(matrix, m, n, entry, c):
	blocks = [entry]
	for block in blocks:
		(a, b) = block.split("-")
		y = int(a)
		x = int(b)
		if x + 1 <= n:
			if matrix[y][x] == matrix[y][x+1]:
				blocks.append(str(y)+"-"+str(x+1))
		if y + 1 <= m:
			if matrix[y][x] == matrix[y+1][x]:
				blocks.append(str(y+1)+"-"+str(x))
	c.append(" ".join(blocks))

def proc(matrix):
	print("Input: matrix =")
	for i in matrix:
		print(i)
	print()
	m = -1 + len(matrix)
	n = -1 + len(matrix[0])
	contig = []
	contigu(matrix, m, n, "0-0", contig)
	for i in range(m+1):
		for j in range(n+1):
			got_flag = False
			entry = str(i)+"-"+str(j)
			for	b in contig:
				if entry in b.split(" "):
					got_flag = True
					break
			if not got_flag:
				contigu(matrix, m, n, entry, contig) 
	merge(contig)
	cnt = 0
	for c in contig:
		if c:
			print(c)
			leng = len(c.split(" "))
			if cnt < leng:
				cnt = leng
	print("\nOutput:", cnt, "\n")

matrix = [['x', 'x', 'x', 'x', 'o'],
		  ['x', 'o', 'o', 'o', 'o'],
		  ['x', 'o', 'o', 'o', 'o'],
		  ['x', 'x', 'x', 'o', 'o'],
	  ]
proc(matrix)
matrix = [['x', 'x', 'x', 'x', 'x'],
	   ['x', 'o', 'o', 'o', 'o'],
	   ['x', 'x', 'x', 'x', 'o'],
	   ['x', 'o', 'o', 'o', 'o'],
		 ]
proc(matrix)
matrix = [['x', 'x', 'x', 'o', 'o'],
	   ['o', 'o', 'o', 'x', 'x'],
	   ['o', 'x', 'x', 'o', 'o'],
	   ['o', 'o', 'o', 'x', 'x'],
		 ]
proc(matrix)

