LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;
ENTITY bus_bidir IS
PORT( CP,MR_BAR,DS0,DS7 : IN std_logic;
	S,OE_BAR : IN std_logic_vector(1 downto 0);
	Q0,Q7 : OUT std_logic;
	IO : INOUT std_logic_vector (7 downto 0));

END bus_bidir;


ARCHITECTURE marche of bus_bidir IS

signal INTERNE : std_logic_vector (7 downto 0);

begin
	process( MR_BAR, CP)

	begin 	
		if(MR_BAR='0') then
		INTERNE <= "00000000";
		elsif (CP'event and CP='1') then
			if(S="00") then
			null;
			elsif (S="01") 	THEN 
			INTERNE (7 downto 1) <= INTERNE (6 downto 0);
			INTERNE(0)<= DS0;
			
			elsif (S="10") 	THEN 
			INTERNE (6 downto 0) <= INTERNE (7 downto 1);
			INTERNE(7)<= DS7;
			elsif (S="11") then 
			INTERNE<= IO;
			
			else
			INTERNE <= "ZZZZZZZZ";

			end if;
		end if;

end process;

process (OE_BAR,S,INTERNE)
begin
	if (OE_BAR="01" or OE_BAR="10" or OE_BAR="11") then
	IO <="ZZZZZZZZ";
	elsif (OE_BAR="00") THEN
		if (S="11") then
		IO<= "ZZZZZZZZ";
		else 
		IO<= INTERNE;
		end if;
	end if;
end process;
Q7 <= INTERNE(7);
Q0<= INTERNE(0);
end marche;

----------------------------test bench--------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
USE IEEE.std_logic_unsigned.all;
ENTITY bus_bidir_tb IS

END  bus_bidir_tb;

ARCHITECTURE bus_bidir_tb_a  of bus_bidir_tb IS

signal CPt,MR_BARt,DS0t,DS7t :  std_logic :='0'; 
signal St,OE_BARt :  std_logic_vector(1 downto 0);
signal Q0t,Q7t :  std_logic;
signal IOt :  std_logic_vector (7 downto 0);

begin 

dut:

entity work.bus_bidir(marche)port map( CP=>CPt, MR_BAR=> MR_BARt, DS0=> DS0t, DS7=> DS7t,S=>St, OE_BAR=>OE_BARt, IO=>IOt);

CPt <= not(CPt) after 10 ns;
MR_BARt <= '0','1' after 40 ns;
OE_BARt <= "00", "01" after 400 ns,"10" after 800 ns, "11" after 1200 ns;
St <=  "00", "01" after 50 ns,"11" after 200 ns, "10" after 300 ns,"00" after 400 ns, "01" after 500 ns,"11" after 600 ns, "10" after 700 ns,"00" after 800 ns, "01" after 900 ns,"11" after 1000 ns, "10" after 1100 ns,"00" after 1200 ns, "01" after 1300 ns,"11" after 1400 ns, "10" after 1500 ns;
IOt<= "ZZZZZZZZ", "10001110" after 200 ns, "ZZZZZZZZ" after 300 ns;
DS0t<='1';
DS7t<='1';

end;
