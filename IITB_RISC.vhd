library ieee;
use ieee.std_logic_1164.all;

entity temp is
port (inp: in std_logic_vector(15 downto 0);
      clk: in std_logic;
       op: out std_logic_vector(15 downto 0));
end entity;

architecture desc of temp is
begin
process(clk)
begin
if rising_edge(clk) then
  op <= inp;
end if;
end process;
end architecture;

library ieee;
use ieee.std_logic_1164.all;

library ieee;
use ieee.std_logic_1164.all;

entity IITB_RISC is
port( clk : in std_logic;
      rd_bar: in std_logic;
		wr_bar: in std_logic;
      ctrl : in std_logic_vector(43 downto 0));

end entity;

architecture desc of IITB_RISC is

signal pc,t1,t2,shift1,shift7,t3,alu_a,alu_b,alu_out,rfd1,rfd2,rfd3,rfa1,rfa2,rfa3,ir,z1,z2,z3,z4,z5,z6,z7,z8,z9,memd,mema,memout,z10,z11,z12,z13,z14,z15,address,z16 : std_logic_vector(15 downto 0);


component ALU is
port( alu_a : in std_logic_vector(15 downto 0);
      alu_b : in std_logic_vector(15 downto 0);
		ctrl : in std_logic;
		alu_out : out std_logic_vector(15 downto 0));
end component ALU;

component mux_4x1 is
port ( inp0: in std_logic_vector(15 downto 0);
          inp1: in std_logic_vector(15 downto 0);
			 inp2: in std_logic_vector(15 downto 0);
			 inp3: in std_logic_vector(15 downto 0);
          sel: in std_logic_vector(1 downto 0);
			 op: out std_logic_vector(15 downto 0));
end component;

component mux is
  port( inp0 : in std_logic_vector(15 downto 0);
        inp1 : in std_logic_vector(15 downto 0);
		  inp2 : in std_logic_vector(15 downto 0);
		  inp3 : in std_logic_vector(15 downto 0);
		  inp4 : in std_logic_vector(15 downto 0);
		  inp5 : in std_logic_vector(15 downto 0);
		  inp6 : in std_logic_vector(15 downto 0);
		  inp7 : in std_logic_vector(15 downto 0);
		  sel : in std_logic_vector(2 DOWNTO 0);
        op: out std_logic_vector(15 downto 0));
end component mux;

component demux_1x4 is
  port( inp : in std_logic_vector(15 downto 0);
		  sel : in std_logic_vector(1 downto 0);
        out0: out std_logic_vector(15 downto 0);
		  out1: out std_logic_vector(15 downto 0); 
		  out2: out std_logic_vector(15 downto 0);  
		  out3: out std_logic_vector(15 downto 0));
end component demux_1x4;

component temp is
port (inp: in std_logic_vector(15 downto 0);
      clk: in std_logic;
       op: out std_logic_vector(15 downto 0));
end component;

component demux is
  port( inp : in std_logic_vector(15 downto 0);
		  sel : in std_logic_vector(2 DOWNTO 0);
        out0: out std_logic_vector(15 downto 0); 
		  out1: out std_logic_vector(15 downto 0); 
		  out2: out std_logic_vector(15 downto 0);
        out3: out std_logic_vector(15 downto 0);
		  out4: out std_logic_vector(15 downto 0);
		  out5: out std_logic_vector(15 downto 0);
		  out6: out std_logic_vector(15 downto 0);
		  out7: out std_logic_vector(15 downto 0));
end component demux;

component mem is
port (mem_d : in std_logic_vector(15 downto 0);
      mem_a : in std_logic_vector(15 downto 0);
		rd_bar: in std_logic;
		wr_bar: in std_logic;
		clk : in std_logic;
		mem_out : out std_logic_vector(15 downto 0));
end component mem;

component mux_2x1 is
  port (w0, w1 : in std_logic_vector(15 downto 0);
        s : in std_logic;
     f : out std_logic_vector(15 downto 0)); 
end component mux_2x1;

component demux_1x2 is
  port( inp : in std_logic_vector(15 downto 0);
		  sel : in std_logic;
        out0: out std_logic_vector(15 downto 0); 
		  out1: out std_logic_vector(15 downto 0));
end component demux_1x2;

component se7 is
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end component se7;

