
public class SumPath {

    static int sum = 0;

    public static void main(String[] args) {
        TreeNode node1 = new TreeNode(3, null, null);
        TreeNode node2 = new TreeNode(4, null, null);
        TreeNode node3 = new TreeNode(2, node1, node2);
        TreeNode node4 = new TreeNode(1, node3, null);

        sumOfAllPaths(node4, new int[4], 0);
        System.out.println("Output: " + sum);

        sum = 0;

        TreeNode node001 = new TreeNode(4, null, null);
        TreeNode node002 = new TreeNode(5, null, null);
        TreeNode node003 = new TreeNode(6, null, null);
        TreeNode node004 = new TreeNode(2, node001, null);
        TreeNode node005 = new TreeNode(3, node002, node003);
        TreeNode node006 = new TreeNode(1, node004, node005);

        sumOfAllPaths(node006, new int[6], 0);
        System.out.println("Output: " + sum);
    }

    private static void sumOfAllPaths(TreeNode node, int[] path, int len) {
        if (node == null) {
            return;
        }
        path[len] = node.data;
        len++;
        if (node.left == null && node.right == null) {
            for (int i = 0; i < path.length; i++) {
                sum += path[i];
            }
            return;
        }
        sumOfAllPaths(node.left, path, len);
        sumOfAllPaths(node.right, path, len);
    }

    static class TreeNode {
        public int data;
        public TreeNode left;
        public TreeNode right;

        public TreeNode(int data, TreeNode left, TreeNode right) {
            this.data = data;
            this.left = left;
            this.right = right;
        }
    }
}

