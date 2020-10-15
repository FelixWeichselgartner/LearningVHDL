
library ieee;
use ieee.std_logic_1164.all;	 -- to use std_logic / std_logic_vector
use ieee.numeric_std.all;		 -- to use arithmetic functions
use ieee.std_logic_unsigned.all; -- add std_logic_vectors

entity adder is
    -- all ports of type std_logic / std_logic_vector
	port(a : in std_logic_vector(3 downto 0);
	     b : in std_logic_vector(3 downto 0);
         Q : out std_logic_vector(3 downto 0);
         c : out std_logic);
end adder;

architecture arch of adder is
    signal sum : std_logic_vector(4 downto 0);
begin
	
	-- combinational logic
    process (a, b)
    begin
        sum <= ('0' & a) + ('0' & b);
    end process;
    
    c <= sum(4);
    Q <= sum(3 downto 0);

end arch;

