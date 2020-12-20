Class aoc.day8 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
    #Define SHINYGOLD "shiny gold"
	new fileName, arrRef
    set fileName="day8.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)
    
/// one more empty line as a last line in batch file.
    //set @arrRef@($ORDER(@arrRef@(""),-1)+1)=""

    new i, j, line
    
/// traverse bath file
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set line=@arrRef@(i)
}

}
