--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Basic Computer
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity Mano is
end Mano;
architecture arch of Mano is
	component basicMano is
		port(
			CLK : in std_logic;
			MEM : buffer word := (Others => '0'); 
			PC  : buffer word := (Others => '0'); 
			DR  : buffer word := (Others => '0'); 
			AC  : buffer word := (Others => '0'); 
			IR  : buffer word := (Others => '0'); 
			TR  : buffer word := (Others => '0'); 
			BUSo: buffer word := (Others => '0');
			AR  : buffer adr  := (Others => '0');
			INPR: in std_logic_vector(7 downto 0);
			OUTR: out std_logic_vector(7 downto 0);
			FGI : buffer std_logic;
			FGO : buffer std_logic;
			sFGI: in std_logic:='0';
			sFGO: in std_logic:='0'
		);
	end component basicMano;

	signal CLK :std_logic;
	signal MEM :word; 
	signal PC  :word; 
	signal DR  :word; 
	signal AC  :word; 
	signal IR  :word; 
	signal TR  :word; 
	signal BUSo:word;
	signal AR  :adr;
	signal INPR:std_logic_vector(7 downto 0);
	signal OUTR:std_logic_vector(7 downto 0);
	signal FGI :std_logic;
	signal FGO :std_logic;
	signal sFGI:std_logic;
	signal sFGO:std_logic;

	constant CLK_Period: TIME := 100 ns;
begin
bc: basicMano port map(CLK, MEM, PC, DR, AC, IR, TR, BUSo, AR, INPR, OUTR, FGI, FGO, sFGI, sFGO);
	process
	begin
		CLK <= '0';
		wait for CLK_Period/2;
		CLK <= '1';
		wait for CLK_Period/2;
	end process;
end architecture;