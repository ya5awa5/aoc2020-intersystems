Class aoc.day10 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day10test.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, jj, line
    
/// traverse bath file
/// part 1
    for  set i=$ORDER(@arrRef@(i)) quit:i=""  quit:numberValid=0  do
    . set line=@arrRef@(i)
}

}
