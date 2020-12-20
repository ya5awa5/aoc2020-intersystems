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

    new i, j, line, lineRest, piece, spaces, colorChild, colorRoot, quantity
    new parentArr, childArr
    
/// traverse bath file
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set line=@arrRef@(i)
    . set colorRoot=$PIECE(line," ")_" "_$PIECE(line," ",2)
    . set lineRest=$PIECE(line,colorRoot,2) set lineRest=$EXTRACT(lineRest,2,$LENGTH(lineRest))
    . if $FIND(lineRest, $$$SHINYGOLD)=0 set shinyGoldFlag=0
    . else  set shinyGoldFlag=1
    . for j=1:1:$LENGTH(lineRest,"bag") do
    .. set piece=$PIECE(lineRest,"bag",j) quit:$LENGTH(piece)<3
    .. set spaces=$LENGTH(piece," ")
    .. set colorChild=$PIECE(piece," ",spaces-2)_" "_$PIECE(piece," ",spaces-1)
    .. quit:colorChild="no other"
    .. set quantity=$PIECE(piece," ",spaces-3)
    .. if colorRoot=$$$SHINYGOLD  
    .. set parentArr(colorChild,colorRoot)=""
    .. set childArr(colorRoot,colorChild,quantity)=""

    //do ##class(aoc.file).printArr($NAME(childArr))
    //do ##class(aoc.file).printArr($NAME(parentArr))

/// part1    
    new result, jj, i
    set jj=0
    do ..countRelatives($$$SHINYGOLD,$NAME(parentArr),$NAME(result))
    set i="" for  set i=$ORDER(result(i)) quit:i=""  if $INCREMENT(jj)
    w !,"How many bag colors can eventually contain at least one shiny gold bag? ",!,jj

/// part2
    new result
    do ..countRelatives($$$SHINYGOLD,$NAME(childArr),$NAME(result))
    w !,"How many individual bags are required inside your single shiny gold bag? ",!,$GET(result)

    quit
}

/// recursion
ClassMethod countRelatives(root, arrRef, resultRef, inc)
{
    new node, multiply
    set inc=$GET(inc,1)
    set node="" for  set node=$ORDER(@arrRef@(root,node)) quit:node=""  do
    . set @resultRef@(node)=""
    . set multiply=$ORDER(@arrRef@(root,node,""))
    . set @resultRef=$GET(@resultRef)+(inc*multiply)
    . do ..countRelatives(node, arrRef, resultRef, inc*multiply)
}

}
