# python 1.4 beta on DOSBOX

def mysum(arr10):
 return reduce(lambda x1, x2: x1+x2, arr10)

def weakest_row(matrix): #-- matrix is an array of arrays
 retval=[]
 for rowno in range(len(matrix)):  #for each row
  retval.append((mysum(matrix[rowno]),rowno))
 retval.sort()
 return map(lambda x:x[1],retval)
  
 
print weakest_row([[1,1,0,0,0],[1,1,1,1,0],[1,0,0,0,0],[1,1,0,0,0],[1,1,1,1,1]])
#[2, 0, 3, 1, 4]

print weakest_row([[1,0,0,0],[1,1,1,1],[1,0,0,0],[1,0,0,0]])
#[0, 2, 3, 1] 
