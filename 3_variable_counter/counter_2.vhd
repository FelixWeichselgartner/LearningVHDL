
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions

ENTITY counter_2 IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        CLK, CLR, EN : IN std_logic;
        dir : std_logic; -- 0: count down 1: count up
        max : IN std_logic_vector(3 DOWNTO 0); -- max value for counter
        Q : OUT std_logic_vector(3 DOWNTO 0));
END counter_2;

ARCHITECTURE archi OF counter_2 IS
    -- internal signals of type unsigned for arithmetic operations
    SIGNAL count, count_next : unsigned(3 DOWNTO 0);
BEGIN

    -- combinational logic
    PROCESS (count, dir)
    BEGIN
        IF dir = '1' THEN
            count_next <= count + 1;

            IF (count = unsigned(max) - 1) THEN
                count_next <= "0000";
            END IF;
        ELSE
            count_next <= count - 1;

            -- not clearly described how it should work
            IF (count = "0000") THEN
                count_next <= unsigned(max) - 1;
            END IF;
        END IF;

        -- remove dir switching artefacts
        --if rising_edge(dir) then
        --    count_next <= "0000";
        --elsif falling_edge(dir) then
        --   count_next <= unsigned(max) - 1;
        --end if;
    END PROCESS;

    -- sequential logic
    PROCESS (CLK, CLR)
    BEGIN
        IF (CLR = '1') THEN -- asynchronous reset
            IF dir = '1' THEN
                count <= "0000";
            -- END IF; here should be no logic => removed in 6_variable_counter_more_nodes
            ELSE
                count <= unsigned(max) - 1;
            END IF;
        ELSIF (rising_edge(CLK)) THEN
            IF (EN = '1') THEN
                count <= count_next AFTER 1 ns; -- after statement is ignored during synthesis
                -- but simulation waveform clearer
                --              count <= count_next;
            END IF;
        END IF;
    END PROCESS;

    -- output assignment
    Q <= std_logic_vector(count); -- conversion function required

END archi;