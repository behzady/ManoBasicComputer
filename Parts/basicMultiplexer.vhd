--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Multipelexer
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity multiplexerBasic is
	port(
		Q:	out std_logic;
		E:	in std_logic:= '1';
		S:  in std_logic;
		I:	in std_logic_vector(1 downto 0):="00"
	);
end multiplexerBasic;

architecture Structure of multiplexerBasic is
begin
	Q <= E and (((not S) and I(0)) or (S and I(1)));
end Structure;