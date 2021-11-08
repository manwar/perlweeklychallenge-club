## Python3 Program
## Find Distance from Root to Given node in a Binary Tree
## Credit And Reference: https://www.geeksforgeeks.org/find-distance-root-given-node-binary-tree/

## A class to create a new Binary Tree Node
class newNode:
    def __init__(self, item):
        self.data = item
        self.left = self.right = None
 
## Returns -1 if x doesn't exist in tree.
## Else returns distance of x from root
def findDistance(root, x):

    ## Base Case
    if (root == None):
        return -1

    ## Initialize Distance
    dist = -1

    ## Check if x is present at root or in left subtree or right subtree.
    if (root.data == x):
        return dist + 1
    else:
        dist = findDistance(root.left, x)
        if dist >= 0:
            return dist + 1
        else:
            dist = findDistance(root.right, x)
            if dist >= 0:
                return dist + 1

    return dist

## Driver Code
if __name__ == '__main__':

    #### Example 1 ####
    root_01 = newNode(1)

    root_01.left = newNode(2)
    root_01.right = newNode(3)

    root_01.right.right = newNode(4)

    root_01.right.right.left = newNode(5)
    root_01.right.right.left = newNode(6)

    ### Find Distance Given Node From Root
    ## print(findDistance(root_01, 6))
    ## print(findDistance(root_01, 4))
    #### Example 1 ####

    #### Example 2 ####
    root_02 = newNode(1)

    root_02.left = newNode(2)
    root_02.right = newNode(3)

    root_02.left.left = newNode(4)
    root_02.right.right = newNode(5)

    root_02.left.left.right = newNode(6)
    root_02.right.right.left = newNode(7)

    root_02.left.left.right.left = newNode(8)
    root_02.left.left.right.right = newNode(9)
    
    ## print(findDistance(root_02, 8))
    print(findDistance(root_02, 6))
    #### Example 2 ####