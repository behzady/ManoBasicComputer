--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Register
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity reg is
	generic(width: integer := sizeof_Word);
	port(
		INC	:in std_logic := '0';
		LD	:in std_logic := '0';
		CLR	:in std_logic := '0';
		CLK	:in std_logic := '0';
		Di	:in std_logic_vector(width-1 downto 0) := (Others => '0');
		Do	:buffer std_logic_vector(width-1 downto 0):=(Others => '0');
		Dno	:buffer std_logic_vector(width-1 downto 0);
		Co	:out std_logic := '0'
	);
end reg;

architecture Structure of reg is
	signal c: std_logic_vector(width-2 downto 0);
	component registerBasic is
		port(
			INC	:in std_logic := '0';
			LD	:in std_logic := '0';
			CLR	:in std_logic := '0';
			CLK	:in std_logic := '0';
			Di	:in std_logic := '0';
			Do	:buffer std_logic := '0';
			Dno	:buffer std_logic;
			Co	:out std_logic := '0'
		);
	end component;
begin
	reg0: registerBasic port map(INC, LD, CLR, CLK, Di(0), Do(0), Dno(0), c(0));
	reg_GEN:
	for i in 1 to width-2 generate
	regX: registerBasic port map(c(i-1), LD, CLR, CLK, Di(i), Do(i), Dno(i), c(i));
	end generate reg_GEN;
	regn: registerBasic port map(c(width-2), LD, CLR, CLK, Di(width-1), Do(width-1), Dno(width-1), Co);
end Structure;