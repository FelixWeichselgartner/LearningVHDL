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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity tb_sequence_detector is
--  Port ( );
end tb_sequence_detector;

architecture Behavioral of tb_sequence_detector is

    constant T : time := 10 ns; -- clock period

    signal x, clk : std_logic;
    signal sequence : std_logic_vector(15 downto 0) := "0101010101010101"; --"1011101110101110";
    signal y : std_logic;
    signal current_seq : std_logic_vector (2 downto 0);

    component sequence_detector is
	port(x :   in std_logic;
	     clk : in std_logic;
         y :   out std_logic;
         current_seq: out std_logic_vector (2 downto 0)
         );
    end component;

begin

    dut : sequence_detector
    port map (
       x => x, y => y, clk => clk, current_seq => current_seq
    );
    
    -- continuous clock
    process
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;
    end process;

    -- test procedure
    process
        variable i: unsigned(0 to 15);
    begin
        x <= '0';
        for i in 0 to 15 loop
            wait until rising_edge(clk);
            x <= sequence(i);
                
            --assert y = 
            --report "value is not correct." 
            --severity FAILURE;
        end loop;
        wait;
    end process;

end Behavioral;
