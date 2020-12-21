Class aoc.day10 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day10.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, jj, line, arr, adapter
    
/// traverse bath file
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
    . set sortArr(adapter)=diff
    
    //do ##class(aoc.file).printArr($NAME(sortArr))
    w !,"device's built-in adapter:",$ORDER(sortArr(""),-1)," jolts"
    w !,"1-jolt differences:",step1
    w !,"3-jolt differences:",step3
    w !,"them multyply:",step1*step3



    w !,"end"
    quit
}

}
