
library ieee;
use ieee.std_logic_1164.all;	-- to use std_logic / std_logic_vector
use ieee.numeric_std.all;		-- to use arithmetic functions

entity counter_1 is
    -- all ports of type std_logic / std_logic_vector
	port(CLK, CLR, EN : in std_logic;
         Q : out std_logic_vector(3 downto 0));
end counter_1;

architecture archi of counter_1 is
    -- internal signals of type unsigned for arithmetic operations
	signal count, count_next: unsigned(3 downto 0);
begin
	
	-- combinational logic
    process (count)
    begin
        count_next <= count + 1;
        if (count = "1100") then
          count_next <= "0000";
        end if;
    end process;

	-- sequential logic
    process (CLK, CLR)
    begin
        if (CLR='1') then -- asynchronous reset
            count <= "0000";
        elsif (rising_edge(CLK)) then
          if (EN='1') then
            count <= count_next after 1 ns; -- after statement is ignored during synthesis
											-- but simulation waveform clearer
--            count <= count_next;
          end if;
        end if;
    end process;

	-- output assignment
    Q <= std_logic_vector(count); -- conversion function required

end archi;

