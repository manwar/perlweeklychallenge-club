# Java solution by Mohammad Meraj Zia
# Binary Tree to Linked List

1. Prepare the tree using the `TreeNode` inner class in the `BinaryTreeToLinkedList`
2. Call the `preOrderBinaryTreeTraversal()` method to convert the tree elements into a list.
3. Call `printTreeElementAsList()` to print the list.

## Example
```java
TreeNode six = new TreeNode("6", null, null);
TreeNode seven = new TreeNode("7", null, null);
TreeNode five = new TreeNode("5", six, seven);
TreeNode four = new TreeNode("4", null, null);
TreeNode two = new TreeNode("2", four, five);
TreeNode three = new TreeNode("3", null, null);
TreeNode root = new TreeNode("1", two, three);
binaryTreeToLinkedList.preOrderBinaryTreeTraversal(root);
```

