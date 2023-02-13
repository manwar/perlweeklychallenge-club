
## Remarks
## https://www.geeksforgeeks.org/python-copy-directory-structure-without-files/

import shutil
import os

 
## Define the Function to Ignore the Files If Present in Any Folder
def GetIgnoreFiles(strDir, strFiles):
    return [strFileLoop for strFileLoop in strFiles if os.path.isfile(os.path.join(strDir, strFileLoop))]


strSourceFolderPath = "/a/b/c"
strTargetFolderPath = "/x/y"


## Calli the shutil.copytree() method and Pass the strSourceFolderPath, strTargetFolderPath and Ignore Parameter
shutil.copytree(strSourceFolderPath, strTargetFolderPath, ignore = GetIgnoreFiles)
