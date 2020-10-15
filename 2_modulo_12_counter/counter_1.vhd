
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions

ENTITY counter_1 IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        CLK, CLR, EN : IN std_logic;
        Q : OUT std_logic_vector(3 DOWNTO 0));
END counter_1;

ARCHITECTURE archi OF counter_1 IS
    -- internal signals of type unsigned for arithmetic operations
    SIGNAL count, count_next : unsigned(3 DOWNTO 0);
BEGIN

    -- combinational logic
    PROCESS (count)
    BEGIN
        count_next <= count + 1;
        IF (count = "1011") THEN
            count_next <= "0000";
        END IF;
    END PROCESS;

    -- sequential logic
    PROCESS (CLK, CLR)
    BEGIN
        IF (CLR = '1') THEN -- asynchronous reset
            count <= "0000";
        ELSIF (rising_edge(CLK)) THEN
            IF (EN = '1') THEN
                count <= count_next AFTER 1 ns; -- after statement is ignored during synthesis
                -- but simulation waveform clearer
                --            count <= count_next;
            END IF;
        END IF;
    END PROCESS;

    -- output assignment
    Q <= std_logic_vector(count); -- conversion function required

END archi;