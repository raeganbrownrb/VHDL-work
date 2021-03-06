library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity Tmod is
port ( clk2 , reset2 : in std_logic;
HH : out std_logic;
outt : out std_logic_vector ( 1 downto 0);
place: in std_logic_vector (3 downto 0);
JA : inout  STD_LOGIC_VECTOR (7 downto 0);
vs1, hs1: out std_logic;
		red1,grn1, blu1: out std_logic
		);
end;
architecture Beh of Tmod is
component clock1 
port (clk1, set : in STD_LOGIC;
        digit , choice: in std_logic_vector (3 downto 0);
        number1, number2, number3,number4 : out std_logic_vector(3 downto 0);
           reset1 : in STD_LOGIC;
           enter : out std_logic
          );
   end component;
component stopwatch 
      port(clks : in STD_LOGIC;
             reset22, stopon : in STD_LOGIC; 
             number1, number2, number3, number4: out std_logic_vector (3 downto 0);
                stop : in std_logic);
         end component;
  component Decoder is
          Port (  clk : in  STD_LOGIC;
                Row : in  STD_LOGIC_VECTOR (3 downto 0);
                   Col : out  STD_LOGIC_VECTOR (3 downto 0);
                   hit : out std_logic;
                DecodeOut : out  STD_LOGIC_VECTOR (3 downto 0));
          end component;
component FSM1 is
port ( clk , reset, hitter,enters : in std_logic;
 switch , pause , watch, resets, setter: out std_logic;
 state: out std_logic_vector (1 downto 0);
 button, C1,C2,C3,C4,S1,S2,S3,S4 : in std_logic_vector ( 3 downto 0);
 values : out std_logic_vector (3 downto 0);
 out1,out2,out3,out4: out std_logic_vector(3 downto 0));
end component;
component TheirVGA is
port(mclk: in std_logic;
data1, data2, data3, data4 : in std_logic_vector(3 downto 0);
		vs, hs: out std_logic;
		red, grn, blu: out std_logic);
end component;
signal CL1,Cl2,CL3,CL4,ST1,ST2,ST3,ST4, press, val, output1, output2, output3, output4 : std_logic_vector (3 downto 0);
signal pausing, setupon, watchset,R, H, clockset,E: std_logic := '0';
signal cs : std_logic_vector ( 1 downto 0);
  begin
  outt <= cs;
  instance: stopwatch
  port map (clks => clk2, reset22 => R,stopon =>watchset, stop => pausing ,number1 => ST1, number2 => ST2, number3 => ST3, number4=> ST4);
  instance1 : clock1
  port map (clk1 => clk2, reset1 => reset2, set => setupon, digit => place , choice => val, number1 => CL1, number2 => CL2, number3 => CL3,number4 => CL4, enter => E);        
  instance2 : FSM1
  port map ( clk => clk2, reset => reset2,  hitter => H, enters => E, switch => setupon,pause => pausing,watch => watchset,resets => R, setter => clockset,state => cs, button => press,values => val, C1 => CL1,C2 => CL2,C3 => CL3,C4 => CL4,S1 => St1,S2 => ST2,
  S3 =>St3,S4 => st4, out1 => output1,out2 => output2,out3 => output3,out4 => output4);
  instance4: Decoder port map (clk=>clk2, Row =>JA(7 downto 4), Col=>JA(3 downto 0), hit => H, DecodeOut=> press);
instance5 : TheirVGA
port map (mclk => clk2, data1 => output1, data2 => output2, data3 => output3, data4 => output4 , vs => vs1, hs => hs1,red => red1, grn => grn1, blu => blu1);
 HH <= H;
end beh;    
