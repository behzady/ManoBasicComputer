--Part of Mano Basic Computer
--Behzad Mokhtari; MokhtariBehzad@Gmail.com
--Sahand University of Technology; sut.ac.ir
--Licensed under GPLv3

--Basic Computer
Library IEEE;	use IEEE.std_logic_1164.ALL, IEEE.numeric_std.all;
Library manoBasic; use manoBasic.defines.all, manoBasic.devices.all;

entity basicMano is
	port(
		CLKi: in std_logic;
		INPR: in std_logic_vector(7 downto 0);
		OUTR: out std_logic_vector(7 downto 0);
		FGI : buffer std_logic;
		FGO : buffer std_logic;
		sFGI: in std_logic:='0';
		sFGO: in std_logic:='0'
	);
end basicMano;

architecture Scheme of basicMano is
	signal CLK, init:std_logic;
	signal I, R, E, IEN, S:std_logic;
	signal Ij, Rj, Ej, IENj, Sj, FGIj, FGOj:std_logic;
	signal Ik, Rk, Ek, IENk, Sk, FGIk, FGOk:std_logic;
	signal MEM, AR, PC, DR, AC, IR, TR, BUSo:word;
	signal T, D:std_logic_vector(7 downto 0);
	signal B:std_logic_vector(11 downto 0);
	signal MEMld, ARld, PCld, DRld, ACld, IRld, TRld:std_logic;
	signal ARinc, PCinc, DRinc, ACinc, TRinc:std_logic;
	signal ARclr, PCclr, DRclr, ACclr, TRclr, SCclr:std_logic;
	signal ACin:word;
	signal OUTRld:std_logic;
	signal rPC, rMEM, rIR, rTR, rAC, rAR, rDR:std_logic;
	signal BUSs:ctrlBUS;
	signal G, P:std_logic;
	signal cAND, cADD, cDR, cINR, cCOM, cSHR, cSHL:std_logic;
	signal Z, N:std_logic;
	signal Eo:std_logic;

begin
	CLK <= CLKi and S;

	Iff:	flipflopJK port map(Ij, Ik, CLK, '1', I);
	Rff:	flipflopJK port map(Rj, Rk, CLK, '1', R);
	Eff:	flipflopJK port map(Ej, Ek, CLK, init, E);
	IENff:	flipflopJK port map(IENj, IENk, CLK, '1', IEN);
	Sff:	flipflopJK port map(Sj, Sk, CLK, '1', S);
	FGIff:	flipflopJK port map(FGIj, FGIk, CLK, '1', FGI);
	FGOff:	flipflopJK port map(FGOj, FGOk, CLK, '1', FGO);

	MEMM:	Memory port map(CLK, AR(11 downto 0), '1', MEMld, BUSo, MEM);
	
	ARR:	reg	generic map(width => sizeof_Adr)
		port map(ARinc, ARld, ARclr, CLK, BUSo(11 downto 0), AR);
	PCR:	reg port map(PCinc, PCld, PCclr, CLK, BUSo, PC);
	DRR:	reg port map(DRinc, DRld, DRclr, CLK, BUSo, DR);
	ACR:	reg port map(ACinc, ACld, ACclr, CLK, ACin, AC);
	IRR:	reg port map('0', IRld, '0', CLK, BUSo, IR);
	TRR:	reg port map(TRinc, TRld, TRclr, CLK, BUSo, TR);
	OUTRR:	reg generic map(width => 8)
		port map('0', OUTRld, '1', CLK, BUSo(7 downto 0), OUTR);
	
	ALUM:	ALU port map(E, Eo, INPR, AC, DR, ACin,
		cAND, cADD, cDR, cINR, cCOM, cSHR, cSHL);

	SCT:	Timer port map(CLK, SCclr, T);
	
	BUSP: 	busLine port map(AR, PC, DR, AC, IR, TR, MEM, BUSs, BUSo);
	
	DD: 	Decoder generic map(N => 3)
		port map(IR(14 downto 12), '1', D);
	
	G <= D(7) and (not I) and T(3);
	P <= D(7) AND 	   I  and T(3);
	B <= IR(11 downto 0);

	N <= ACin(15);
	Z <= '1' when to_integer(unsigned(ACin)) = 0 else '0';
	--MEM
	MEMld <= (R and T(1)) or ((D(3) or D(5)) and T(4)) or (D(6) and T(6));

	--AR
	ARld  <= ((T(0) or T(2)) and not R) or ((not D(7)) and I and T(3));
	ARinc <= D(5) and T(4);
	ARclr <= R and T(0);

	--PC
	PCld  <= (D(4) and T(4)) or (D(5) and T(5));
	PCinc <= ((not R) and T(1)) or (R and T(2)) or (D(6) and T(6) and Z) or 
		(((B(4) and not N) or (B(3) and N) or (B(2) and Z) or (B(1) and not E)) and G) or
		(((B(9) and FGI) or (B(8) and FGO)) and P);
	PCclr <= R and T(1);	
	--DR
	DRld  <= (T(4) and (D(0) or D(1) or D(2) or D(6))) or (D(6) and T(5));
	--AC
	ACld  <= (T(5) and (D(0) or D(1) or D(2))) or (G and B(9)) or (P and B(11));
	ACinc <= G and B(5);
	ACclr <= G and B(11);
	--IR
	IRld  <= T(1) and not R;
	--TR
	TRld  <= T(0) and R;
	--OUTR
	OUTRld <= P and B(10);
	--SC
	SCclr <= (R and T(2)) or (T(5) and (D(0) or D(1) or D(2) or D(5))) or
		(T(4) and (D(3) or D(4))) or G or P;
	--I
	Ij <= (T(2) and not R) and IR(15);
	Ik <= (T(2) and not R) and not IR(15);
	--R
	Rj <= IEN and (FGI or FGO) and not (T(0) or T(1) or T(2));
	Rk <= R and T(2);
	--E
	Ej <= (((D(1) and T(5)) or (G and (B(7) or B(6)))) and Eo) or (G and B(8) and E);
	Ek <= (((D(1) and T(5)) or (G and (B(7) or B(6)))) and not Eo) or (G and (B(10) or (B(8) and E)));
	--IEN
	Ej <= P and B(7);
	Ek <= (R and T(2)) or (P and B(6));
	--S
	Sj <= not Sk;
	Sk <= G and B(0);
	--FGIO
	FGIj <= sFGI;
	FGIK <= P and B(11);
	FGOj <= sFGO;
	FGOK <= P and B(10);

	--ALU
	cAND <= D(0) and T(5);
	cADD <= D(1) and T(5);
	cDR  <= D(2) and T(5);
	cINR <= P and B(11);
	cCOM <= G and B(9);
	cSHR <= G and B(7);
	cSHL <= G and B(6);

	--BUS
	rMEM <= (T(1) and not R) or (T(3) and I and not D(7)) or 
		(T(4) and (D(0) or D(1) or D(2) or D(6)));
	rPC <= T(0) or (D(5) and T(4));
	rIR <= T(2) and not R;
	rTR <= R and T(1);
	rAC <= (D(3) and T(4)) or (P and B(10));
	rAR <= (D(4) and T(4)) or (D(5) and T(5));
	rDR <= D(6) and T(6);
	BUSs(2) <= rMEM or rIR or rTR or rAC;
	BUSs(1) <= rPC or rMEM or rTR or rDR;
	BUSs(0) <= rMEM or rIR or rAR or rDR;

	START: process
	begin
		init <= '0';
		wait until CLKi'event;
		init <= '1';
		wait;
	end process;

end Scheme;