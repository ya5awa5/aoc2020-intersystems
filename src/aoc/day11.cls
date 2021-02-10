Class aoc.day11 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
    new fileName, map
    set fileName="day11.txt"

    #Define EMPTY "L"
    #Define OCCUPIED "#"
    #Define FLOOR "."

/// read batch file to array
	do ##class(aoc.file).load(fileName, $NAME(map))
    
    new resultLayer
    set debug=1

    new map1 
    merge map1=map

    do ..part1(.map1)

    ;w !,"result map1:"
    ;do ##class(aoc.file).printArr($NAME(map))
   
    set result=..getResult(.map1)
    write !,"part1=",result

    do ..part2(.map)
    set result=..getResult(.map)
    write !,"part2=",result

    quit
}

ClassMethod part2(ByRef map)
{
    new changes, row, rowNext, rowPrev, i, c, seat, newSeat, newRow, newLayer
    set changes=0
    
    if $INCREMENT(roundCount)
    write:debug !,"next layer >> ",roundCount,!
    ;if debug w ! do ##class(aoc.file).printArr($NAME(map))
    
    set i=$ORDER(map(""))

    While (i'="") {
        set row=$GET(map(i))
        set rowPrev=$GET(map(i-1))
        set rowNext=$GET(map(i+1))

        set newRow=row
        for c=1:1:$LENGTH(row) {
            set seat=$EXTRACT(row,c)
            ;set visibleOcc=..getVisibleOcc()

            set newSeat=seat

            if seat=$$$EMPTY &&(..getVisibleOcc()=0) do
                . set newSeat=$$$OCCUPIED
                . set changes=1
                
            else  if seat=$$$OCCUPIED &&(..getVisibleOcc()>=5) do
                . set newSeat=$$$EMPTY 
                . set changes=1

            else  set newSeat=seat

            set $EXTRACT(newRow,c)=newSeat
        }

        set newLayer(i)=newRow

        set i=$ORDER(map(i))
}
    kill map 
    merge map=newLayer

    if changes=1 do ..part2(.map)
    quit
}

ClassMethod part1(ByRef map, resRef)
{
    new changes, row, rowNext, rowPrev, i, c, seat, newSeat, newRow, newLayer
    set changes=0
    
    if $INCREMENT(roundCount)
    write:debug !,"next layer >> ",roundCount,!
    ;if debug w ! do ##class(aoc.file).printArr($NAME(map))
    
    set i=$ORDER(map(""))

    While (i'="") {
        set row=$GET(map(i))
        set rowPrev=$GET(map(i-1))
        set rowNext=$GET(map(i+1))

        set newRow=row
        for c=1:1:$LENGTH(row) {
            set seat=$EXTRACT(row,c)
            set adjOccup=..getAdjOcc()

            if seat=$$$EMPTY &&(..getAdjOcc()=0) do
                . set newSeat=$$$OCCUPIED
                . set changes=1
                
            else  if seat=$$$OCCUPIED &&(..getAdjOcc()>=4) do
                . set newSeat=$$$EMPTY 
                . set changes=1

            else  set newSeat=seat

            set $EXTRACT(newRow,c)=newSeat
        }

        set newLayer(i)=newRow

        set i=$ORDER(map(i))
}
    kill map 
    merge map=newLayer

    if changes=1 do ..part1(.map)
    quit
}

/// number of OCCUPIED seats adjacent to a given seat.
ClassMethod getAdjOcc() As %Status
{
    Set res = 0
    // do something
    if $EXTRACT(row,c-1)=$$$OCCUPIED if $INCREMENT(res)
    if $EXTRACT(row,c+1)=$$$OCCUPIED if $INCREMENT(res)
    if $EXTRACT(rowPrev,c)=$$$OCCUPIED if $INCREMENT(res)
    if $EXTRACT(rowNext,c)=$$$OCCUPIED if $INCREMENT(res)
    if $EXTRACT(rowNext,c+1)=$$$OCCUPIED if $INCREMENT(res)
    if $EXTRACT(rowNext,c-1)=$$$OCCUPIED if $INCREMENT(res)
    if $EXTRACT(rowPrev,c+1)=$$$OCCUPIED if $INCREMENT(res)
    if $EXTRACT(rowPrev,c-1)=$$$OCCUPIED if $INCREMENT(res)

    return res
}

