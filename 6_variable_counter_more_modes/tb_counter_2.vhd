----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 02.10.2020 23:27:21
-- Design Name:
-- Module Name: tb_counter_1 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY tb_counter_2 IS
    --  Port ( );
END tb_counter_2;

ARCHITECTURE Behavioral OF tb_counter_2 IS

    CONSTANT T : TIME := 20 ns; -- clock period

    SIGNAL clk, clr, en : STD_LOGIC; -- input
    SIGNAL dir : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL max : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL q : STD_LOGIC_VECTOR(3 DOWNTO 0);

    COMPONENT counter_2 IS
        PORT (
            CLK, CLR, EN : IN STD_LOGIC;
            dir : STD_LOGIC_VECTOR(1 DOWNTO 0); -- 0: count down 1: count up
            max : IN STD_LOGIC_VECTOR(3 DOWNTO 0); -- max value for counter
            Q : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
    END COMPONENT;

BEGIN

    dut : counter_2
    PORT MAP(
        clk => clk, clr => clr, en => en,
        dir => dir, max => max,
        q => q
    );

    -- continuous clock
    PROCESS
    BEGIN
        clk <= '0';
        WAIT FOR T/2;
        clk <= '1';
        WAIT FOR T/2;
    END PROCESS;

    -- reset = 1 for first clock cycle and then 0
    --    clr <= '1', '0' after T/2;

    --    en  <= '0', '1' after T*5;

    -- test procedure
    PROCESS
        VARIABLE i : INTEGER;
    BEGIN
        -- test mode 01
        clr <= '1';
        en <= '0';
        dir <= "01";
        max <= "1100"; -- == C == 12
        WAIT UNTIL rising_edge(clk);
        clr <= '0' AFTER 1 ns;
        FOR i IN 0 TO 5 LOOP
            WAIT UNTIL rising_edge(clk);
        END LOOP;
        en <= '1' AFTER 1 ns;
        FOR i IN 0 TO 11 LOOP
            WAIT UNTIL rising_edge(clk);
            ASSERT q = STD_LOGIC_VECTOR(TO_UNSIGNED(i, 4)) -- convert integer (i) to 1. to Unsigned
            REPORT "Counter value is not correct." --                        2. to std_logic_vector
                SEVERITY FAILURE;
        END LOOP;

        -- test mode 10
        en <= '0';
        dir <= "10";
        clr <= '1';
        WAIT UNTIL rising_edge(clk);
        clr <= '0' AFTER 1 ns;
        FOR i IN 0 TO 5 LOOP
            WAIT UNTIL rising_edge(clk);
        END LOOP;
        en <= '1' AFTER 1 ns;
        FOR i IN 11 DOWNTO 0 LOOP
            WAIT UNTIL rising_edge(clk);
            ASSERT q = STD_LOGIC_VECTOR(TO_UNSIGNED(i, 4)) -- convert integer (i) to 1. to Unsigned
            REPORT "Counter value is not correct." --                        2. to std_logic_vector
                SEVERITY FAILURE;
        END LOOP;

        -- test mode 00
        en <= '0';
        dir <= "00";
        clr <= '1';
        WAIT UNTIL rising_edge(clk);
        clr <= '0' AFTER 1 ns;
        FOR i IN 0 TO 5 LOOP
            WAIT UNTIL rising_edge(clk);
        END LOOP;
        en <= '1' AFTER 1 ns;
        FOR i IN 11 DOWNTO 0 LOOP
            WAIT UNTIL rising_edge(clk);
            ASSERT q = STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)) -- convert integer (i) to 1. to Unsigned
            REPORT "Counter value is not correct." --                        2. to std_logic_vector
                SEVERITY FAILURE;
        END LOOP;

        -- test mode 11
        en <= '0';
        dir <= "11";
        clr <= '1';
        max <= "1101"; -- == D == 13
        WAIT UNTIL rising_edge(clk);
        clr <= '0' AFTER 1 ns;
        FOR i IN 0 TO 5 LOOP
            WAIT UNTIL rising_edge(clk);
        END LOOP;
        en <= '1' AFTER 1 ns;
        FOR i IN 0 TO 11 LOOP
            WAIT UNTIL rising_edge(clk);
            ASSERT q = STD_LOGIC_VECTOR(TO_UNSIGNED(i * 3, 4)) -- convert integer (i) to 1. to Unsigned
            REPORT "Counter value is not correct." --                        2. to std_logic_vector
                SEVERITY ERROR;
        END LOOP;

        WAIT;
    END PROCESS;

END Behavioral;