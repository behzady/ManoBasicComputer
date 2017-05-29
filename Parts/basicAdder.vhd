--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Adder
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity fulladderBasic is
	port(
		Ci: in std_logic:='0';
		A: in std_logic;
		B: in std_logic;
		S: out std_logic;
		Co: out std_logic
	);
end fulladderBasic;

architecture Structure of fulladderBasic is
begin
	S <= A xor B xor Ci;
	Co <= (A and B) or ((A xor B) and Ci);
end architecture;