// The Weekly Challenge #094 Task 2
// ref:*  hhttps://www.includehelp.com/data-structure-tutorial/
//        preorder-traversal-in-binary-tree-iteratively-without-recursion.aspx
//     *  https://www.journaldev.com/13401/java-stack

import java.util.Scanner;
import java.util.Stack;

public class BT2LL
{
    public static LinkedList traversal (BinaryTree t)
    {
        
        LinkedList.LLNode h = new LinkedList.LLNode(0);
        LinkedList target = new LinkedList();
        target.setHead(h);

        Stack<BinaryTree.BTNode> ttStack = new Stack<>();
        ttStack.push(t.root);

        LinkedList.LLNode pretemp = h;
        BinaryTree.BTNode cur = null;
        LinkedList.LLNode temp = null;

        while (!ttStack.isEmpty()) {
            cur = ttStack.pop();
            temp = new LinkedList.LLNode(cur.value);
            LinkedList.NewLink(pretemp, temp);
            pretemp = temp;
            if (cur.rightChild != null) {
                ttStack.push(cur.rightChild);
            }
            if (cur.leftChild != null) {
                ttStack.push(cur.leftChild);
            }
        }
        
        return target;
    }

    public static void main(String[] args)
    {
        BinaryTree ninefour = new BinaryTree();
        BinaryTree.BTNode first = new BinaryTree.BTNode(1);
        BinaryTree.BTNode second = new BinaryTree.BTNode(2);
        BinaryTree.BTNode third = new BinaryTree.BTNode(3);
        BinaryTree.BTNode fourth = new BinaryTree.BTNode(4);
        BinaryTree.BTNode fifth = new BinaryTree.BTNode(5);
        BinaryTree.BTNode sixth = new BinaryTree.BTNode(6);
        BinaryTree.BTNode seventh = new BinaryTree.BTNode(7);
        BinaryTree.setLeftChild(first, second);
        BinaryTree.setRightChild(first, third);
        BinaryTree.setLeftChild(second, fourth);
        BinaryTree.setRightChild(second, fifth);
        BinaryTree.setLeftChild(fifth, sixth);
        BinaryTree.setRightChild(fifth, seventh);

        ninefour.setRoot(first);
        LinkedList ans = traversal(ninefour);
        LinkedList.printLL_without_h(ans);
    }
}
