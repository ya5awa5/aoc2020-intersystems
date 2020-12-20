Class aoc.day8 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day8.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, j, line
    new command, arg, accumulator, nextLine, lastLine, executedLines
    set accumulator=0
    set stop=0
    set nextLine=$ORDER(@arrRef@(""))
    set lastLine=$ORDER(@arrRef@(""),-1)

/// part1
/// executedLines - prevent a second execution of the same line.
    for  set line=@arrRef@(nextLine) quit:stop=1  quit:line=""  do
    . set command=$PIECE(line," ")
    . set arg=$PIECE(line," ",2)
    . if command="acc" set accumulator=accumulator+arg
    . if command="jmp" set nextLine=nextLine+arg
    . else  if $INCREMENT(nextLine)
    . if $DATA(executedLines(nextLine)) set stop=1 quit
    . set executedLines(nextLine)=""

    w !,"part 1"
    w !,"Immediately before instruction """,$GET(command)," ",$GET(arg),""" on line ",$GET(nextLine)," will be executed a second time,"
    w !,"value in the accumulator is: "_accumulator

/// part2
/// swapArr - already tryed swaps
/// swaped - one swap "jmp"<< >>"nop" already applyed
/// executedLines - prevent a second execution of the same line.
    new swaped, swapArr, swaps
    set reachLastLine=0
    new jj set jj=0
    for  quit:reachLastLine=1  do
    . quit:reachLastLine=1
    . if $INCREMENT(jj)
    . set accumulator=0
    . set swaped=0
    . set stop=0
    . new executedLines
    . set nextLine=$ORDER(@arrRef@(""))
    . for  set line=$GET(@arrRef@(nextLine)) quit:line=""!(stop=1)!(reachLastLine=1)  do
    .. if nextLine=lastLine set reachLastLine=1
    .. set command=$PIECE(line," ")
    .. set arg=$PIECE(line," ",2)
    .. if swaped=0 if '$DATA(swapArr(nextLine)) if (+arg)'=0 do
    ... if command="jmp" set command="nop" set swaped=1 set swapArr(nextLine)="" if $INCREMENT(swaps) quit
    ... if command="nop" set command="jmp" set swaped=1 set swapArr(nextLine)="" if $INCREMENT(swaps) quit
    .. if command="acc" set accumulator=accumulator+arg
    .. if reachLastLine=1 quit
    .. if command="jmp" set nextLine=nextLine+arg
    .. else  if $INCREMENT(nextLine)
    .. if $DATA(executedLines(nextLine)) set stop=1 quit
    .. set executedLines(nextLine)=""
    
    w !,"part 2"
    w !,"swaps:",swaps
    w !,"accumulator:",accumulator
}

}
