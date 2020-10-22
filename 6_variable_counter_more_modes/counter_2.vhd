
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions

ENTITY counter_2 IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        CLK, CLR, EN : IN std_logic;
         -- 00: dont count
         -- 01: count up
         -- 10: count down
         -- 11: count up by 3
        dir : std_logic_vector(1 DOWNTO 0);
        max : IN std_logic_vector(3 DOWNTO 0); -- max value for counter
        Q : OUT std_logic_vector(3 DOWNTO 0));
END counter_2;

ARCHITECTURE archi OF counter_2 IS
    -- internal signals of type unsigned for arithmetic operations
    SIGNAL count, count_next : unsigned(3 DOWNTO 0);
BEGIN

    -- if the max value is changed reset the counter;
    PROCESS (max)
    BEGIN
        -- behaviour for changing max
    END PROCESS;

    -- combinational logic
    PROCESS (count, dir)
    BEGIN
        -- dont count
        IF dir = "00" THEN
            count_next <= count;
        -- count up
        ELSIF dir = "01" THEN
            count_next <= count + 1;

            IF (count = unsigned(max) - 1) THEN
                count_next <= "0000";
            END IF;
        -- count down
        ELSIF dir = "10" THEN
            count_next <= count - 1;

            -- not clearly described how it should work
            IF (count = "0000") THEN
                count_next <= unsigned(max) - 1;
            END IF;
        -- count up by 3
        ELSIF dir = "11" THEN
            count_next <= count + 3;

            IF (count >= unsigned(max) - 3) THEN
                count_next <= unsigned(max) - count;
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
            -- dont up or count up by 3
            IF (dir = "01" or dir = "11") THEN
                count <= "0000";
            -- count down
            ELSIF dir = "10" THEN
                count <= unsigned(max) - 1;
            -- dont count -> not specified what to do
            ELSIF dir = "00" THEN
                count <= "0000";
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