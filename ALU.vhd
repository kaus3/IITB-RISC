library ieee;
use ieee.std_logic_1164.all;

entity ALU is
port( alu_a : in std_logic_vector(15 downto 0);
      alu_b : in std_logic_vector(15 downto 0);
		ctrl : in std_logic;
		alu_out : out std_logic_vector(15 downto 0));
end entity ALU;

architecture desc of ALU is

component Add16 is 
port( inp1 : in std_logic_vector(15 downto 0);
      inp2 : in std_logic_vector(15 downto 0);
		sum : out std_logic_vector(15 downto 0));
end component Add16;
signal t: std_logic_vector(15 downto 0);
begin
add1: Add16
port map(alu_a,alu_b, t);	
process(alu_a,alu_b,ctrl)
begin
 if ctrl = '0' then
 alu_out <= t;
 elsif ctrl = '1' then
 alu_out <= (alu_a nand alu_b);
 else 
 alu_out <= (alu_a xor alu_b);
 end if;
end process;
end architecture;

		