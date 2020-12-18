Class aoc.day5 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day5.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

/// traverse batch file
	set i="" for  set i=$ORDER(@arrRef@(i)) QUIT:i=""  do
    .
}

}
