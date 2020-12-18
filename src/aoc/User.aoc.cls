Class User.aoc [ Not ProcedureBlock ]
{

ClassMethod load(file, arrRef)
{
	new dir set dir=##class(%SYSTEM.Process).CurrentDirectory()
	new path set path=dir_file
	if '##class(%File).Exists(path) quit
	set stream=##class(%Stream.FileCharacter).%New()
    set sc=stream.LinkToFile(path)
	if 'sc do $system.Status.DisplayError(sc) quit
    new array
	while 'stream.AtEnd {
		set line=stream.ReadLine()
		set array($increment(array))=line
		}
	m @arrRef=array
	quit
}

ClassMethod day2()
{
	new fileName set fileName="day2.txt"
	new arrRef set arrRef=$name(^mtempX420) kill @arrRef
	do ..load(fileName, arrRef)
	//w $data(@arrRef)

	new i, j, k, str, limits, low, high, char, pass, matchCounter, oldPolicyTotal, newPolicyTotal
/// 2-9 c: ccccccccc

	set i="" for  set i=$ORDER(@arrRef@(i)) QUIT:i=""  do
	. if $increment(k)
	. set str=$get(@arrRef@(i))
	. set limits=$piece(str," ")
	. set low=$piece(limits,"-")
	. set high=$piece(limits,"-",2)
	. set char=$piece($piece(str," ",2),":")
	. set pass=$piece(str," ",3)
	. set charOccured=0
	. for j=1:1:$L(pass) if $extract(pass,j)=char if $increment(charOccured)
	. if charOccured'<low if charOccured'>high if $increment(oldPolicyTotal) ;w $char(10,13)_str
	. if $EXTRACT(pass,low)=char!($EXTRACT(pass,high)=char) if '($EXTRACT(pass,low)=char&($EXTRACT(pass,high)=char)) if $increment(newPolicyTotal) w $C(10,13)_str
	
	w $char(10,13)_"checked passwords:"_$get(k)
	w $char(10,13)_"old policy valid passwords:"_$get(oldPolicyTotal)
	w $char(10,13)_"new policy valid passwords:"_$get(newPolicyTotal)
}

ClassMethod day3()
{
	new fileName set fileName="day3.txt"
	new arrRef set arrRef=$name(^mtempX420) kill @arrRef
	do ..load(fileName, arrRef)
	//w $data(@arrRef)

	new i, row, treeCounter, emptyCounter, positonGlobal, positonRow, rowLength
    new k, mark, stepRight, resArr

	for stepRight=1,3,5,7 do
	. set treeCounter=0, emptyCounter=0
    . set positonGlobal=1
	. set i="" for  set i=$ORDER(@arrRef@(i)) QUIT:i=""  do
	.. if $INCREMENT(k)
	.. set row=@arrRef@(i)
	.. set rowLength=$LENGTH(row)
	.. set positonRow=positonGlobal#rowLength
	.. if positonRow=0 set positonRow=rowLength
	.. if $EXTRACT(row,positonRow)="#" set mark="X" if $INCREMENT(treeCounter) 
    .. else  if $EXTRACT(row,positonRow)="." set mark="O" if $INCREMENT(emptyCounter)
	.. //w $C(10,13)_$EXTRACT(row,1,positonRow-1)_mark_$EXTRACT(row,positonRow+1,rowLength)
	.. set positonGlobal=positonGlobal+stepRight
	. set resArr(stepRight)=treeCounter

	set treeCounter=0, emptyCounter=0
    set positonGlobal=1
	
	for i=1:2:$O(@arrRef@(""),-1) do 
	. if '$D(@arrRef@(i)) quit
	. if $INCREMENT(k)
	. set row=@arrRef@(i)
	. set rowLength=$LENGTH(row)
	. set positonRow=positonGlobal#rowLength
	. if positonRow=0 set positonRow=rowLength
	. if $EXTRACT(row,positonRow)="#" set mark="X" if $INCREMENT(treeCounter) 
    . else  if $EXTRACT(row,positonRow)="." set mark="O" if $INCREMENT(emptyCounter)
	. w $C(10,13)_$EXTRACT(row,1,positonRow-1)_mark_$EXTRACT(row,positonRow+1,rowLength)
	. set positonGlobal=positonGlobal+1	
    
	set resArr("2.1")=treeCounter

    new multiplyAll set multiplyAll=1

	set i="" for  set i=$order(resArr(i)) quit:i=""  do 
	. w $C(10,13)
	. w "i="_i_", trees encountered:"_resArr(i)
	. s multiplyAll=multiplyAll*resArr(i)

	w $C(10,13)
	w "multiplyAll:"_multiplyAll

   /*
/// print result
    w $C(10,13)
	w "rows:"_k
	w $C(10,13)
	w "row's length:"_rowLength
	w $C(10,13)
	w "emptyes:"_emptyCounter
	w $C(10,13)
	w "trees encountered:"_treeCounter
	*/
}

}
