import logging

## Credit:
## https://gist.github.com/shubham2508/9188707973e9a758c0edefe577c0da20

## Remarks:
## https://stackoverflow.com/questions/2802726/putting-a-simple-if-then-else-statement-on-one-line
## https://en.wikipedia.org/wiki/%3F:#Python

## Links Used:
## http://adilet.org/blog/palindromic-tree/
## https://medium.com/@alessiopiergiacomi/eertree-or-palindromic-tree-82453e75025b
## It solves the problem in O(n)

class PalindromicNode:
    def __init__(self, start = 0, end = 0):
        self.start = start
        self.end = end
        self.len = end - start + 1
        self.insertionEdge = [0] * 26
        self.suffixLink = None

        ## Optional Attribute
        self.count = 1 ## Stores number of times this palindrome was repeated
        self.num_of_suffix_links = 1 ## stores number of suffix link till imaginary node

    def increment_count(self):
        self.count = self.count + 1

class PalindromicTree:
    def __init__(self, value):
        self.emptyNode = PalindromicNode()
        self.imaginaryNode = PalindromicNode()
        self.tree = []
        self.string = value
        self.total_palindromes = 0
        self.distinct_palindromes = 0
        self.emptyNode.suffixLink = self.imaginaryNode
        self.imaginaryNode.suffixLink = self.imaginaryNode
        self.imaginaryNode.len = -1
        self.emptyNode.len = 0

        self.current_suffix = self.imaginaryNode

    def insert_letter(self, curr_ind, character):
        chr_index = ord(character) - 97
        new_node = None
        curr_suffix = self.current_suffix

        if curr_suffix.len > 0:
            logging.debug(f'\n curr_suffix is : {self.string[curr_suffix.start:curr_suffix.end + 1]}')

        while curr_suffix:
            curr_start = curr_ind if curr_suffix.len == -1 else curr_ind - curr_suffix.len - 1

            if curr_start >= 0 and self.string[curr_start] == character:
                if not curr_suffix.insertionEdge[chr_index]:
                    new_node = PalindromicNode(start = curr_start, end = curr_ind)
                    logging.info(f' new_node starts from: {new_node.start} ends at: {new_node.end}')
                    curr_suffix.insertionEdge[chr_index] = new_node
                    self.distinct_palindromes = self.distinct_palindromes + 1

                    break
                else:
                    new_node = curr_suffix.insertionEdge[chr_index]
                    self.total_palindromes = self.total_palindromes + new_node.num_of_suffix_links
                    new_node.increment_count()
                    self.current_suffix = new_node
                    logging.info(f' new_node is already present: {self.string[new_node.start:new_node.end + 1]}')
                    logging.debug(f' Palindromes til now: {self.total_palindromes}')

                    return

            curr_suffix = curr_suffix.suffixLink

        self.tree.append(new_node)
        self.current_suffix = new_node

        if new_node.start == new_node.end:
            new_node.suffixLink = self.emptyNode
            self.total_palindromes += new_node.num_of_suffix_links
            logging.debug(f' Palindromes til now: {self.total_palindromes}')
            return

        curr_suffix = curr_suffix.suffixLink

        while True:
            curr_start = curr_ind if curr_suffix.len == -1 else curr_ind - curr_suffix.len - 1

            if curr_start >= 0 and self.string[curr_start] == character:
                new_node.suffixLink = curr_suffix.insertionEdge[chr_index]
                new_node.num_of_suffix_links = new_node.num_of_suffix_links + new_node.suffixLink.num_of_suffix_links
                self.total_palindromes = self.total_palindromes + new_node.num_of_suffix_links

                logging.debug(f' new_node suffix link is : {self.string[new_node.suffixLink.start:new_node.suffixLink.end + 1]}')

                break

            curr_suffix = curr_suffix.suffixLink

        logging.debug(f' Palindromes til now: {self.total_palindromes}')

    def get_number_of_occurrence_of_sub_palindromes(self):

        total_len = len(self.tree)

        for j in range(total_len - 1, -1, -1):
            self.tree[j].suffixLink.count = self.tree[j].suffixLink.count + self.tree[j].count

        total_palindromes = 0

        for treeNode in self.tree:
            start, end, count = treeNode.start, treeNode.end, treeNode.count
            logging.critical(f' Palindrome is {self.string[start:end + 1]} number of times: {count} ')
            total_palindromes += count

        logging.critical(f' Total number of palindromes: {total_palindromes} ')


if __name__ == "__main__":

    ## Example 1:
    ## string = "redivider"

    ## Example 2:
    ## string = "deific"

    ## Example 3:
    ## string = "rotors"

    ## Example 4:
    ## string = "challenge"

    ## Example 5:
    ## string = "champion"

    ## Example 6:
    string = "christmas"

    logging.basicConfig(level = logging.INFO)
    palindromicTree = PalindromicTree(string)
    for index, ch in enumerate(string):
        palindromicTree.insert_letter(index, ch)

    logging.critical(f' Total number of palindromes: {palindromicTree.total_palindromes} ')
    logging.critical(f' Total number of distinct palindromes:  {palindromicTree.distinct_palindromes}')

    palindromicTree.get_number_of_occurrence_of_sub_palindromes()