component se10 is
port (inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end component se10;

component LeftShift1 is 
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end component LeftShift1;

component LeftShift7 is
port( inp : in std_logic_vector(15 downto 0);
       op : out std_logic_vector(15 downto 0));
end component LeftShift7;

component reg is
  port(inp : in std_logic_vector(15 downto 0);
       clk : in std_logic;
       op  : out std_logic_vector(15 downto 0));
end component reg;

component rf is
port( a1 : in std_logic_vector(2 downto 0);
      a2 : in std_logic_vector(2 downto 0);
		a3 : in std_logic_vector(2 downto 0);
		d3 : in std_logic_vector(15 downto 0);
		clk : in std_logic;
		d1 : out std_logic_vector(15 downto 0);
		d2 : out std_logic_vector(15 downto 0));
end component rf;


begin
dev1: mux_4x1
port map(pc,t1,z13,t2,ctrl(1 downto 0),alu_a);
dev2: mux
port map("0000000000000001",t2,shift1,z13,z11,"0000000000000000","0000000000000000","0000000000000000",ctrl(4 downto 2),alu_b);
dev3: ALU
port map(alu_a,alu_b,ctrl(5),alu_out);
dev4: demux_1x4
port map(alu_out,ctrl(7 downto 6),pc,t3,t1,t1);
z1(5 downto 0) <= ir(5 downto 0);
z1(15 downto 6) <= "0000000000";
z2(2 downto 0) <= ir(11 downto 9);
z2(15 downto 3) <= "0000000000000";
dev5: mux_4x1
port map(rfd1,z1,z2,alu_out,ctrl(9 downto 8),z3);
dev6: temp
port map(z3,clk,z4);
dev7: demux_1x4
port map(z4,ctrl(11 downto 10),alu_a,z12,memd,mema);
dev8: mux_4x1
port map(alu_out,memout,rfd1,"0000000000000000",ctrl(13 downto 12),z5);
dev9: temp
port map(z5,clk,z6);
dev10: demux_1x4
port map(z6,ctrl(15 downto 14),rfd1,mema,rfd3,memd);
z7(8 downto 0) <= ir(8 downto 0);
z7(15 downto 9) <= "0000000";
dev11: mux_4x1
port map(rfd2,z1,z7,rfd1,ctrl(17 downto 16),z8);
dev12: temp
port map(z8,clk,z9);
dev13: demux
port map(z9,ctrl(20 downto 18),alu_b,shift1,z12,z10,alu_a,alu_a,alu_a,alu_a);
dev14: mux_4x1
port map(pc,t3,t1,"0000000000000000",ctrl(22 downto 21),mema);
dev15: mux_2x1
port map(t1,t3,ctrl(23),memd);
dev16: mem
port map(memd,mema,rd_bar,wr_bar,clk,memout);
dev17: demux_1x2
port map(memout,ctrl(24),ir,t3);
dev18: mux_2x1
port map(t2,z7,ctrl(25),z10);
dev19: se7
port map(z10,z11);
dev20: demux_1x2
port map(z11,ctrl(26),alu_b,shift7);
dev21: mux_4x1
port map(t2,t1,z1,"0000000000000000",ctrl(28 downto 27),z12);
dev22: se10
port map(z12,z13);
dev23: demux_1x2
port map(z13,ctrl(29),alu_b,alu_a);
dev24: LeftShift1
port map(t2,alu_b);
dev25: LeftShift7
port map(z11,rfd3);
dev26: mux_2x1
port map(rfd1,alu_out,ctrl(30),z14);
dev27: reg
port map(z14,clk,z15);
dev28: demux_1x4
port map(z15,ctrl(32 downto 31),mema,alu_a,rfd3,rfd3);
dev29: mux
port map("0000000000000000","0000000000000001","0000000000000010","0000000000000011","0000000000000100","0000000000000101","0000000000000110","0000000000000111",ctrl(35 downto 33),address);
z16(2 downto 0) <= ir(8 downto 6);
z16(15 downto 3) <= "0000000000000";
dev30: mux_4x1
port map(z1,z2,z16,address,ctrl(37 downto 36),rfa1);
dev31: mux_2x1
port map(z16,z7,ctrl(38),rfa2);
dev32: mux_2x1
port map(z2,address,ctrl(39),rfa3);
dev33: mux_4x1
port map(t3,rfd3,pc,"0000000000000000",ctrl(41 downto 40),rfd3);
dev34: rf
port map(rfa1(2 downto 0),rfa2(2 downto 0),rfa3(2 downto 0),rfd3,clk,rfd1,rfd2);
dev35: demux_1x4
port map(rfd1,ctrl(43 downto 42), t1,t3,pc,t2);
end architecture;