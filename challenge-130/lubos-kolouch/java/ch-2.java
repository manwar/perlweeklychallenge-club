class Node {
  int value;
  Node left, right;

  Node(int item) {
    value = item;
    left = right = null;
  }
}

public class Main {
  Node root;

  boolean isBST() {
    return isBSTUtil(root, Integer.MIN_VALUE, Integer.MAX_VALUE);
  }

  boolean isBSTUtil(Node node, int min, int max) {
    if (node == null) {
      return true;
    }

    if (node.value < min || node.value > max) {
      return false;
    }

    return (isBSTUtil(node.left, min, node.value - 1) &&
            isBSTUtil(node.right, node.value + 1, max));
  }

  public static void main(String args[]) {
    Main tree = new Main();
    tree.root = new Node(8);
    tree.root.left = new Node(5);
    tree.root.right = new Node(9);
    tree.root.left.left = new Node(4);
    tree.root.left.right = new Node(6);

    if (tree.isBST()) {
      System.out.println(1);
    } else {
      System.out.println(0);
    }
  }
}
