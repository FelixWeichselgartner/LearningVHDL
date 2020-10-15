
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY adder IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        a : IN std_logic_vector(7 DOWNTO 0);
        b : IN std_logic_vector(7 DOWNTO 0);
        Q : OUT std_logic_vector(7 DOWNTO 0);
        c : OUT std_logic);
END adder;

ARCHITECTURE arch OF adder IS
    SIGNAL sum : std_logic_vector(8 DOWNTO 0);
BEGIN

    -- combinational logic
    PROCESS (a, b)
    BEGIN
        sum <= ('0' & a) + ('0' & b);
    END PROCESS;

    c <= sum(8);
    Q <= sum(7 DOWNTO 0);

END arch;