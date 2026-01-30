
import unittest

def encrypt(text: str, shift: int) -> str:
    codebook = 'abcdefghijklmnopqrstuvwxyz'
    size = len(codebook)
    ctoi = {c:i for i,c in enumerate(codebook)}
    itoc = {i:c for c,i in ctoi.items()}

  
    out = (itoc[(ctoi[c] + shift) % size] for c in text)
    out = ''.join(out)

    return out

class Encryptor():
    def __init__(self, codebook: str):
        self.codebook = codebook
        self.size = len(self.codebook)
        self.ctoi = {c:i for i,c in enumerate(self.codebook)}
        self.itoc = {i:c for c,i in self.ctoi.items()}

    def encrypt(self, text, shift) -> str:
        out = (self.itoc[(self.ctoi[c] + shift) % self.size] for c in text)
        out = ''.join(out)
        return out

    def safeEncypt(self, text: str, shift: int) -> str:
        def substiute(c: str) -> str:
            if c in self.ctoi:
                return self.itoc[(self.ctoi[c] + shift) % self.size]
            else:
                raise ValueError(f"The character '{c}' is not in the current codebook ")

        out = (substiute(c) for c in text)
        out = ''.join(out)
        
        return out

    def silentEncypt(self, text: str, shift: int):
        def sub(c: str):
            if c in self.ctoi:
                return self.itoc[(self.ctoi[c] + shift) % self.size]
            else:
                return None

        out = (sub(c) for c in text if not None)
        out = ''.join(str(out))
            
        return out


def make_encryptor(codebook: str):

    size = len(codebook)
    ctoi = {c:i for i,c in enumerate(codebook)}
    itoc = {i:c for c,i in ctoi.items()}
    
    def safeEncypt(text: str, shift: int) -> str:
        def substiute(c: str) -> str:
            if c in ctoi:
                return itoc[(ctoi[c] + shift) % size]
            else:
                raise ValueError(f"The character '{c}' is not in the current codebook ")

        out = (substiute(c) for c in text)
        out = ''.join(out)
        
        return out
    
    return safeEncypt
        

def dev():
    encrypt2 = make_encryptor('abcdefghijklmnopqrstuvwxyz')
    print(encrypt2("abGc", 1))


class Solution1Runner(unittest.TestCase):

    def test_case_1(self):
        self.assertEqual(encrypt("abc",1), "bcd")

    def test_case_2(self):
        self.assertEqual(encrypt("xyz",2), "zab")

    def test_case_3(self):
        self.assertEqual(encrypt("abc",27), "bcd")

    def test_case_4(self):
        self.assertEqual(encrypt("hello",5), "mjqqt")

    def test_case_5(self):
        self.assertEqual(encrypt("perl",26), "perl")


class Solution2Runner(unittest.TestCase):
    def setUp(self):
        self.encryptor = Encryptor("abcdefghijklmnopqrstuvwxyz")

    def test_case_1(self):
        self.assertEqual(self.encryptor.encrypt("abc",1), "bcd")

    def test_case_2(self):
        self.assertEqual(self.encryptor.encrypt("xyz",2), "zab")

    def test_case_3(self):
        self.assertEqual(self.encryptor.encrypt("abc",27), "bcd")

    def test_case_4(self):
        self.assertEqual(self.encryptor.encrypt("hello",5), "mjqqt")

    def test_case_5(self):
        self.assertEqual(self.encryptor.encrypt("perl",26), "perl")

    def test_case_6(self):
        self.assertRaises(ValueError, self.encryptor.safeEncypt, "a/c",1)

    

if __name__ == '__main__':
    #dev()
    unittest.main()