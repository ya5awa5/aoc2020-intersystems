Class aoc.day4 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName set fileName="day4.txt"
	new arrRef set arrRef=$name(^mtempX420) kill @arrRef
	do ##class(aoc.file).load(fileName, arrRef)
	
    w $DATA(@arrRef)
///
	new i
	set i="" for  set i=$ORDER(@arrRef@(i)) QUIT:i=""  do
    .
}

}
