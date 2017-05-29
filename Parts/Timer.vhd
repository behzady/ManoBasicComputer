--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Timer
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity Timer is
	port(
		CLK: in std_logic;
		CLR: in std_logic :='1';
		T:	 out std_logic_vector(7 downto 0)
	);
end Timer;

architecture Structure of Timer is
	signal count: std_logic_vector(2 downto 0);
begin
	counter: reg
		generic map(width => 3)
		port map(INC=>'1', CLR=>CLR, CLK=>CLK, Do=>count, Di => "000", LD=>'0');
	decode:decoder
		generic map(n => 3)
		port map(I=>count, E=>'1', Q=>T);
end Structure;