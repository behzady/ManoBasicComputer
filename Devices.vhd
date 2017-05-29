--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Devices
Library IEEE;	use IEEE.std_logic_1164.ALL;
Library manoBasic; use manoBasic.defines.all;

package devices is
	component Decoder is
		generic(N: integer:=4);
		port(
			I:	in std_logic_vector(n-1 downto 0);
			E:	in std_logic:= '1';
			Q:	out std_logic_vector(2**n-1 downto 0):=(Others => '0')
		);
	end component Decoder;
	component Multiplexer is
		generic(N: integer:=3);
		port(
			Q:	out std_logic;
			E:	in std_logic:= '1';
			S:  in std_logic_vector(n-1 downto 0);
			I:	in std_logic_vector(2**n-1 downto 0)
		);
	end component;
	component flipflopD is
		port(
			D	: in		std_logic := '0';
			CLK	: in		std_logic := '0';
			CLR	: in		std_logic := '0';
			Q	: buffer	std_logic := '1';
			nQ	: buffer	std_logic := '0'
		);
	end component flipflopD;
	component flipflopJK is
		port(
			J	: in		std_logic := '0';
			K	: in		std_logic := '0';
			CLK	: in		std_logic := '0';
			CLR	: in		std_logic := '0';
			Q	: buffer	std_logic := '1';
			nQ	: buffer	std_logic := '0'
		);
	end component flipflopJK;
	component reg is
		generic(width: integer := sizeof_Word);
		port(
			INC	:in std_logic := '0';
			LD	:in std_logic := '0';
			CLR	:in std_logic := '0';
			CLK	:in std_logic := '0';
			Di	:in std_logic_vector(width-1 downto 0);
			Do	:buffer std_logic_vector(width-1 downto 0);
			Dno	:buffer std_logic_vector(width-1 downto 0);
			Co	:out std_logic := '0'
		);
	end component reg;
	component fulladder is
		generic(width: integer := sizeof_Word);
		port(
			Ci: in std_logic:='0';
			A: in std_logic_vector(width-1 downto 0);
			B: in std_logic_vector(width-1 downto 0);
			S: out std_logic_vector(width-1 downto 0);
			Co: out std_logic
		);
	end component fulladder;
	component Timer is
		port(
			CLK: in std_logic;
			CLR: in std_logic :='0';
			T:	 out std_logic_vector(7 downto 0)
		);
	end component Timer;
	component ALU is
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
	end component ALU;
	component Memory is
		generic(FILENAME: string:=hexFileMEM);
		port(
			CLK:in std_logic;
			ADR:in adr;
			ENR:in std_logic := '0';
			ENW:in std_logic := '0';
			DTW:in word;
			DTR:out word
		);
	end component Memory;
	component busLine is
		port(
			Ar: in word;
			PC: in word;
			DR: in word;
			AC: in word;
			IR: in word;
			TR: in word;
			Mm: in word;
			S: in ctrlBUS;
			Q: out word
		);
	end component busLine;
end devices;