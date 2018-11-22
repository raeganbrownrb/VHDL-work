----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2018 03:00:09 PM
-- Design Name: 
-- Module Name: FSM1 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FSM1 is
port ( clk , reset, hitter,enters : in std_logic;
 switch , pause , watch, resets, setter: out std_logic;
 state: out std_logic_vector (1 downto 0);
 button, C1,C2,C3,C4,S1,S2,S3,S4 : in std_logic_vector ( 3 downto 0);
 values : out std_logic_vector (3 downto 0);
 out1,out2,out3,out4: out std_logic_vector(3 downto 0));
   end;
architecture beh of FSM1 is
 signal numbers: std_logic_vector (3 downto 0);
 signal slow : std_logic;
 signal cs, ns : std_logic_vector (1 downto 0) := "00";
component CLockDivider
	port(clk : in std_logic;
        SlowClock : out std_logic);
end component;
begin
state <= cs;
numbers <= button;
 values <= numbers;
instance1 :  clockdivider
port map (clk => clk, slowclock => slow);
process(slow, reset)
begin
if reset = '1' then
cs <= "00";
elsif (slow'event and slow= '1') then
cs <= ns;
end if;
end process;
process (cs,button, hitter,C1,C2,C3,C4,S1,S2,S3,S4 )
begin
case cs is
when "00" =>
watch <= '0';
out1 <= C1;
out2 <= C2;
out3 <= C3;
out4 <= C4;
switch <= '0';
resets <= '1';
pause <= '1';
if button = "0001" then -- stopwatch
if hitter = '1' then
ns <= "01";
end if;
else
ns <= cs;
end if;
when "01" =>
out1 <= S1;
out2 <= S2;
out3 <= S3;
out4 <= S4;
watch <= '1';
resets <= '0';
pause <= '1';
switch <= '0';
if button = "0001" then
    if hitter ='1' then
    ns <= "00";
    end if;
 elsif button = "0010" then
 if hitter = '1' then
    ns <= "10";
    end if;
    elsif button = "0011" then
    if hitter = '1' then 
    resets <= '1';
    end if;
    else ns <= cs;
    end if;
when "10" =>
out1 <= S1;
out2 <= S2;
out3 <= S3;
out4 <= S4;
watch <= '1';
resets <= '0';
pause <= '0';
switch <= '0';
if button = "0001" then
        if hitter = '1' then
         ns <= "00";
         end if;
elsif button = "0010" then
 if hitter = '1' then
   ns <= "01";
   end if;
    elsif button = "0011" then
                 if hitter = '1' then 
                 resets <= '1';
                 ns <= "01";
                 end if;
    else ns <= cs;
end if;
when others =>
ns <= cs;
end case;
end process;
end Beh;
