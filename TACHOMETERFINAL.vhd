library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


----------------------------------------------------

entity TACHOMETERFINAL is

port(	clock:	in std_logic;
	clear:	in std_logic;
	count:	in std_logic; 
	cout:		out std_logic;
	bcd:	out std_logic_vector(6 downto 0));
	--Q:		buffer std_logic_vector(3 downto 0));
	
end TACHOMETERFINAL;

----------------------------------------------------

architecture arc of TACHOMETERFINAL is		  
    signal Pre_Q: std_logic_vector(3 downto 0);
	 signal Q: std_logic_vector(3 downto 0);
	 begin
    -- behavior describe the counter

process(clock, count, clear)
begin
 
if clear= '1' then
	Pre_Q <= Pre_Q - Pre_Q;
	cout <= '0';
elsif (clock='1' and clock'event) then
	if count = '1' then
		Pre_Q <= Pre_Q + 1;
		cout <= '0';
		if Pre_Q = "1001" then
			Pre_Q <= Pre_Q - Pre_Q;
			end if;
		if Pre_Q = "1000" then
			cout <= '1';
			end if;
	end if;
end if;
Q <= Pre_Q; -- concurrent assignment statement
end process;
 

-- BEGIN  DECODER

process (Q)
BEGIN

case  Q is
when "0000"=> bcd <="0000001";  -- '0'
when "0001"=> bcd <="1001111";  -- '1'
when "0010"=> bcd <="0010010";  -- '2'
when "0011"=> bcd <="0000110";  -- '3'
when "0100"=> bcd <="1001100";  -- '4' 
when "0101"=> bcd <="0100100";  -- '5'
when "0110"=> bcd <="0100000";  -- '6'
when "0111"=> bcd <="0001111";  -- '7'
when "1000"=> bcd <="0000000";  -- '8'
when "1001"=> bcd <="0000100";  -- '9'
when others=> bcd <="1111111";  -- BLANK

end case;
end process;
end arc;
