Class aoc.day10 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day10.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, sortArr, adapter, step1, step3, adapterPrev, diff, deviceIn
    
/// sort adapters from file
/// part 1
    set i=""
    for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set adapter=@arrRef@(i)
    . set sortArr(adapter)=""

    set sortArr(0)=""           ;The charging outlet has an effective rating of 0 jolts      
    set step1=0                 ;1-jolt differences
    set step3=1                 ;3-jolt differences (device's built-in adapter is always 3 higher than the highest adapter (always a difference of 3).)
    set adapter=""
    for  set adapter=$ORDER(sortArr(adapter)) quit:adapter=""  do
    . //w !,"a:"_adapter
    . set adapterPrev=$ORDER(sortArr(adapter),-1) //w " ","aP:"_adapterPrev
    . set diff=adapter-adapterPrev
    . if diff=1 if $INCREMENT(step1)
    . else  if diff=3 if $INCREMENT(step3)
    . ;set sortArr(adapter)=diff
    
    //do ##class(aoc.file).printArr($NAME(sortArr))

    set deviceIn=$ORDER(sortArr(""),-1)

    w !,"device's built-in adapter:",deviceIn + 3," jolts"
    w !,"1-jolt differences:",step1
    w !,"3-jolt differences:",step3
    w !,"them multyply:",step1*step3

/// part 2
    new adjacencyList
    set adapter=""
    for  set adapter=$ORDER(sortArr(adapter)) quit:adapter=""  do
    . //w !,"a:"_adapter
    . set adjacencyList(adapter)=""
    . for j=1,2,3 do
    .. set possibleAddapter=adapter+j 
    .. if $DATA(sortArr(possibleAddapter)) set adjacencyList(possibleAddapter,adapter)=""
    
    ;do ##class(aoc.file).printArr($NAME(adjacencyList2))
    
    new waysToNode, visitedNodes, answer
    set waysToNode(0)=1
    set visitedNodes(0)="true"
    set answer=..count($NAME(adjacencyList), deviceIn)
    
    w !,"----part 2----"
    w !,"total number of ways: ",$g(answer)

    quit
}

/// count ways in graph adjacencyList
/// with Depth-first search (DFS) is an algorithm for traversing or searching tree or graph data structures.
ClassMethod count(graf, node)
{
    if $GET(visitedNodes(node))="true" quit waysToNode(node)
    
    new sum set sum=0
    set visitedNodes(node)="true"
    new c set c="" 
    for  set c=$ORDER(@graf@(node,c)) quit:c=""  set sum=sum+..count(graf, c)
    set waysToNode(node)=sum
    quit sum
}

}
