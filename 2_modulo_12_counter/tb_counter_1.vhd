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

ENTITY tb_counter_1 IS
    --  Port ( );
END tb_counter_1;

ARCHITECTURE Behavioral OF tb_counter_1 IS

    CONSTANT T : TIME := 20 ns; -- clock period

    SIGNAL clk, clr, en : std_logic; -- input
    SIGNAL q : std_logic_vector(3 DOWNTO 0);

    COMPONENT counter_1 IS
        PORT (
            CLK, CLR, EN : IN std_logic;
            Q : OUT std_logic_vector(3 DOWNTO 0));
    END COMPONENT;

BEGIN

    dut : counter_1
    PORT MAP(
        clk => clk, clr => clr, en => en,
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
        clr <= '1';
        en <= '0';
        WAIT UNTIL rising_edge(clk);
        clr <= '0' AFTER 1 ns;
        FOR i IN 0 TO 5 LOOP
            WAIT UNTIL rising_edge(clk);
        END LOOP;
        en <= '1' AFTER 1 ns;
        FOR i IN 0 TO 11 LOOP
            WAIT UNTIL rising_edge(clk);
            ASSERT q = std_logic_vector(TO_UNSIGNED(i, 4)) -- convert integer (i) to 1. to Unsigned
            REPORT "Counter value is not correct." --                        2. to std_logic_vector
                SEVERITY FAILURE;
        END LOOP;
        WAIT;
    END PROCESS;

END Behavioral;