--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--BUS
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity busLine is
	port(
		Ar: in word;
		PC: in word;
		DR: in word;
		AC: in word;
		IR: in word;
		TR: in word;
		Mm: in word;
		S: in ctrlBUS;
		Q: out word
	);
end busLine;

architecture Structure of busLine is
begin
	Q <= Ar when S = busAR 
	else PC when S = busPC 
	else DR when S = busDR 
	else AC when S = busAC 
	else IR when S = busIR 
	else TR when S = busTR 
	else Mm when S = busMm 
	else (Others => '0');
end Structure;