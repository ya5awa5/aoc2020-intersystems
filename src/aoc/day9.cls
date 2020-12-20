Class aoc.day9 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day9test.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, j, line, lineRest, piece, spaces, colorChild, colorRoot, quantity
    new parentArr, childArr
    
/// traverse bath file
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set line=@arrRef@(i)
}

}
