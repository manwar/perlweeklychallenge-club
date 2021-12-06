## Sleep Sort (For Positive Numbers)
## Credit: https://gist.github.com/armorasha/47c7236cdfe25a928080692324d7f035
## Credit: https://iq.opengenus.org/sleep-sort/
## Python 3

import _thread
from time import sleep

arrItem = [2, 4, 5, 2.5, 1, 7]

def FuncSleepSort(nNum):
    sleep(nNum)
    print(nNum)


for nItem in arrItem:
    argItem = (nItem,)
    _thread.start_new_thread(FuncSleepSort, argItem)

