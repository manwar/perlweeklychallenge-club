# python 1.4 beta on DOSBOX

def column( inmatrix, colno ):
  retval=[]
  for y in range(len(inmatrix)):
    retval.append( (inmatrix[y])[colno] )
  return retval
  
def lucky_numbers( inmatrix ):
  retval=-1;
  ncol=len(inmatrix[0])
  nrow=len(inmatrix)
  for y in range(nrow):
    for x in range(ncol):
      if (inmatrix[y])[x]==max(column(inmatrix,x)) == min(inmatrix[y]):
        retval = (inmatrix[y])[x]
        break
  return retval
  
print lucky_numbers( [[3,7,8],[9,11,13],[15,16,17]] ) #15
print lucky_numbers( [[1,10,4,2],[9,3,8,7],[15,16,17,12]] ) #12
print lucky_numbers( [[7,8],[1,2]] ) #7

