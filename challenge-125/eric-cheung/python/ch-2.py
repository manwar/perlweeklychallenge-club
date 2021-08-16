## Python Program
## Find Max. Path In Binary Tree
## Credit And Reference: https://www.geeksforgeeks.org/find-maximum-path-sum-in-a-binary-tree/

## A Binary Tree Node
class Node:
    ## Constructor to create a new node
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None

## This function returns overall max. path in 'res'
## And returns max path count going through root
def findMaxUtil(root):
    ## Base Case
    if root is None:
        return 0

    ## l and r store max. path count going through left
    ## and right child of root respectively
    l = findMaxUtil(root.left)
    r = findMaxUtil(root.right)

    ## Max path for parent call of root. This path
    ## must include at most one child of root
    max_single = max(max(l, r) + 1, 1)
	
    ## Max top represents the count when the node under
    ## consideration is the root of the maxCount path and
    ## no ancestor of root are there in max count path
    max_top = max(max_single, l + r + 1)

    ## Static variable to store the changes
    ## Store the max. result
    findMaxUtil.res = max(findMaxUtil.res, max_top)

    return max_single

## Return max. path count in tree with given root
def findMaxCount(root):
    ## Initialize result
    findMaxUtil.res = float("-inf")
	
    ## Compute and return result
    findMaxUtil(root)
    return findMaxUtil.res - 1

## Driver program
root = Node(1)

root.left = Node(2)
root.right = Node(5);

root.left.left = Node(3);
root.left.right = Node(4);

root.right.left = Node(6);
root.right.right = Node(7);

root.right.right.left = Node(8);
root.right.right.right = Node(10);

root.right.right.left.left = Node(9);

print "Binary Tree Diameter is ", findMaxCount(root);
