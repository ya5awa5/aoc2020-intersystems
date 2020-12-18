Class aoc.day4 [ Not ProcedureBlock ]
{

ClassMethod Run()
{
	new fileName, arrRef
    set fileName="day4.txt"
	set arrRef=$name(^mtempX420) kill @arrRef

/// read batch file to array
	do ##class(aoc.file).load(fileName, arrRef)
	
/// one more empty line as a last line in batch file.
    set @arrRef@($O(@arrRef@(""),-1)+1)=""

/// required fields    
    new required
    set required("byr")=""
    set required("iyr")=""
    set required("eyr")=""
    set required("hgt")=""
    set required("hcl")=""
    set required("ecl")=""
    set required("pid")=""
    //set required("cid")=""

	new i, k, line, pair, passportIsValid, passportIsValidOLD, passportChecked
    new passportArr, validPassports, validPassportsOLD, field, value

/// traverse batch file
	set i="" for  set i=$ORDER(@arrRef@(i)) QUIT:i=""  do
    . set line=@arrRef@(i)
    . for k=1:1:$LENGTH(line," ") set pair=$PIECE(line," ",k) quit:pair=""  do 
    .. set field=$PIECE(pair,":")
    .. set value=$PIECE(pair,":",2)
    .. set passportArr(field)=value
    . quit:line'=""
    . ;
    . if $INCREMENT(passportChecked)
    . // check last collected passport
    . set passportIsValid=1
    . set passportIsValidOLD=1
    . //set field="" for  set field=$ORDER(required(field)) quit:field=""  quit:passportIsValid=0  do   ;speed up for isolate part2 mission.
    . set field="" for  set field=$ORDER(required(field)) quit:field=""  do
    .. if $DATA(passportArr(field))=0 set passportIsValid=0 set passportIsValidOLD=0 quit ;passport has'nt one of the required fields
    .. set value=passportArr(field)
    .. if field="byr" do  quit
    ... if value'?4N ! (value<1920!(value>2002)) set passportIsValid=0 quit
    .. if field="iyr" do  quit
    ... if value'?4N ! (value<2010!(value>2020)) set passportIsValid=0 quit
    .. if field="eyr" do  quit
    ... if value'?4N ! (value<2020!(value>2030)) set passportIsValid=0 quit
    .. if field="hgt" do  quit
    ... set mUnit=$EXTRACT(value,$LENGTH(value)-1,$LENGTH(value))
    ... if mUnit'?1(1"cm",1"in") set passportIsValid=0 quit
    ... set value=$EXTRACT(value,1,$LENGTH(value)-2)
    ... if mUnit="cm" if value'?.N !(value<150!(value>193)) set passportIsValid=0 quit
    ... if mUnit="in" if value'?.N !(value<59!(value>76)) set passportIsValid=0 quit
    .. if field="hcl" do  quit
    ... if value'?1"#"6AN set passportIsValid=0 quit  
    ... new char, code
    ... for k=2:1:7 do
    .... set char=$EXTRACT(value,k) 
    .... set code=$ASCII(char) 
    .... if '(code>47&(code<58))&'((code>96)&(code<103)) set passportIsValid=0 quit
    .. if field="ecl" do  quit
    ... if value'?1(1"amb",1"blu",1"brn",1"gry",1"grn",1"hzl",1"oth") set passportIsValid=0 quit
    .. if field="pid" do  quit
    ... if value'?9N set passportIsValid=0 quit
    . //
    . if passportIsValid=1 if $INCREMENT(validPassports)
    . if passportIsValidOLD=1 if $INCREMENT(validPassportsOLD)
    . kill passportArr


    w $C(10,13)
    w "passports checked:"_$GET(passportChecked)
    w $C(10,13)
    w "valid passports (part 1):"_$GET(validPassportsOLD)
    w $C(10,13)
    w "valid passports (part 2) :"_$GET(validPassports)
}

}
