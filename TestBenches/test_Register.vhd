--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Register
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity tb_reg is
end tb_reg;

architecture tb of tb_reg is
	signal	INC	:std_logic:='0';
	signal	LD	:std_logic:='0';
	signal	CLR	:std_logic:='0';
	signal	CLK	:std_logic;
	signal	Di	:std_logic_vector(3 downto 0);
	signal	Do	:std_logic_vector(3 downto 0);
	signal	Dno	:std_logic_vector(3 downto 0);
	signal	Co	:std_logic;
	signal  Check,e: std_logic:= '0';
	constant clock_peroid:time := 4 ns;
begin
	R:reg
		generic map(width => 4)
		port map(
			INC => INC,
			LD => LD,
			CLR => CLR,
			CLK => CLK,
			Di => Di,
			Do => Do,
			Dno => Dno,
			Co => Co
			);
	clo: process
	begin
		CLK <= '0';
		wait for clock_peroid/2;
		CLK <= '1';
		wait for clock_peroid/2;
		if (e = '1') then
			wait;
		end if;
	end process clo;
	chk: process
	begin
		wait for 1 ns;
		CLR <= '1';
		Di <= "0110";
		LD <= '1';
		wait for clock_peroid;
		if(Do = Di)then Check <= '1';
		else Check <= '0';
		end if;
		wait for 1 ns;
		LD <= '0';
		INC <= '1';
		if(to_integer(unsigned(Do)) = (to_integer(unsigned(Di))+1))then Check <= '0';
		else Check <= '1';
		end if;
		wait for clock_peroid;
		if(to_integer(unsigned(Do)) = (to_integer(unsigned(Di))+1))then Check <= '1';
		else Check <= '0';
		end if;
		CLR <= '0';
		wait for clock_peroid;
		if(Do = "0000") then Check <= '1';
		else Check <= '0';
		end if;
		e <= '1';
		wait;
	end process chk;
end tb;