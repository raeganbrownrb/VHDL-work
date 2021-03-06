library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity stopwatch is
   port (clks : in STD_LOGIC;
              reset22, stopon : in STD_LOGIC; 
              number1, number2, number3, number4: out std_logic_vector (3 downto 0);
                 stop : in std_logic);
   end ;
architecture beh of stopwatch is

signal sec, nums2, nums3, nums4: std_logic_vector (3 downto 0) := "0000";
signal counter: STD_LOGIC_VECTOR (27 downto 0);
signal enable: std_logic;

begin
number1 <= sec;
number2 <= nums2;
number3 <= nums3;
number4 <= nums4;
process(clks, reset22)
begin
        if(reset22='1') then
          counter <= "0000000000000000000000000000";
        elsif(clks' event and clks = '1') then
            if(counter>=x"5F5E0FF") then
                counter <= "0000000000000000000000000000";
            else
              counter <= counter + "0000000000000000000000000001";
          end if;
        end if;
end process;
    
enable <= '1' when counter = x"5F5E0FF" else '0';

process(clks,enable,stopon, reset22, stop, sec, nums2, nums3, nums4)
begin
        if(reset22='1') then
            sec <= "0000";
            nums2 <= "0000";
            nums3 <= "0000";
            nums4 <= "0000";
            elsif stop = '1' then
             sec <= sec;
             nums2 <= nums2;
              nums3 <= nums3;
            nums4 <= nums4;
      
        elsif(clks' event and clks = '1' ) then
            if(enable = '1' and stopon = '1') then
                     sec <= sec + "0001";
                      if (sec = "1001") then
                      sec <= "0000";
                      nums2 <= nums2 + "0001";
                             if (nums2 = "0101") then 
                             nums2 <= "0000"; 
                             nums3 <= nums3 + "0001"; 
                             if (nums3 = "1001") then
                             nums3<= "0000"; 
                             nums4 <= nums4 + "0001"; 
                             if (nums4 = "1001") then
                              sec <= "0000";
                              nums2 <= "0000";
                              nums3 <= "0000";
                              nums4 <= "0000";
                              end if;
                              end if;
                              end if;
                              end if;
                         end if;
                              end if;
                      
              
  
end process;

end beh;
