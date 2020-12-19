Class aoc.day7 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
    #Define SHINYGOLD "shiny gold"
	new fileName, arrRef
    set fileName="day7.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)
    
/// one more empty line as a last line in batch file.
    set @arrRef@($ORDER(@arrRef@(""),-1)+1)=""

    new i, j, line, lineRest, bagParent, piece, spaces, bagColor, bagColorRoot

/// part 1
    new parentArr, childArr
    
/// part 1
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set line=@arrRef@(i)
    . set bagColorRoot=$PIECE(line," ")_" "_$PIECE(line," ",2)
    . set lineRest=$PIECE(line,bagColorRoot,2) set lineRest=$EXTRACT(lineRest,2,$LENGTH(lineRest))
    . if $FIND(lineRest, $$$SHINYGOLD)=0 set shinyGoldFlag=0
    . else  set shinyGoldFlag=1
    . for j=1:1:$LENGTH(lineRest,"bag") do
    .. set piece=$PIECE(lineRest,"bag",j) quit:$LENGTH(piece)<3
    .. set spaces=$LENGTH(piece," ")
    .. set bagColor=$PIECE(piece," ",spaces-2)_" "_$PIECE(piece," ",spaces-1)
    .. if bagColorRoot=$$$SHINYGOLD  
    .. set parentArr(bagColor,bagColorRoot)=""
    .. set childArr(bagColorRoot,bagColor)=""

    //do ##class(aoc.file).printArr($NAME(parentArr))
    
    new result, jj, i
    if $$loop($$$SHINYGOLD, $NAME(parentArr))
    set i="" for  set i=$ORDER(result(i)) quit:i=""  if $INCREMENT(jj)
    w !,$GET(jj)

    new result, jj, i
    if $$loop($$$SHINYGOLD, $NAME(childArr))
    set i="" for  set i=$ORDER(result(i)) quit:i=""  if $INCREMENT(jj)
    w !,$GET(jj)

    quit





loop(root, arrRef)
    //if $ORDER(resArr(root,""))="" quit
    new node
    set node="" for  set node=$ORDER(@arrRef@(root,node)) quit:node=""  do
    . set result(node)=""
    . do loop(node, arrRef)

    quit 1
}

}
