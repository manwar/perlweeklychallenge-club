import java.util.*;

/*

Perl Weekly Challenge - 071

Task #2: Trim Linked List

https://perlweeklychallenge.org/blog/perl-weekly-challenge-071/

> java -Dlist="1 -> 2 -> 3 -> 4 -> 5" -Dposition=2 Node

> java -Dposition=1 Node

> java -Dposition=2 Node

> java -Dposition=3 Node

> java -Dposition=4 Node

> java -Dposition=5 Node

> java -Dposition=6 Node

*/

class Node {
    private Integer v;
    private Node    p;

    public Node trim(int position) {

        Node tail = this;
        int count = 1;
        Node node = new Node();

        while (tail.p != null) {
            if (position > count) {
                node = tail;
            }
            else if (position == count) {
                if (node.v != null) {
                    node.p = tail.p;
                }
                else {
                    return tail.p;
                }
            }

            tail = tail.p;
            count++;
        }

        if (count <= position) {
            node.p = null;
        }

        return this;
    }

    public String show() {

        Node node = this;
        List<String> v = new ArrayList<String>();

        while (node.p != null) {
            v.add(Integer.toString(node.v));
            node = node.p;
        }
        v.add(Integer.toString(node.v));

        Collections.reverse(v);
        return String.join(" -> ", v);
    }

    public static Node createLinkedList(String list) {

        List<String> l = new ArrayList<String>();
        l.addAll(Arrays.asList(list.split(" -> ")));
        Node n = new Node();
        n.v    = Integer.parseInt(l.remove(l.size() - 1));
        Node t = n;


        while (l.size() >= 1) {
            Node _n = new Node();
            _n.v = Integer.parseInt(l.remove(l.size() - 1));
            t.p  = _n;
            t    = _n;
        }

        System.out.println(n.show());

        return n;
    }

    public static void main(String [] args) {
        String list  = System.getProperty("list", "1 -> 2 -> 3 -> 4 -> 5");
        int position = Integer.parseInt(System.getProperty("position", "2"));

        System.out.println(createLinkedList(list).trim(position).show());
    }
}

