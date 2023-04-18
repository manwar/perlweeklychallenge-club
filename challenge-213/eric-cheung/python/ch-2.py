
## Example 1:
## arrInputRouteList = [[1, 2, 6], [5, 6, 7]]
## nSource = 1
## nDestination = 7

## Example 2:
## arrInputRouteList = [[1, 2, 3], [4, 5, 6]]
## nSource = 2
## nDestination = 5

## Example 3:
arrInputRouteList = [[1, 2, 3], [4, 5, 6], [3, 8, 9], [7, 8]]
nSource = 1
nDestination = 7

nSourceIndx = -1
nDestinationIndx = -1

arrOutputRouteList = []

for nIndx, arrLoop in enumerate(arrInputRouteList):
    if nSource in arrLoop:
        nSourceIndx = nIndx
    elif nDestination in arrLoop:
        nDestinationIndx = nIndx

## print (nSourceIndx)
## print (nDestinationIndx)

if nSourceIndx < 0 or nDestinationIndx < 0:
    print (-1)
elif nSourceIndx == nDestinationIndx:
    nStartIndx = arrInputRouteList[nSourceIndx].index(nSource)
    nEndIndx = arrInputRouteList[nDestinationIndx].index(nDestination)

    if nEndIndx < nStartIndx:
        for nIndx in range(nStartIndx, nEndIndx - 1, -1):
            arrOutputRouteList.append(arrInputRouteList[nSourceIndx][nIndx])
    else:
        for nIndx in range(nStartIndx, nEndIndx + 1):
            arrOutputRouteList.append(arrInputRouteList[nSourceIndx][nIndx])
elif len(arrInputRouteList) <= 2:
    ## Check Intersection
    arrIntersection = [nElem for nElem in arrInputRouteList[nSourceIndx] if nElem in arrInputRouteList[nDestinationIndx]]
    if len(arrIntersection) == 0:
        print (-1)
    else:
        ## Source Array Part
        nStartIndx = arrInputRouteList[nSourceIndx].index(nSource)
        nEndIndx = arrInputRouteList[nSourceIndx].index(arrIntersection[0])

        if nEndIndx < nStartIndx:
            for nIndx in range(nStartIndx, nEndIndx, -1):
                arrOutputRouteList.append(arrInputRouteList[nSourceIndx][nIndx])
        else:
            for nIndx in range(nStartIndx, nEndIndx):
                arrOutputRouteList.append(arrInputRouteList[nSourceIndx][nIndx])

        ## Destination Array Part
        nStartIndx = arrInputRouteList[nDestinationIndx].index(arrIntersection[0])
        nEndIndx = arrInputRouteList[nDestinationIndx].index(nDestination)

        if nEndIndx < nStartIndx:
            for nIndx in range(nStartIndx, nEndIndx - 1, -1):
                arrOutputRouteList.append(arrInputRouteList[nDestinationIndx][nIndx])
        else:
            for nIndx in range(nStartIndx, nEndIndx + 1):
                arrOutputRouteList.append(arrInputRouteList[nDestinationIndx][nIndx])

        print (arrOutputRouteList)
else:
    ## Check Intersection
    arrIntersection = [nElem for nElem in arrInputRouteList[nSourceIndx] if nElem in arrInputRouteList[nDestinationIndx]]

    if len(arrIntersection) == 0:
        nInterSourceIndx = -1
        nInterDestinationIndx = -1

        nInterSourceElem = -1
        nInterDestinationElem = -1

        for nIndx, arrLoop in enumerate(arrInputRouteList):
            if nIndx == nSourceIndx or nIndx == nDestinationIndx:
                continue

            arrIntersection = [nElem for nElem in arrInputRouteList[nSourceIndx] if nElem in arrInputRouteList[nIndx]]
            if len(arrIntersection) > 0:
                nInterSourceIndx = nIndx
                nInterSourceElem = arrIntersection[0]

            arrIntersection = [nElem for nElem in arrInputRouteList[nDestinationIndx] if nElem in arrInputRouteList[nIndx]]
            if len(arrIntersection) > 0:
                nInterDestinationIndx = nIndx
                nInterDestinationElem = arrIntersection[0]

        if nInterSourceIndx < -1 or nInterDestinationIndx < -1:
            print (-1)
        elif nInterSourceIndx == nInterDestinationIndx:
            ## Source Array Part
            nStartIndx = arrInputRouteList[nSourceIndx].index(nSource)
            nEndIndx = arrInputRouteList[nSourceIndx].index(nInterSourceElem)

            if nEndIndx < nStartIndx:
                for nIndx in range(nStartIndx, nEndIndx, -1):
                    arrOutputRouteList.append(arrInputRouteList[nSourceIndx][nIndx])
            else:
                for nIndx in range(nStartIndx, nEndIndx):
                    arrOutputRouteList.append(arrInputRouteList[nSourceIndx][nIndx])

            ## Inter Array Part
            nStartIndx = arrInputRouteList[nInterSourceIndx].index(nInterSourceElem)
            nEndIndx = arrInputRouteList[nInterSourceIndx].index(nInterDestinationElem)

            if nEndIndx < nStartIndx:
                for nIndx in range(nStartIndx, nEndIndx, -1):
                    arrOutputRouteList.append(arrInputRouteList[nInterSourceIndx][nIndx])
            else:
                for nIndx in range(nStartIndx, nEndIndx):
                    arrOutputRouteList.append(arrInputRouteList[nInterSourceIndx][nIndx])

            ## Destination Array Part
            nStartIndx = arrInputRouteList[nDestinationIndx].index(nInterDestinationElem)
            nEndIndx = arrInputRouteList[nDestinationIndx].index(nDestination)

            if nEndIndx < nStartIndx:
                for nIndx in range(nStartIndx, nEndIndx - 1, -1):
                    arrOutputRouteList.append(arrInputRouteList[nDestinationIndx][nIndx])
            else:
                for nIndx in range(nStartIndx, nEndIndx + 1):
                    arrOutputRouteList.append(arrInputRouteList[nDestinationIndx][nIndx])

            print (arrOutputRouteList)
    else:
        ## Source Array Part
        nStartIndx = arrInputRouteList[nSourceIndx].index(nSource)
        nEndIndx = arrInputRouteList[nSourceIndx].index(arrIntersection[0])

        if nEndIndx < nStartIndx:
            for nIndx in range(nStartIndx, nEndIndx, -1):
                arrOutputRouteList.append(arrInputRouteList[nSourceIndx][nIndx])
        else:
            for nIndx in range(nStartIndx, nEndIndx):
                arrOutputRouteList.append(arrInputRouteList[nSourceIndx][nIndx])

        ## Destination Array Part
        nStartIndx = arrInputRouteList[nDestinationIndx].index(arrIntersection[0])
        nEndIndx = arrInputRouteList[nDestinationIndx].index(nDestination)

        if nEndIndx < nStartIndx:
            for nIndx in range(nStartIndx, nEndIndx - 1, -1):
                arrOutputRouteList.append(arrInputRouteList[nDestinationIndx][nIndx])
        else:
            for nIndx in range(nStartIndx, nEndIndx + 1):
                arrOutputRouteList.append(arrInputRouteList[nDestinationIndx][nIndx])

        print (arrOutputRouteList)
