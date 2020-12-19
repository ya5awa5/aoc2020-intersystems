Class aoc.day7 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day7.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)
    
/// one more empty line as a last line in batch file.
    set @arrRef@($ORDER(@arrRef@(""),-1)+1)=""

    new i, j, line, answer, groupAnswers, uniqAnswerCount, resultArr, groupNumber, personInGroup, unanimouslyAnswer

/// part 1
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set line=@arrRef@(i)
    . w line
}

}
