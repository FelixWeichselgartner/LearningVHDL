----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 15.10.2020
-- Design Name:
-- Module Name: tb_4bit_adder - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY tb_sequence_detector IS
    --  Port ( );
END tb_sequence_detector;

ARCHITECTURE Behavioral OF tb_sequence_detector IS
    --"0101010101010101"; --
    CONSTANT T : TIME := 10 ns; -- clock period

    SIGNAL x, clock : std_logic;
    SIGNAL SEQUENCE : std_logic_vector(15 DOWNTO 0) := "1011101110101110";
    SIGNAL sequence_check : std_logic_vector(15 DOWNTO 0) := "0000001000000000";
    SIGNAL y_q : std_logic;
    SIGNAL a_rst : std_logic;
    SIGNAL dummy : std_logic;

    COMPONENT Sequenzdetektor IS
        PORT (
            clock : IN std_logic;
            x : IN std_logic;
            a_rst : IN std_logic;
            y_q : OUT std_logic);
    END COMPONENT;

BEGIN

    dut : Sequenzdetektor
    PORT MAP(
        x => x, y_q => y_q, clock => clock, a_rst => a_rst
    );

    -- continuous clock
    PROCESS
    BEGIN
        clock <= '0';
        WAIT FOR T/2;
        clock <= '1';
        WAIT FOR T/2;
    END PROCESS;

    -- test procedure
    PROCESS
        VARIABLE i : unsigned(0 TO 15);
    BEGIN
        a_rst <= '0';
        x <= '0';
        FOR i IN 0 TO 15 LOOP
            WAIT UNTIL rising_edge(clock);
            x <= SEQUENCE(i);
            dummy <= sequence_check(i);

            ASSERT y_q = dummy
            REPORT "value is not correct."
                SEVERITY ERROR;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;