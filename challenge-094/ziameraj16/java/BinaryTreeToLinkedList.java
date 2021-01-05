import java.util.ArrayList;
import java.util.List;

public class BinaryTreeToLinkedList {

    private List<String> treeNodesAsList;

    public BinaryTreeToLinkedList() {
        this.treeNodesAsList = new ArrayList();
    }

    public void preOrderBinaryTreeTraversal(TreeNode node) {
        if (node == null) {
            return;
        }
        treeNodesAsList.add(node.data);
        preOrderBinaryTreeTraversal(node.left);
        preOrderBinaryTreeTraversal(node.right);
    }

    public void printTreeElementAsList() {
        System.out.println(String.join(" -> ", treeNodesAsList));
    }

    public List<String> getTreeNodesAsList() {
        return treeNodesAsList;
    }

    static class TreeNode {
        public String data;
        public TreeNode left;
        public TreeNode right;

        public TreeNode(String data, TreeNode left, TreeNode right) {
            this.data = data;
            this.left = left;
            this.right = right;
        }
    }

}

