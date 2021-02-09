/// part 1 do ##class(aoc.day22).Run1()
/// part 2 do ##class(aoc.day22).Run()
Class aoc.day22 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day22.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, j, value, player

/// parse file to player(1) and player(2) decks
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set value=@arrRef@(i)
    . if value="" quit
    . if value'=(+value) if $INCREMENT(jj) quit
    . set player(jj,$INCREMENT(player(jj)))=value

    do ##class(aoc.file).printArr($NAME(player))
    w !,"go!>>",!
    
    new debug set debug=0
    new gameCount

    new winner
    set winner=..subgame(.player)
    
    set result=0 set jj=0
    set i=""
    for  set i=$ORDER(player(winner,i),-1) quit:i=""  do
    . if $INCREMENT(jj)
    . set result=(player(winner,i)*jj)+result
    . set resultStr=$SELECT($GET(resultStr)="":"",1:resultStr_" + ")_jj_"*"_player(winner,i)

    w !,"part 2"
    w !,"winner:",winner
    w !,"winner's deck:"  
    d ##class(aoc.file).printArrRow($NAME(player(winner)))
    w !,"resultStr:",resultStr
    w !,"result:",result
}

ClassMethod subgame(ByRef cards)
{
    new setupSeen
    new card1, card2, setupHash, gameC, roundC
    
    set gameC=$INCREMENT(gameCount)

    set card1=$GET(cards(1,1))
    set card2=$GET(cards(2,1))

    while (card1'="")&&(card2'="") {
        if $INCREMENT(roundC(gameC))
        w gameC," >> "

        /// infinity loop    
        set setupHash=..getHash(.cards)
        if $DATA(setupSeen(setupHash)) {
            ;write:debug !,"seen before. player 1 wins!"
            write !,"seen before. player 1 wins!",!
            return 1
        }
        set setupSeen(setupHash)=""   
        
        if debug w !,"game ",gameCount," round ",roundC(gameC)
        if debug w !,"1: " do ##class(aoc.file).printArrRow($NAME(cards(1)))
        if debug w !,"2: " do ##class(aoc.file).printArrRow($NAME(cards(2)))

        ///subgame
        if ((cards(1)-1))>=card1 && ((cards(2)-1)>=card2) {
            new tmp
            for v=2:1:card1+1 set tmp(1,$INCREMENT(tmp(1)))=cards(1,v)
            for v=2:1:card2+1 set tmp(2,$INCREMENT(tmp(2)))=cards(2,v)
            new subDecks 
            merge subDecks=tmp
            write:debug !,"subgame starting.."
            set winner=..subgame(.subDecks)
        }
        ///regular won        
        else {
            if card1>card2 set winner=1
            else  set winner=2
        }
        ///new setup
        new newSetup, ii
        for ii=2:1:cards(1) set newSetup(1,$INCREMENT(newSetup(1)))=cards(1,ii)
        for ii=2:1:cards(2) set newSetup(2,$INCREMENT(newSetup(2)))=cards(2,ii)
        if winner=1 {
            set newSetup(1,$INCREMENT(newSetup(1)))=card1
            set newSetup(1,$INCREMENT(newSetup(1)))=card2
            }
        if winner=2 {
            set newSetup(2,$INCREMENT(newSetup(2)))=card2
            set newSetup(2,$INCREMENT(newSetup(2)))=card1
            }    
        kill cards
        merge cards=newSetup

        set card1=$GET(cards(1,1))
        set card2=$GET(cards(2,1))
    }
    write:debug !,"player "_winner," wins!",!
    
    return winner
}

/// make string from current cards setup "1,4,2,...,3 - 5,2,6,...,3" (cards1 - cards2)
/// to store setupSeen(SetupHash)
ClassMethod getHash(ByRef cards)
{
    set str1=""
    for i=1:1:cards(1) set k1=cards(1,i) quit:k1=""  set str1=$SELECT(str1="":"",1:str1_",")_k1
    
    set str2=""
    for i=1:1:cards(2) set k2=cards(2,i) quit:k2=""  set str2=$SELECT(str2="":"",1:str2_",")_k2
    
    set str=str1_" "_str2

    set hash=##class(%SYSTEM.Encryption).Base64Encode(##class(%SYSTEM.Encryption).MD5Hash(str))

    return hash
}

/// part1
ClassMethod Run1()
{
	new fileName, arrRef
    set fileName="day22test.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)

    new i, j, value, player, ind1, ind2, card1, card2, cardQuantity

/// part1
/// parse file to player(1) and player(2) decks
    set i="" for  set i=$ORDER(@arrRef@(i)) quit:i=""  do
    . set value=@arrRef@(i)
    . if value="" quit
    . if value'=+value if $INCREMENT(jj) set cardQuantity=0 quit
    . set player(jj)=$INCREMENT(cardQuantity)
    . set player(jj,cardQuantity)=value

    //do ##class(aoc.file).printArr($NAME(player)) 
    //quit

    new decksInitial
    merge decksInitial=player

/// game rounds
    for  set ind1=$ORDER(player(1,"")), ind2=$ORDER(player(2,"")) quit:ind1=""!(ind2="")  do
    . set card1=$GET(player(1,ind1))
    . set card2=$GET(player(2,ind2))
    . if card1>card2 do  quit
    .. set player(1,$ORDER(player(1,""),-1)+1)=card1 
    .. set player(1,$ORDER(player(1,""),-1)+1)=card2 
    .. kill player(1,ind1), player(2,ind2)
    . if card2>card1 do  quit
    .. set player(2,$ORDER(player(2,""),-1)+1)=card2
    .. set player(2,$ORDER(player(2,""),-1)+1)=card1 
    .. kill player(1,ind1), player(2,ind2)

    new winner, jj, result

    set result=0 set jj=0
    set winner=$ORDER(player(""))

    for  set i=$ORDER(player(winner,i),-1) quit:i=""  do
    . if $INCREMENT(jj)
    . set result=result+(jj*player(winner,i))

    w !,"result:",result
}

}
