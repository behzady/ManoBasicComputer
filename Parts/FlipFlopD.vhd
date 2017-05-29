--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--FlipFlopD
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

--edge Trigered
entity flipflopD is
	port(
		D	: in		std_logic := '0';
		CLK	: in		std_logic := '0';
		CLR	: in		std_logic := '1';
		Q	: buffer	std_logic := '0';
		nQ	: buffer	std_logic := '1'
	);
end flipflopD;

architecture Structure of flipflopD is
	signal s,r,rs,di: std_logic;
begin
	di <= D and (not CLR);
	Q <= s nand nQ;
	nQ <= Q nand r;
	s <= CLK nand (s nand rs);
	r <= not (s and CLK and rs);
	rs <= r nand di;
end Structure;

