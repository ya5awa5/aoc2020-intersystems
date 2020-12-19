Class aoc.day6 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day6.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)
    
/// one more empty line as a last line in batch file.
    set @arrRef@($ORDER(@arrRef@(""),-1)+1)=""

    new i, j, line, answer, groupAnswers, uniqAnswerCount, resultArr, groupNumber, personInGroup, unanimouslyAnswer

/// part 1
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set line=@arrRef@(i)
    . if line'="" if $INCREMENT(personInGroup)
    . for j=1:1:$LENGTH(line) set answer=$EXTRACT(line,j) if $INCREMENT(groupAnswers(answer))
    . quit:line'=""
    . if $INCREMENT(groupNumber)
    . set uniqAnswerCount=0
    . set answer="" for  set answer=$ORDER(groupAnswers(answer)) quit:answer=""  if $INCREMENT(uniqAnswerCount)
    . quit:uniqAnswerCount=0
    . set resultArr(groupNumber)=uniqAnswerCount
    . set resultArr=$GET(resultArr)+uniqAnswerCount
    . kill groupAnswers kill personInGroup

    w $C(10)_"result:"_resultArr
    kill resultArr

///part 2
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set line=@arrRef@(i)
    . if line'="" if $INCREMENT(personInGroup)
    . for j=1:1:$LENGTH(line) set answer=$EXTRACT(line,j) if $INCREMENT(groupAnswers(answer))
    . quit:line'=""
    . if $INCREMENT(groupNumber)
    . set unanimouslyAnswer=0
    . set answer="" for  set answer=$ORDER(groupAnswers(answer)) quit:answer=""  do
    .. if groupAnswers(answer)=personInGroup if $INCREMENT(unanimouslyAnswer)
    . set resultArr(groupNumber)=unanimouslyAnswer
    . set resultArr=$GET(resultArr)+unanimouslyAnswer
    . kill groupAnswers kill personInGroup

    w $C(10)_"result:"_resultArr
}

}
