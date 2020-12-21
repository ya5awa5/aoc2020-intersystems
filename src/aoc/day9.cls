Class aoc.day9 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
    new preambuleLENGTH set preambuleLENGTH=25
	new fileName, arrRef
    set fileName="day9.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, jj, line, preambule, nextNumber, thisNumber, prevNumber, numberValid, result
    
/// traverse bath file
/// part 1
    set numberValid=1
    set i=preambuleLENGTH 
    for  set i=$ORDER(@arrRef@(i)) quit:i=""  quit:numberValid=0  do
    . set thisNumber=@arrRef@(i)
    . set numberValid=0
    . kill preambule
    . for jj=1:1:preambuleLENGTH set preambule(@arrRef@(i-jj))=""
    . set prevNumber="" 
    . for  set prevNumber=$ORDER(preambule(prevNumber)) quit:prevNumber=""  quit:numberValid=1  do
    .. if $DATA(preambule(thisNumber-prevNumber)) set numberValid=1
    . if numberValid=0 set result=thisNumber

    w !,"part 1"
    w !,"res:",result
    w !

    
    new answerPart1, resArr, consValid, overlimit
/// part 2
/// consiqunce of numbers is valid for purpose
    set consValid=0
    set answerPart1=result
    set i="" 
    for  set i=$ORDER(@arrRef@(i)) quit:i=""  quit:consValid=1  do
    . set thisNumber=@arrRef@(i)
    . kill resArr
    . set sum=thisNumber
    . set cons=thisNumber
    . set resArr(thisNumber)=""
    . set overlimit=0
    . //nextNumbers
    . set j=i for  set j=$ORDER(@arrRef@(j)) quit:j=""  quit:overlimit=1  quit:consValid=1  do
    .. set nextNumber=@arrRef@(j)
    .. set sum=sum+nextNumber
    .. if sum>answerPart1 set overlimit=1 quit
    .. set resArr(nextNumber)=""
    .. set cons=cons_" "_nextNumber
    .. if sum=answerPart1 set consValid=1
    . //w !,cons,"=",sum

    //do ##class(aoc.file).printArr($NAME(resArr))
    new min, max
    set min=$O(resArr(""))
    set max=$O(resArr(""),-1)

    w !,"part 2"
    w !,"cons:",$GET(cons)
    w !,"min:",min," max:"_max," sum:",min+max
}

}
