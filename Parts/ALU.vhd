--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--ALU
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity ALU is
	generic(width: integer := sizeof_Word);
	port(
		Ei: in std_logic := '0';
		Eo: out std_logic;
		IP:	in std_logic_vector(7 downto 0);
		AC:	in word;
		DR:	in word;
		Q:	out word;
		cAND: in std_logic;
		cADD: in std_logic;
		cDR : in std_logic;
		cINR: in std_logic;
		cCOM: in std_logic;
		cSHR: in std_logic;
		cSHL: in std_logic
	);
end ALU;

architecture Structure of ALU is
signal inst: std_logic_vector(7 downto 0);
signal andc,addc,shrc,shlc: word;
signal addeo: std_logic;
begin
	andc <= AC and DR;
	fa: fulladder port map('0', AC, DR, addc, addeo);
	shlc(width-1 downto 1) <= AC(width-2 downto 0);
	shlc(0) <= Ei;
	shrc(width-2 downto 0) <= AC(width-1 downto 1);
	shrc(width-1) <= Ei;
	Q <= andc when cAND = '1'
		else addc when cADD = '1'
		else DR when cDR = '1'
		else "00000000"&IP when cINR = '1'
		else not AC when cCOM = '1'
		else shrc when cSHR = '1'
		else shlc when cSHL = '1'
		else AC;
	Eo <= addeo when cADD = '1'
		else AC(0) when cSHR = '1'
		else AC(width-1) when cSHL = '1'
		else '0' when cAND = '1'
		else '0' when cDR = '1'
		else '0' when cINR = '1'
		else '0' when cCOM = '1'
		else Ei;
end architecture;