
LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions

ENTITY counter_2 IS
    -- all ports of type std_logic / std_logic_vector
    PORT (
        SCLR, ACLR, CLK, EN : IN STD_LOGIC;
        -- 00: dont count
        -- 01: count up
        -- 10: count down
        -- 11: count up by 3
        dir : STD_LOGIC_VECTOR(1 DOWNTO 0);
        max : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- max value for counter
        Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END counter_2;

ARCHITECTURE archi OF counter_2 IS
    -- internal signals of type unsigned for arithmetic operations
    SIGNAL count, count_next : unsigned(3 DOWNTO 0);
BEGIN

    -- combinational logic
    PROCESS (count, dir, max, sclr)
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
        ELSE
            count_next <= "0000";
        END IF;

        IF (sclr = '1') THEN -- synchronous reset
            count_next <= "0000";
            -- dont up or count up by 3
            IF (dir = "01" OR dir = "11") THEN
                count_next <= "0000";
                -- count down
            ELSIF dir = "10" THEN
                count_next <= unsigned(max) - 1;
                -- dont count -> not specified what to do
            ELSIF dir = "00" THEN
                count_next <= "0000";
            END IF;
        END IF;

    END PROCESS;

    -- sequential logic
    PROCESS (CLK, ACLR)
    BEGIN
        IF (ACLR = '1') THEN -- asynchronous reset
            count <= "0000";
        ELSIF (rising_edge(CLK)) THEN
            IF (EN = '1') THEN
                count <= count_next AFTER 1 ns; -- after statement is ignored during synthesis
                -- but simulation waveform clearer
                --              count <= count_next;
            ELSE
            -- synchronous reset also works if not enabled
                IF (SCLR = '1') THEN
                    count <= count_next AFTER 1 ns;
                    END IF;
            END IF;
        END IF;
    END PROCESS;

    -- output assignment
    Q <= STD_LOGIC_VECTOR(count); -- conversion function required

END archi;