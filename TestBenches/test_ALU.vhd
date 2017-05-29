--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--ALU
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity tb_ALU is
end tb_ALU;

architecture tb of tb_ALU is
	signal	cmd: instALU;
	signal	Ei: std_logic := '0';
	signal	Eo: std_logic;
	signal	IP:	std_logic_vector(15 downto 0);
	signal	AC:	std_logic_vector(15 downto 0);
	signal	DR:	std_logic_vector(15 downto 0);
	signal	Q,qq:	std_logic_vector(15 downto 0);
	signal  Check: std_logic := '1';
begin
	A0: ALU
		generic map(width =>16)
		port	map(
			cmd => cmd,
			Ei => Ei,
			Eo => Eo,
			IP => IP,
			AC => AC,
			DR => DR,
			Q => Q
		);
	test: process
	begin
		IP <= "0000111100001111";
		cmd <= aluINPR;
		wait for 1 ns;
		if(IP = Q) then Check <= '1';
		else Check <= '0';
		end if;
		AC <= IP;
		DR <= not IP;
		cmd <= aluAND;
		wait for 1 ns;
		if(Q = (AC and DR)) then Check <= '1';
		else Check <= '0';
		end if;
		wait for 1 ns;
		cmd <= aluADD;
		wait for 1 ns;
		if(to_integer(unsigned(Q)) = (to_integer(unsigned(AC)) + to_integer(unsigned(DR)))) then Check <= '1';
		else Check <= '0';
		end if;
		wait for 1 ns;
		cmd <= aluDR;
		wait for 1 ns;
		if(Q = DR) then Check <= '1';
		else Check <= '0';
		end if;
		wait for 1 ns;
		cmd <= aluCOM;
		wait for 1 ns;
		if(Q = not AC) then Check <= '1';
		else Check <= '0';
		end if;
		wait for 1 ns;
		cmd <= aluSHR;
		qq <= '0' & AC(15 downto 1);
		wait for 1 ns;
		if(Q = qq) then Check <= '1';
		else Check <= '0';
		end if;
		wait for 1 ns;
		cmd <= aluSHL;
		qq <= AC(14 downto 0) & '0';
		wait for 1 ns;
		if(Q = qq) then Check <= '1';
		else Check <= '0';
		end if;
		wait;
	end process test;
end architecture tb;