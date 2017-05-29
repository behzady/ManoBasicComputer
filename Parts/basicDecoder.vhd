--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity decoderBasic is
	port(
		I:	in std_logic;
		E:	in std_logic:= '1';
		Q:	out std_logic_vector(1 downto 0):="00"
	);
end decoderBasic;

architecture Structure of decoderBasic is
begin
	Q(0) <= (not I) and E;
	Q(1) <= I and E;
end Structure;