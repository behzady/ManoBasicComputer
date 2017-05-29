--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Define basic variables
Library IEEE;	use IEEE.std_logic_1164.ALL;
package defines is
	constant	sizeof_Word:	integer:=16;
	constant	sizeof_Adr:		integer:=12;
	subtype		word	is		std_logic_vector(sizeof_Word-1 downto 0);
	subtype		adr		is		std_logic_vector(sizeof_Adr-1 downto 0);
	
	subtype		ctrlBUS	is std_logic_vector(2 downto 0);

	constant hexFileMEM : string:="..\\HEXdata\\MEM.hex";
	--Bus selections
	constant busAR: ctrlBUS := "001";
	constant busPC: ctrlBUS := "010";
	constant busDR: ctrlBUS := "011";
	constant busAC: ctrlBUS := "100";
	constant busIR: ctrlBUS := "101";
	constant busTR: ctrlBUS := "110";
	constant busMm: ctrlBUS := "111";
end defines;