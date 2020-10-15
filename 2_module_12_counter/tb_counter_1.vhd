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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_counter_1 is
--  Port ( );
end tb_counter_1;

architecture Behavioral of tb_counter_1 is

    constant T : time := 20 ns; -- clock period

    signal clk, clr, en : std_logic;  -- input
    signal q : std_logic_vector(3 downto 0);

    component counter_1 is
    port(CLK, CLR, EN : in std_logic;
         Q : out std_logic_vector(3 downto 0));
    end component;

begin

    dut : counter_1
    port map (
       clk => clk, clr => clr, en  => en,
       q   => q
    );

    -- continuous clock
    process
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;
    end process;

    -- reset = 1 for first clock cycle and then 0
--    clr <= '1', '0' after T/2;

--    en  <= '0', '1' after T*5;

    -- test procedure
    process
    variable i: integer;
    begin
        clr <= '1';
        en  <= '0';
        wait until rising_edge(clk);
        clr <= '0' after 1 ns;
        for i in 0 to 5 loop
            wait until rising_edge(clk);
        end loop;
        en  <= '1' after 1 ns;
        for i in 0 to 11 loop
            wait until rising_edge(clk);
            assert q = std_logic_vector(TO_UNSIGNED(i,4)) -- convert integer (i) to 1. to Unsigned
            report "Counter value is not correct."        --                        2. to std_logic_vector
            severity FAILURE;
        end loop;
        wait;
    end process;

end Behavioral;
