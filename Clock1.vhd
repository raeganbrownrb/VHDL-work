library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;
entity clock1 is
port (clk1, set : in STD_LOGIC;
        digit , choice: in std_logic_vector (3 downto 0);
        number1, number2, number3,number4 : out std_logic_vector(3 downto 0);
           reset1 : in STD_LOGIC;
           enter : out std_logic
          );
   end clock1;
architecture beh of clock1 is
signal nums1: std_logic_vector(3 downto 0);
signal nums2: std_logic_vector(3 downto 0) ;
signal nums3: std_logic_vector(3 downto 0):= "0010";
signal nums4: std_logic_vector(3 downto 0):="0001";
signal counter: STD_LOGIC_VECTOR (27 downto 0);
signal enable: std_logic;
signal sec : std_logic_vector (5 downto 0):= "000000";

begin   
number1 <= nums1;
number2 <= nums2;
number3 <= nums3;
number4 <= nums4;
process(clk1, reset1)
begin
        if(reset1='1') then
           counter <= (others => '0');
        elsif(clk1' event and clk1 = '1') then
            if(counter>=x"5F5E0FF") then
                counter <= (others => '0');
            else
               counter <= counter + "0000001";
            end if;
        end if;
end process;
    
enable <= '1' when counter=x"5F5E0FF" else '0';
process(clk1, reset1,set, enable, sec, nums1, nums2,nums3,nums4, digit, choice)
begin
        if(reset1='1') then
            nums1 <= (others => '0');
            nums2 <= (others => '0');
            nums3 <= (others => '0');
            nums4 <= (others => '0');
       
     elsif(clk1' event and clk1 = '1') then
             enter <= '0';
             if(enable = '1') then
            sec <= sec + "000001";
               if (sec = "111011") then
               sec <= "000000";
               if (nums4 = "0010" and nums3 = "0100" and nums2 = "0000" and nums1 = "0000") then
               nums4 <= "0000";
               nums3 <= "0000"; 
               nums2 <= "0000";
               nums1 <= "0000";
               else
               nums1 <= nums1 + "0001"; -- and increment a min
                      if (nums1 = "1001") then -- min can not be higher than 9
                      nums1 <= "0000"; -- after hitting 9 , it resets
                      nums2 <= nums2 + "0001"; --tenmin place increments by 1
                      if (nums2 = "0101") then
                      nums2<= "0000"; -- after hitting 9 , it resets
                      nums3 <= nums3 + "0001"; -- hr place is incremented
                      if (nums4 = "0010") then
                       if (nums3 = "0100") then
                        nums3 <= "0001";-- after hitting 9 , it resets
                        end if;
                      elsif (nums4 = "0000" or nums4 = "0001") then
                         if nums3 = "1001" then
                         nums3 <= "0001";
                         nums4 <= nums4 + "0001"; -- tenhr incremented
                          if (nums4 = "0010") then 
             -- because military time it does not go past 2
                           nums4 <= "0000";
                       end if;
                              end if;
                              end if;
                              end if;
                              end if;
                              end if;
                              end if;
                             
           end if;
           end if;
  
end process;
end beh;