Class aoc.day5 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day5.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)
    
    new i, j, string, low, high, row, column, seatIdArr, flag
/// traverse batch file
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set string=@arrRef@(i)
    . //w $C(13)_string
    . set low=0, high=127
    . for j=1:1:7 set flag=$EXTRACT(string,j) do 
    .. if flag="B" set low=low+((high-low+1)\2) set row=high
    .. if flag="F" set high=high-((high-low+1)\2) set row=low
    . //w $C(13)_"row:"_row
    . set low=0, high=7
    . for j=7:1:10 set flag=$EXTRACT(string,j) do 
    .. if flag="R" set low=low+((high-low+1)\2) set column=high
    .. if flag="L" set high=high-((high-low+1)\2) set column=low
    . //w " column:"_column
    . set seatIdArr(row*8+column)=""
    . //w "multiply:"_(row*8+column)

    w $C(10,13)_"highest ID:"_$ORDER(seatIdArr(""),-1)
}

}