/// quntity of visible OCCUPIED seats.
/// Now, instead of considering just the eight immediately adjacent seats
/// consider the first seat in each of those eight directions.
ClassMethod getVisibleOcc() As %String
{
    new res, newSeat, charN, rowN, initChar, initRow, stop
    set res=0
    set initChar=c
    set initRow=i
    
    //N
    set stop=0
    for rowN=initRow-1:-1 quit:'$DATA(map(rowN))  quit:stop  do
    . set nextSeat=$EXTRACT(map(rowN),initChar)
    . if nextSeat=$$$OCCUPIED if $INCREMENT(res) set stop=1 quit
    . if nextSeat=$$$EMPTY set stop=1 quit
    
    //S
    set stop=0
    for rowN=initRow+1:1 quit:'$DATA(map(rowN))  quit:stop  do
    . set nextSeat=$EXTRACT(map(rowN),initChar)
    . if nextSeat=$$$OCCUPIED if $INCREMENT(res) set stop=1 quit
    . if nextSeat=$$$EMPTY set stop=1 quit
    
    //E
    set stop=0
    for charN=initChar+1:1 quit:$EXTRACT(map(initRow),charN)=""  quit:stop  do
    . set nextSeat=$EXTRACT(map(initRow),charN)
    . if nextSeat=$$$OCCUPIED if $INCREMENT(res) set stop=1 quit
    . if nextSeat=$$$EMPTY set stop=1 quit

    //W
    set stop=0
    for charN=initChar-1:-1 quit:$EXTRACT(map(initRow),charN)=""  quit:stop  do
    . set nextSeat=$EXTRACT(map(initRow),charN)
    . if nextSeat=$$$OCCUPIED if $INCREMENT(res) set stop=1 quit
    . if nextSeat=$$$EMPTY set stop=1 quit

    //NE
    set stop=0
    set charN=initChar
    for rowN=initRow-1:-1 quit:'$DATA(map(rowN))  quit:stop  do
    . if $INCREMENT(charN)
    . set nextSeat=$EXTRACT(map(rowN),charN)
    . if nextSeat=$$$OCCUPIED if $INCREMENT(res) set stop=1 quit
    . if nextSeat=$$$EMPTY set stop=1
   
    //NW
    set stop=0
    set charN=initChar
    for rowN=initRow-1:-1 quit:'$DATA(map(rowN))  quit:stop  do
    . if $INCREMENT(charN,-1)
    . set nextSeat=$EXTRACT(map(rowN),charN)
    . if nextSeat=$$$OCCUPIED if $INCREMENT(res) set stop=1 quit
    . if nextSeat=$$$EMPTY set stop=1

    //SE
    set stop=0
    set charN=initChar
    for rowN=initRow+1:1 quit:'$DATA(map(rowN))  quit:stop  do
    . if $INCREMENT(charN)
    . set nextSeat=$EXTRACT(map(rowN),charN)
    . if nextSeat=$$$OCCUPIED if $INCREMENT(res) set stop=1 quit
    . if nextSeat=$$$EMPTY set stop=1

    //SW
    set stop=0
    set charN=initChar
    for rowN=initRow+1:1 quit:'$DATA(map(rowN))  quit:stop  do
    . if $INCREMENT(charN,-1)
    . set nextSeat=$EXTRACT(map(rowN),charN)
    . if nextSeat=$$$OCCUPIED if $INCREMENT(res) set stop=1 quit
    . if nextSeat=$$$EMPTY set stop=1

    Return res
}

///  
ClassMethod getResult(ByRef map) As %String
{
    Set sc = 0
    // do something
    set i="" for  set i=$ORDER(map(i)) quit:i=""  do
    . set row=map(i)
    . for c=1:1:$LENGTH(row) do
    .. set seat=$EXTRACT(row,c)
    .. if seat=$$$OCCUPIED if $INCREMENT(sc)
    
    Return sc
}

}
