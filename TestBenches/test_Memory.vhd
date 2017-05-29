--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Memory
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity Mem is
	port(
		CLK:in std_logic;
		ADR:in adr;
		ENR:in std_logic := '0';
		ENW:in std_logic := '0';
		DTW:in std_logic_vector(7 downto 0);
		DTR:out std_logic_vector(7 downto 0)
	);
end Mem;

architecture Structure of Mem is
	type vector8 is array (natural range <>) of std_logic_vector(7 downto 0);
	signal v: std_logic_vector(7 downto 0);
	signal v_normal_in_sig : vector8(4 downto 0);
	signal cs: std_logic_vector(3 downto 0);
	signal nadr:std_logic;
begin
	nadr <= not ADR(9);
	ROM0:Rom512x8 port map(ENR, nadr, CLK, ADR(sizeof_Adr-2 downto 0), v_normal_in_sig(4));
	RAM_GEN:
	for i in 0 to 3 generate
		RAMX:Ram128x8 port map(cs(i), ADR(9), CLK, ADR(sizeof_Adr-4 downto 0), ENR, ENW, DTW, v_normal_in_sig(i));
	end generate RAM_GEN;
	dec: Decoder port map(ADR(8 downto 7), '1', cs);
	DTR <= v_normal_in_sig(0) or v_normal_in_sig(1) or v_normal_in_sig(2) or v_normal_in_sig(3) or v_normal_in_sig(4);
end architecture;