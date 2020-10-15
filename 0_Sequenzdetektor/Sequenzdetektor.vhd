
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY sequence_detector IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        x : IN std_logic;
        clk : IN std_logic;
        y : OUT std_logic;
        current_seq : OUT std_logic_vector (2 DOWNTO 0));
END sequence_detector;

ARCHITECTURE arch OF sequence_detector IS
    SIGNAL SEQUENCE : std_logic_vector(2 DOWNTO 0) := "000";
    SIGNAL q : std_logic := '0';
BEGIN

    -- sequential logic
    PROCESS (clk)
    BEGIN
        IF rising_edge(clk) THEN
            SEQUENCE <= x & SEQUENCE(2) & SEQUENCE(1);
        END IF;
    END PROCESS;

    -- combinational logic
    PROCESS (SEQUENCE)
    BEGIN
        IF SEQUENCE = "010" THEN
            y <= '1';
        ELSE
            y <= '0';
        END IF;
    END PROCESS;

    current_seq <= SEQUENCE;
    -- y <= q;

END arch;