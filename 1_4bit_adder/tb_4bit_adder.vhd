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

entity tb_adder is
--  Port ( );
end tb_adder;

architecture Behavioral of tb_adder is

    constant T : time := 1 ns; -- clock period

    signal a, b, q : std_logic_vector(3 downto 0);
    signal sum : std_logic_vector(4 downto 0);
    signal c : std_logic;

    component adder is
	port(a : in std_logic_vector(3 downto 0);
	     b : in std_logic_vector(3 downto 0);
         Q : out std_logic_vector(3 downto 0);
         c : out std_logic);
    end component;

begin

    dut : adder
    port map (
       a => a, b => b, q => q, c => c
    );

    -- test procedure
    process
        variable i, l: unsigned(3 downto 0);
    begin
        for i in 0 to 15 loop
            for l in 0 to 15 loop
                a <= std_logic_vector(TO_UNSIGNED(i, 4));
                b <= std_logic_vector(TO_UNSIGNED(l, 4));
                sum <= ('0' & std_logic_vector(TO_UNSIGNED(i, 4))) 
                        + ('0' & std_logic_vector(TO_UNSIGNED(l, 4)));
                wait for T;
                
                -- convert integer (i) to 1. to Unsigned 
                --                        2. to std_logic_vector
                assert (q = (sum(3) & sum(2) & sum(1) & sum(0))) or  (c = sum(4))
                report "adder or carry value is not correct."
                
                severity FAILURE;
            end loop;
        end loop;
        wait;
    end process;

end Behavioral;
