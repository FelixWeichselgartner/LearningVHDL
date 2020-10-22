
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions

ENTITY counter_2 IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        CLK, CLR, EN : IN STD_LOGIC;
        Q : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END counter_2;

ARCHITECTURE archi OF counter_2 IS
    -- internal signals of type unsigned for arithmetic operations
    SIGNAL count, count_next : unsigned(6 DOWNTO 0);
BEGIN

    -- combinational logic
    PROCESS (count)
    BEGIN
        count_next <= count + 1;
        --120: 01111000 -- 12: 1100
        IF (count = "1110111") THEN
            count_next <= "0000000";
        END IF;
    END PROCESS;

    -- sequential logic
    PROCESS (CLK, CLR)
    BEGIN
        IF (CLR = '1') THEN -- asynchronous reset
            count <= "0000000";
        ELSIF (rising_edge(CLK)) THEN
            IF (EN = '1') THEN
                count <= count_next AFTER 1 ns; -- after statement is ignored during synthesis
                -- but simulation waveform clearer
                --            count <= count_next;
            END IF;
        END IF;
    END PROCESS;

    -- output assignment
    Q <= STD_LOGIC_VECTOR(count); -- conversion function required

END archi;