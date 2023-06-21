import java.util.*;

class Main {
  static class LinkedList {
    int value;
    LinkedList next;

    LinkedList(int value, LinkedList next) {
      this.value = value;
      this.next = next;
    }

    LinkedList add(LinkedList other) {
      int carry = 0;
      LinkedList head = new LinkedList(0, null), tail = head;
      while (this != null || other != null || carry != 0) {
        int sum = (this != null ? this.value : 0) +
                  (other != null ? other.value : 0) + carry;
        tail.next = new LinkedList(sum % 10, null);
        tail = tail.next;
        carry = sum / 10;
        this = this != null ? this.next : null;
        other = other != null ? other.next : null;
      }
      return head.next;
    }

    @Override
    public String toString() {
      LinkedList node = this;
      List<String> values = new ArrayList<>();
      while (node != null) {
        values.add(Integer.toString(node.value));
        node = node.next;
      }
      return String.join(" -> ", values);
    }
  }

  public static void main(String[] args) {
    LinkedList l1 =
        new LinkedList(1, new LinkedList(2, new LinkedList(3, null)));
    LinkedList l2 =
        new LinkedList(3, new LinkedList(2, new LinkedList(1, null)));

    LinkedList result = l1.add(l2);
    System.out.println(result);
  }
}
