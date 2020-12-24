Class aoc.day22 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day22.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, j, value, player, ind1, ind2, card1, card2, cardQuantity, roundsCount

    new logYES set logYES=0
    set roundsCount=0

/// part1
/// parse file to player(1) and player(2) decks
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set value=@arrRef@(i)
    . if value="" quit
    . if value'=(+value) if $INCREMENT(jj) set cardQuantity=0 quit
    . set player(jj)=$INCREMENT(cardQuantity)
    . set player(jj,cardQuantity)=value

    //do ##class(aoc.file).printArr($NAME(player)) 
    //quit

/// if there was a previous round in this game that had exactly the same cards 
/// in the same order in the same players' decks, the game instantly ends in a win for player 1.
    new winner, subGameCount, gameCount, dangerOfLoop
    
    set winner=..subgame($NAME(player))
    
    set result=0 set jj=0
    set i=""
    for  set i=$ORDER(player(winner,i),-1) quit:i=""  do
    . if $INCREMENT(jj)
    . set result=(player(winner,i)*jj)+result
    . set resultStr=$SELECT($GET(resultStr)="":"",1:resultStr_" + ")_jj_"*"_player(winner,i)

    w !,"part 2"
    w !,"dangerOfLoop:",$g(dangerOfLoop)
    w !,"roundsCount:",$g(roundsCount)
    w !,"gameCount:",$g(gameCount)
    w !,"winner:",winner
    w !,"winner's deck:"  
    d ##class(aoc.file).printArrRow($NAME(player(winner)))
    w !,"resultStr:",resultStr
    w !,"result:",result


   //do ##class(aoc.file).printArr($NAME(player))
}

ClassMethod subgame(ref)
{
    new ind1, ind2, card1, card2, winner, gameN, roundN, configurations
    set dangerOfLoop=0
    if $INCREMENT(gameCount)
    set gameN=gameCount
    set roundN=0
    ;set logYES=0

    for  set ind1=$ORDER(@ref@(1,"")), ind2=$ORDER(@ref@(2,"")) quit:ind1=""!(ind2="")!(dangerOfLoop=1)  do
    . if roundN>15 do 
    .. s a=1
    . set dangerOfLoop=..configurationMatching(ref)
    . if dangerOfLoop=1 do  quit
    .. w !,"dangerOfLoop:",dangerOfLoop
    . do ..configurationStore(ref)
    . if $INCREMENT(roundsCount) if $INCREMENT(roundN)
    . i logYES=1 do
    .. w !
    .. w !," round ",roundN," (game ",gameN,")"
    .. w !,"1 deck:"  
    .. d ##class(aoc.file).printArrRow($NAME(@ref@(1)))
    .. w !,"2 deck:"
    .. d ##class(aoc.file).printArrRow($NAME(@ref@(2)))
    . set card1=$GET(@ref@(1,ind1))
    . set card2=$GET(@ref@(2,ind2))
    . //subgame 
    . if (@ref@(1)-1)>=card1 if (@ref@(2)-1)>=card2 do  quit:dangerOfLoop=1
    .. if $INCREMENT(subGameCount)
    .. new v, h, playerSub
    .. set h=ind1, v=""  
    .. for  set h=$ORDER(@ref@(1,h)) quit:h=""  if $INCREMENT(v)  quit:v>card1  set playerSub(1,v)=@ref@(1,h)
    .. set playerSub(1)=card1
    .. set h=ind2, v=""
    .. for  set h=$ORDER(@ref@(2,h)) quit:h=""  if $INCREMENT(v)  quit:v>card2  set playerSub(2,v)=@ref@(2,h)
    .. set playerSub(2)=card2
    .. //subgame call
    .. set winner=..subgame($NAME(playerSub))
    . 
    . else  if card1>card2 set winner=1
    . else  if card2>card1 set winner=2
    . //set new configuration
    . new ff, tmp, ii, indTmp
    . for ii=2:1:@ref@(1) if $INCREMENT(tmp(1)) set tmp(1,tmp(1))=@ref@(1,ii)
    . for ii=2:1:@ref@(2) if $INCREMENT(tmp(2)) set tmp(2,tmp(2))=@ref@(2,ii)
    . if winner=1 do
    .. set tmp(1,$INCREMENT(tmp(1)))=card1
    .. set tmp(1,$INCREMENT(tmp(1)))=card2
    . if winner=2 do
    .. set tmp(2,$INCREMENT(tmp(2)))=card2
    .. set tmp(2,$INCREMENT(tmp(2)))=card1
    .
    . kill @ref
    . merge @ref=tmp
    .
    . if logYES=1 do
    .. w !,card1," vs ",card2,"  winner:",winner
    
    if dangerOfLoop=1 set winner=1 set dangerOfLoop=0
    else  if $GET(@ref@(1))>$GET(@ref@(2)) set winner=1
    else  set winner=2

    w !,"game ",gameN," winner is: ",winner, "return to game ",gameN-1

    return winner
}

ClassMethod configurationMatching(ref)
{
    new configurationExist, t
    set configurationExist=0
    set t="" for  set t=$ORDER(configurations(t)) quit:t=""  quit:configurationExist=1  do
    . new match, currentCard, storedCard, index, playerC, tt
    . set match=1
    . for playerC=1,2 set index=0, tt="" for  set tt=$ORDER(@ref@(playerC,tt)) quit:tt=""  quit:match=0  do
    .. if $INCREMENT(index)
    .. set currentCard=@ref@(playerC,tt)
    .. set storedCard=$GET(configurations(t,playerC,index))
    .. if currentCard'=storedCard set match=0
    . if match=1 set configurationExist=1

    return configurationExist
}

ClassMethod configurationStore(ref)
{
    new playerC, ind, cc, kj
    
    if $INCREMENT(configurations)

    for playerC=1,2 do
    . set ind="" set cc="" 
    . for  set cc=$ORDER(@ref@(playerC,cc)) quit:cc=""  do
    .. if $INCREMENT(ind)
    .. set configurations(configurations,playerC,ind)=@ref@(playerC,cc)
    .. //if $G(roundsCount)>480 w !,$NAME(configurations(gameCount,configurations(gameCount),playerC,ind))

    quit 1
}

}