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

    w !,"device's built-in adapter:",deviceIn," jolts"
    w !,"1-jolt differences:",step1
    w !,"3-jolt differences:",step3
    w !,"them multyply:",step1*step3

/// part 2

    set w(0)=""
    set d(0)=1

    new visited
    set visit(device)=""


    w !,"part 2:",result
    quit
}

ClassMethod visit(node)
{
  set visited(node)=""
  for i=0:1:i<pathsLength do
  . if $INCREMENT(pathCount)
    if $DATA(visited(node)) do ..visit(i)
}

}
