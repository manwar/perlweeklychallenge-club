#! /usr/bin/python3

# Very lightly modified from https://rosettacode.org/wiki/Eertree#Python
# by "TimSC"

import unittest

def eertree(st):
    eertree=Eertree()
    for ch in st:
        eertree.add(ch)
    result = []
    eertree.get_sub_palindromes(eertree.rto, [eertree.rto], [], result)
    eertree.get_sub_palindromes(eertree.rte, [eertree.rte], [], result)
    q=set(result)
    res=[]
    for i in range(len(st)):
        for j in range(i,len(st)):
            k=st[i:j+1]
            if k in q:
                res.append(k)
                q.discard(k)
    return res

class Eernode(object):
    def __init__(self):
        self.edges = {} # edges (or forward links)
        self.link = None # suffix link (backward links)
        self.len = 0 # the length of the node
        
class Eertree(object):
    def __init__(self):
        self.nodes = []
        # two initial root nodes
        self.rto = Eernode() #odd length root node, or node -1
        self.rte = Eernode() #even length root node, or node 0
        
        # Initialize empty tree
        self.rto.link = self.rte.link = self.rto;
        self.rto.len = -1
        self.rte.len = 0
        self.S = [0] # accumulated input string, T=S[1..i]
        self.maxSufT = self.rte # maximum suffix of tree T
        
    def get_max_suffix_pal(self, startNode, a):
        # We traverse the suffix-palindromes of T in the order of decreasing length.
        # For each palindrome we read its length k and compare T[i-k] against a
        # until we get an equality or arrive at the -1 node.
        u = startNode
        i = len(self.S)
        k = u.len
        while id(u) != id(self.rto) and self.S[i - k - 1] != a:
            assert id(u) != id(u.link) #Prevent infinte loop
            u = u.link
            k = u.len
            
        return u
    
    def add(self, a):
        
        # We need to find the maximum suffix-palindrome P of Ta
        # Start by finding maximum suffix-palindrome Q of T.
        # To do this, we traverse the suffix-palindromes of T
        # in the order of decreasing length, starting with maxSuf(T)
        Q = self.get_max_suffix_pal(self.maxSufT, a)
        
        # We check Q to see whether it has an outgoing edge labeled by a.
        createANewNode = not a in Q.edges
        
        if createANewNode:
            # We create the node P of length Q+2
            P = Eernode()
            self.nodes.append(P)
            P.len = Q.len + 2
            if P.len == 1:
                # if P = a, create the suffix link (P,0)
                P.link = self.rte
            else:
                # It remains to create the suffix link from P if |P|>1. Just
                # continue traversing suffix-palindromes of T starting with the suffix 
                # link of Q.
                P.link = self.get_max_suffix_pal(Q.link, a).edges[a]
                
            # create the edge (Q,P)
            Q.edges[a] = P
            
        #P becomes the new maxSufT
        self.maxSufT = Q.edges[a]
        
        #Store accumulated input string
        self.S.append(a)
        
        return createANewNode
    
    def get_sub_palindromes(self, nd, nodesToHere, charsToHere, result):
        #Each node represents a palindrome, which can be reconstructed
        #by the path from the root node to each non-root node.
            
        #Traverse all edges, since they represent other palindromes
        for lnkName in nd.edges:
            nd2 = nd.edges[lnkName] #The lnkName is the character used for this edge
            self.get_sub_palindromes(nd2, nodesToHere+[nd2], charsToHere+[lnkName], result)
            
        #Reconstruct based on charsToHere characters.
        if id(nd) != id(self.rto) and id(nd) != id(self.rte): #Don't print for root nodes
            tmp = "".join(charsToHere)
            if id(nodesToHere[0]) == id(self.rte): #Even string
                assembled = tmp[::-1] + tmp
            else: #Odd string
                assembled = tmp[::-1] + tmp[1:]
            result.append(assembled)

class TestEertree(unittest.TestCase):

        def test_ex1(self):
          self.assertEqual(eertree("redivider"),["r","redivider","e","edivide","d","divid","i","ivi","v"],'example 1')

        def test_ex2(self):
          self.assertEqual(eertree("deific"),["d","e","i","ifi","f","c"],'example 2')

        def test_ex3(self):
          self.assertEqual(eertree("rotors"),["r","rotor","o","oto","t","s"],'example 3')

        def test_ex4(self):
          self.assertEqual(eertree("challenge"),["c","h","a","l","ll","e","n","g"],'example 4')

        def test_ex5(self):
          self.assertEqual(eertree("champion"),["c","h","a","m","p","i","o","n"],'example 5')

        def test_ex6(self):
          self.assertEqual(eertree("christmas"),["c","h","r","i","s","t","m","a"],'example 6')

unittest.main()
