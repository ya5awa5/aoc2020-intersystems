Class aoc.day12 Extends aoc.base
{

/// Description
ClassMethod part2() As %Status
{
    Set sc = $$$OK
    // do something
    set fileName="day12.txt"

/// read batch file to array
    set data = ##class(aoc.file).load2(fileName)

    set dirArr(0)="N"
    set dirArr(1)="E"
    set dirArr(2)="S"
    set dirArr(3)="W"
    
    ;The ship starts by facing east
    set dirIndex=1
    set towards=dirArr(dirIndex)
    
    ;The waypoint starts 10 units east and 1 unit north
    set x=10,y=1
    set newX=0, newY=0
    set erg=0 
	set iterator=data.%GetIterator()

    While iterator.%GetNext(.key,.val) { 
        Set d=$E(val,1)
        Set dist=$E(val,2,$L(val))
        ;w !,d 
        ;w !,dist
        
        if d="N" if $INCREMENT(y,dist)
        if d="S" if $INCREMENT(y,-dist)
        if d="W" if $INCREMENT(x,-dist)
        if d="E" if $INCREMENT(x,dist)
        
        ;Action R means to rotate the waypoint around the ship right (clockwise) the given number of degrees.
        if d="R" do
        . for j=1:1:dist/90 set x=x+y set y=(x-y) set x=x-y set y=-y
        
        ;Action L means to rotate the waypoint around the ship left (counter-clockwise) the given number of degrees.
        if d="L" do
        . for j=1:1:dist/90 set x=x+y set y=x-y set x=x-y set x=-x
        
        if d="F" do
        . set newX=newX+(x*dist)
        . set newY=newY+(y*dist)
    }
    w !,"x:",newX
    w !,"y:",newY
    w !
    ;w !,"x+y=",$ZABS(newX)+$ZABS(newY),!

    set sc=$ZABS(newX)+$ZABS(newY)
    Return sc
}

/// Description
ClassMethod part1() As %Status
{
    Set sc = $$$OK
    // do something
    set fileName="day12.txt"

/// read batch file to array
    set data = ##class(aoc.file).load2(fileName)

    set dirArr(0)="N"
    set dirArr(1)="E"
    set dirArr(2)="S"
    set dirArr(3)="W"
    
    ;The ship starts by facing east
    set dirIndex=1
    set towards=dirArr(dirIndex)
    
    set x=0,y=0
    set erg=0 
	set iterator=data.%GetIterator()

    While iterator.%GetNext(.key,.val) { 
        Set d=$E(val,1)
        Set dist=$E(val,2,$L(val))
        ;w !,d 
        ;w !,dist
        
        if d="N" if $INCREMENT(y,-dist)
        if d="S" if $INCREMENT(y,dist)
        if d="W" if $INCREMENT(x,-dist)
        if d="E" if $INCREMENT(x,dist)
        
        if d="R" do
        . set dirIndex=dirIndex+(dist/90)
        . if dirIndex>3 set dirIndex=dirIndex-4
        . set towards=dirArr(dirIndex)
        
        if d="L" do
        . set dirIndex=dirIndex-(dist/90) 
        . if dirIndex<0 set dirIndex=4+dirIndex
        . set towards=dirArr(dirIndex)
        
        if d="F" do
        . if towards="N" if $INCREMENT(y,-dist)
        . if towards="S" if $INCREMENT(y,dist)
        . if towards="W" if $INCREMENT(x,-dist)
        . if towards="E" if $INCREMENT(x,dist)
    }
    w !,"x:",x
    w !,"y:",y

    ;w !,"x+y=",$ZABS(x)+$ZABS(y)

    set sc=$ZABS(x)+$ZABS(y)
    Return sc
}

}
