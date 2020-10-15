
library ieee;
use ieee.std_logic_1164.all;	-- to use std_logic / std_logic_vector
use ieee.numeric_std.all;		-- to use arithmetic functions

entity counter_2 is
    -- all ports of type std_logic / std_logic_vector
	port(CLK, CLR, EN : in std_logic;
	     dir : std_logic; -- 0: count down 1: count up
	     max : in std_logic_vector(3 downto 0); -- max value for counter
         Q : out std_logic_vector(3 downto 0));
end counter_2;

architecture archi of counter_2 is
    -- internal signals of type unsigned for arithmetic operations
	signal count, count_next: unsigned(3 downto 0);
begin
	
	-- combinational logic
    process (count, dir)
    begin
        if dir = '1' then
            count_next <= count + 1;
            
            if (count = unsigned(max) - 1) then
                count_next <= "0000";
            end if;
        else
            count_next <= count - 1;
            
            -- not clearly described how it should work
            if (count = "0000") then
                count_next <= unsigned(max) - 1;
            end if;
        end if;
        
        -- remove dir switching artefacts
        --if rising_edge(dir) then
        --    count_next <= "0000";
        --elsif falling_edge(dir) then
        --   count_next <= unsigned(max) - 1;
        --end if;
    end process;

	-- sequential logic
    process (CLK, CLR)
    begin
        if (CLR='1') then -- asynchronous reset
            if dir = '1' then
                count <= "0000";
            else
                count <= unsigned(max) - 1;
            end if;
        elsif (rising_edge(CLK)) then
            if (EN='1') then
                count <= count_next after 1 ns; -- after statement is ignored during synthesis
											    -- but simulation waveform clearer
--              count <= count_next;
          end if;
        end if;
    end process;

	-- output assignment
    Q <= std_logic_vector(count); -- conversion function required

end archi;

