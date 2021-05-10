def sorted(arr):
    for i in range(0, len(arr)-1, 1):
        if(arr[i] > arr[i+1]):
            return False
    return True

if __name__ == "__main__":
    length = 0
    words = []
    with open("../perl/american-english", "r") as f:
        for word in f.readlines():
            word = word.lower().strip()
            #no need to scan for smaller words ;>
            #I'm not sure that this saves any [noticable] amount of time
            if(length < len(word) and sorted(word)):
                if(len(word) > length):
                    length = len(word)
                    words = [word]
                elif(len(word) == length):
                    words.append(word)
                #else: we discard
    print("Longest presorted word(s) is/are", length, "letters long")
    print("Word(s):", words)
    
