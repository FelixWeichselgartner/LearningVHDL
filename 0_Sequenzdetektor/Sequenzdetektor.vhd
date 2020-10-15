
library ieee;
use ieee.std_logic_1164.all;	 -- to use std_logic / std_logic_vector
use ieee.numeric_std.all;		 -- to use arithmetic functions
use ieee.std_logic_unsigned.all; -- add std_logic_vectors

entity sequence_detector is
    -- all ports of type std_logic / std_logic_vector
	port(x :   in std_logic;
	     clk : in std_logic;
         y :   out std_logic;
         current_seq: out std_logic_vector (2 downto 0));
end sequence_detector;

architecture arch of sequence_detector is
    signal sequence : std_logic_vector(2 downto 0) := "000";
    signal q: std_logic := '0';
begin
	
	-- sequential logic
    process (clk)
    begin
        if rising_edge(clk) then
            sequence <= x & sequence(2) & sequence(1);
        end if;
    end process;
    
    -- combinational logic
    process (sequence)
    begin
        if sequence = "010" then
            y <= '1';
        else
            y <= '0';
        end if;
    end process;
    
    current_seq <= sequence;
    -- y <= q;

end arch;

