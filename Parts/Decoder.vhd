--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Decoder
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity Decoder is
	generic(N: integer:=3);
	port(
		I:	in std_logic_vector(n-1 downto 0);
		E:	in std_logic:= '1';
		Q:	out std_logic_vector(2**n-1 downto 0):=(Others => '0')
	);
end Decoder;

architecture Structure of Decoder is
	signal en: std_logic_vector(1 downto 0);
	signal o0: std_logic_vector(2**(n-1)-1 downto 0);
	signal o1: std_logic_vector(2**(n-1)-1 downto 0);
	component decoderBasic is
		port(
			I:	in std_logic;
			E:	in std_logic:= '1';
			Q:	out std_logic_vector(1 downto 0):="00"
		);
	end component;
	component Decoder is
		generic(N: integer:=4);
		port(
			I:	in std_logic_vector(n-1 downto 0);
			E:	in std_logic:= '1';
			Q:	out std_logic_vector(2**n-1 downto 0):=(Others => '0')
		);
	end component Decoder;
begin
	dec0: decoderBasic port map(I=>I(n-1), E=>E, Q=>en);  
	cond: if n = 1 generate
			o0(0) <= en(0);
			o1(0) <= en(1);
		end generate cond;
	Build:	if n>1 generate
		decN0:component Decoder
			generic map(N=>n-1)
			port map(I=>I(n-2 downto 0), E=>en(0), Q=>o0);
		decN1:component Decoder
			generic map(N=>n-1)
			port map(I=>I(n-2 downto 0), E=>en(1), Q=>o1);
		end generate Build;
	Q <= o1 & o0;
end Structure;