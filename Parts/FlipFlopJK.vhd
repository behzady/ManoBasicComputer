--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--FlipFlopJK
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity flipflopJK is
	port(
		J	: in		std_logic;
		K	: in		std_logic;
		CLK	: in		std_logic;
		CLR	: in		std_logic;
		Q	: buffer	std_logic;
		nQ	: buffer	std_logic
	);
end flipflopJK;

architecture Structure of flipflopJK is
	signal d: std_logic;
begin
	d <= (J and nQ) or (Q and (not K));
	flpD0: flipflopD port map(D=>d, CLR=>CLR, CLK=>CLK, Q=>Q, nQ=>nQ);
end Structure;