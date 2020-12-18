Class aoc.day2 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName set fileName="day2.txt"
	new arrRef set arrRef=$name(^mtempX420) kill @arrRef
	do util.file.load(fileName, arrRef)
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

}
