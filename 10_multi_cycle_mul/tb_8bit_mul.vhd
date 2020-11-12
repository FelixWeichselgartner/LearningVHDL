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

ENTITY tb_mul IS
    --  Port ( );
END tb_mul;

ARCHITECTURE Behavioral OF tb_mul IS

    CONSTANT T : TIME := 1 ns; -- clock period

    SIGNAL clk, rst : STD_LOGIC;
    SIGNAL start_puls : STD_LOGIC;
    SIGNAL done_puls : STD_LOGIC;
    SIGNAL a : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL b : STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL Q, res : STD_LOGIC_VECTOR(15 DOWNTO 0);

    COMPONENT mul IS
        PORT (
            clk, rst : IN STD_LOGIC;
            start_puls : IN STD_LOGIC;
            done_puls : OUT STD_LOGIC;
            a : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            b : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            Q : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));
    END COMPONENT;

BEGIN

    dut : mul
    PORT MAP(
        clk => clk, rst => rst,
        start_puls => start_puls, done_puls => done_puls,
        a => a, b => b, Q => Q
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
        VARIABLE i, l : unsigned(7 DOWNTO 0);
    BEGIN
        a <= x"00";
        b <= x"00";
        rst <= '0';

        FOR i IN 5 TO 10 LOOP
            FOR l IN 10 TO 12 LOOP
                a <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8));
                b <= STD_LOGIC_VECTOR(TO_UNSIGNED(l, 8));
                res <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8) * TO_UNSIGNED(l, 8));
                start_puls <= '1';
                WAIT FOR T;
                start_puls <= '0';

                WAIT UNTIL rising_edge(done_puls);
                WAIT FOR T;

                -- convert integer (i) to 1. to Unsigned 
                --                        2. to std_logic_vector
                ASSERT (q = res)
                REPORT "adder or carry value is not correct."
                    SEVERITY FAILURE;
            END LOOP;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;