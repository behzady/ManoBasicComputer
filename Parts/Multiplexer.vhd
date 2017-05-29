--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Multipelexer
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity Multiplexer is
	generic(N: integer:=3);
	port(
		Q:	out std_logic;
		E:	in std_logic:= '1';
		S:  in std_logic_vector(n-1 downto 0);
		I:	in std_logic_vector(2**n-1 downto 0)
	);
end Multiplexer;

architecture Structure of Multiplexer is
	signal ou: std_logic_vector(1 downto 0);
	component multiplexerBasic is
		port(
			Q:	out std_logic;
			E:	in std_logic:= '1';
			S:  in std_logic;
			I:	in std_logic_vector(1 downto 0):="00"
		);
	end component;
	component Multiplexer is
		generic(N: integer:=3);
		port(
			Q:	out std_logic;
			E:	in std_logic:= '1';
			S:  in std_logic_vector(n-1 downto 0);
			I:	in std_logic_vector(2**n-1 downto 0)
		);
	end component;
begin
	mul0: multiplexerBasic port map(I=>ou, S=>S(n-1), E=>E, Q=>Q);  
	cond: if n = 1 generate
			ou <= I;
		end generate cond;
	Build:	if n>1 generate
		mulN0:component Multiplexer
			generic map(N=>n-1)
			port map(I=>I(2**(n-1)-1 downto 0), E=>E, S=>S(n-2 downto 0), Q=>ou(0));
		mulN1:component Multiplexer
			generic map(N=>n-1)
			port map(I=>I(2**n-1 downto 2**(n-1)), E=>E, S=>S(n-2 downto 0), Q=>ou(1));
		end generate Build;
end Structure;