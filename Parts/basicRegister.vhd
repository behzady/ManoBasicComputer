--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--RegisterBasic
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity registerBasic is
	port(
		INC	:in std_logic := '0';
		LD	:in std_logic := '0';
		CLR	:in std_logic := '1';
		CLK	:in std_logic := '0';
		Di	:in std_logic := '0';
		Do	:buffer std_logic := '0';
		Dno	:buffer std_logic;
		Co	:out std_logic := '0'
	);
end registerBasic;

architecture Structure of registerBasic is
	signal j,k: std_logic;
begin
	j <= INC or (Di and LD);
	k <= INC or ((not Di) and LD);
	flp0: flipflopJK port map(CLR=>CLR, CLK=>CLK, J=>j, K=>k, Q=>Do, nQ=>Dno);
	Co <= INC and Do;
end Structure;