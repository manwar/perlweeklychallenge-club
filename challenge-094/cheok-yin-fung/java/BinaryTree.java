// The Weekly Challenge #094
// ref: https://codereview.stackexchange.com/
//      questions/37944/constructing-a-binary-tree-in-java


import java.util.Scanner;

public class BinaryTree
{
    public static BTNode root;

    public static class BTNode
    {
        BTNode leftChild;
        BTNode rightChild;
        int value;

        BTNode(int d)
        {
            value = d;
            leftChild = null;
            rightChild = null;
        }
    }

    public static void setLeftChild (BTNode p, BTNode kid)
    {
        p.leftChild = kid;
    }
    public static void setRightChild (BTNode p, BTNode kid)
    {
        p.rightChild = kid;
    }

    public static void setRoot (BTNode n)
    {
        root = n;
    }

    public int getValue(BTNode n) 
    {
        return n.value;
    }


}
