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

    CONSTANT T : TIME := 10 ns; -- clock period

    SIGNAL x, clk : std_logic;
    SIGNAL SEQUENCE : std_logic_vector(15 DOWNTO 0) := "0101010101010101"; --"1011101110101110";
    SIGNAL y : std_logic;
    SIGNAL current_seq : std_logic_vector (2 DOWNTO 0);

    COMPONENT sequence_detector IS
        PORT (
            x : IN std_logic;
            clk : IN std_logic;
            y : OUT std_logic;
            current_seq : OUT std_logic_vector (2 DOWNTO 0)
        );
    END COMPONENT;

BEGIN

    dut : sequence_detector
    PORT MAP(
        x => x, y => y, clk => clk, current_seq => current_seq
    );

    -- continuous clock
    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR T/2;
        clk <= '1';
        WAIT FOR T/2;
    END PROCESS;

    -- test procedure
    PROCESS
        VARIABLE i : unsigned(0 TO 15);
    BEGIN
        x <= '0';
        FOR i IN 0 TO 15 LOOP
            WAIT UNTIL rising_edge(clk);
            x <= SEQUENCE(i);

            --assert y = 
            --report "value is not correct." 
            --severity FAILURE;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;