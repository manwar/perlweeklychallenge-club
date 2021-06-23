object Palindrome {
  def binaryPalinDrome(n: Int): Int = if (n.toBinaryString.reverse == n.toBinaryString) 1 else 0
}