// The Weekly Challenge #094
// ref: https://www.geeksforgeeks.org/
//      implementing-a-linked-list-in-java-using-class/
import java.util.Scanner;

public class LinkedList 
{
    static LLNode head;

    static class LLNode
    {
        LLNode next;
        int value;

        LLNode(int d)
        {
            value = d;
            next = null;
        }
    }

    public static void NewLink ( LLNode front, LLNode back)
    {
        front.next = back;
    }

    public static void printLL(LinkedList list)
    {
        LLNode node = list.head;
        while (node.next != null) {
            System.out.print(node.value + " -> ");
            node = node.next;
        }
        System.out.println(node.value);       //final value
    }

    public static void printLL_without_h(LinkedList list)
    {
        LLNode node = list.head;
        while (node.next != null) {
            node = node.next;
            System.out.print(node.value + " -> ");
        }
        System.out.println("end");
    }

    public static void setHead (LLNode n)
    {
        head = n;
    }

    public int getValue(LLNode n) 
    {
        return n.value;
    }


}
