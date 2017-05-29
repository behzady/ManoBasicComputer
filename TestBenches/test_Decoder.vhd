--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity tb_Decoder is
end tb_Decoder;

architecture tb of tb_Decoder is
	signal 	I:	std_logic_vector(3 downto 0);
	signal	E:	std_logic:= '0';
	signal	Q:	std_logic_vector(15 downto 0):=(Others => '0');
	signal  Check: std_logic := '1';
begin
	D0: Decoder
		generic map(N => 4)
		port	map(I => I, E => E, Q => Q);
	test: process
	begin
		for s in 0 to 15 loop
			I <= std_logic_vector(to_unsigned(s, I'length));
			wait for 1 ns;
			if(to_integer(unsigned(Q)) = 0) then Check <= '1';
			else Check <= '0';
			end if;
		end loop;
		E <= '1';
		for s in 0 to 15 loop
			I <= std_logic_vector(to_unsigned(s, I'length));
			wait for 1 ns;
			if(to_integer(unsigned(Q)) = 2**s) then Check <= '1';
			else Check <= '0';
			end if;
		end loop;
		wait;
	end process test;
end tb;