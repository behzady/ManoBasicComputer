--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Memory
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
use IEEE.std_logic_textio.all;
use STD.textio.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity Memory is
	generic(FILENAME: string:=hexFileMEM);
	port(
		CLK:in std_logic;
		ADR:in adr;
		ENR:in std_logic := '1';
		ENW:in std_logic := '0';
		DTW:in word;
		DTR:out word
	);
end Memory;

architecture Structure of Memory is
	signal w:std_logic;
	type 		ram_t   is array(0 to 4096-1) of word;

	-- Read a *.hex file
	impure function ReadMemFile(FileName : STRING) return ram_t is
		file FileHandle       : TEXT open READ_MODE is FileName;
		variable CurrentLine  : LINE;
		variable TempWord     : word;
		variable Result       : ram_t    := (others => (others => '0'));
	begin
		for i in 0 to 4096 - 1 loop
			exit when endfile(FileHandle);
			readline(FileHandle, CurrentLine);
			hread(CurrentLine, TempWord);
			Result(i)    := TempWord;
		end loop;
		return Result;
	end function ReadMemFile;

	--Write a *.hex file
	impure function WriteMemFile(FileName : STRING; RAM : RAM_T) return std_logic is
		file FileHandle       : TEXT open WRITE_MODE is FileName;
		variable CurrentLine  : LINE;
		variable TempWord     : word;
	begin
		for i in 0 to 4096 - 1 loop
			TempWord := RAM(i);
			hwrite(CurrentLine, TempWord);
			writeline(FileHandle, CurrentLine);
		end loop;
		return '0';
	end function WriteMemFile;

	signal ram    : ram_t    := ReadMemFile(FILENAME);
begin
	DTR <= ram(to_integer(unsigned(ADR))) when ENR='1' else (Others => 'Z');
	process(ram)
	begin
		w <= WriteMemFile(FILENAME, ram);
	end process;
	process(CLK)
	begin
		if(rising_edge(CLK)) then
			if(ENW = '1') then
				ram(to_integer(unsigned(ADR))) <= DTW;
			elsif(ENR = '1') then
				ram <= ReadMemFile(FILENAME);
			end if;
		end if;
	end process;
end architecture;