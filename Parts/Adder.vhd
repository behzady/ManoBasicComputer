--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Adder
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity fulladder is
	generic(width: integer := sizeof_Word);
	port(
		Ci: in std_logic:='0';
		A: in std_logic_vector(width-1 downto 0);
		B: in std_logic_vector(width-1 downto 0);
		S: out std_logic_vector(width-1 downto 0);
		Co: out std_logic
	);
end fulladder;

architecture Structure of fulladder is
	signal c: std_logic_vector(width-2 downto 0);
	component fulladderBasic is
		port(
			Ci: in std_logic:='0';
			A: in std_logic;
			B: in std_logic;
			S: out std_logic;
			Co: out std_logic
		);
	end component;
begin
	add0: fulladderBasic port map(Ci, A(0), B(0), S(0), c(0));
	add_GEN:
	for i in 1 to width-2 generate
	addX: fulladderBasic port map(c(i-1), A(i), B(i), S(i), c(i));
	end generate add_GEN;
	addn: fulladderBasic port map(c(width-2), A(width-1), B(width-1), S(width-1), Co);
end Structure;