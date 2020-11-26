LIBRARY ieee;
USE ieee.std_logic_1164.ALL; -- to use std_logic / std_logic_vector
USE ieee.numeric_std.ALL; -- to use arithmetic functions
USE ieee.std_logic_unsigned.ALL; -- add std_logic_vectors

ENTITY vga_ctrl IS
    -- all ports of type std_logic / std_logic_vector
    port(
        clk : in std_logic; -- 25 MHz clock
        rst : in std_logic;   
        vga_hs : out std_logic;
        vga_vs : out std_logic;
        vga_red : out std_logic_vector (3 downto 0);
        vga_blue : out std_logic_vector (3 downto 0);
        vga_green : out std_logic_vector (3 downto 0)
    );
END vga_ctrl;

ARCHITECTURE arch OF vga_ctrl IS
    --***640x480@60Hz***--
    constant FRAME_WIDTH  : unsigned(11 DOWNTO 0) := x"280";
    constant SYNC_WIDTH  : unsigned(11 DOWNTO 0) := x"320";
    constant SYNC_PULSE_WIDTH : unsigned(11 DOWNTO 0) := x"060";
    constant FRONT_PORCH_WIDTH  : unsigned(11 DOWNTO 0) := x"010";
    constant BACK_PORCH_WIDTH  : unsigned(11 DOWNTO 0) := x"030";
    signal horizontal_counter : unsigned(11 DOWNTO 0) := "000000000000";
    constant FRAME_HEIGHT : unsigned(11 DOWNTO 0) := x"1e0";
    constant SYNC_HEIGHT  : unsigned(11 DOWNTO 0) := x"209";
    constant SYNC_PULSE_HEIGHT : unsigned(11 DOWNTO 0) := x"002";
    constant FRONT_PORCH_HEIGHT  : unsigned(11 DOWNTO 0) := x"00a";
    constant BACK_PORCH_HEIGHT  : unsigned(11 DOWNTO 0) := x"01d";
    signal vertical_counter: unsigned(11 DOWNTO 0) := "000000000000";
BEGIN

    -- combinatorical logic
    process (horizontal_counter, vertical_counter)
    begin
        
        vga_hs <= '1';
        vga_vs <= '1';
        vga_red <= "0000";
        vga_green <= "0000";
        vga_blue <= "0000";
        
        -- horizontal sync pulse
            if horizontal_counter < SYNC_PULSE_WIDTH then
                vga_hs <= '0';
                end if;

        -- vertical sync pulse
        if vertical_counter < SYNC_PULSE_HEIGHT then
            vga_vs <= '0';

        -- back porch
        elsif vertical_counter >= SYNC_PULSE_HEIGHT and 
              vertical_counter < SYNC_PULSE_HEIGHT + BACK_PORCH_HEIGHT then
            -- wait

        -- display
        elsif vertical_counter >= SYNC_PULSE_HEIGHT + BACK_PORCH_HEIGHT and 
              vertical_counter < SYNC_PULSE_HEIGHT + BACK_PORCH_HEIGHT + FRAME_HEIGHT then
        
            -- horizontal sync pulse
            if horizontal_counter < SYNC_PULSE_WIDTH then
                vga_hs <= '0';

            -- back porch
            elsif horizontal_counter >= SYNC_PULSE_WIDTH and
                  horizontal_counter < SYNC_PULSE_WIDTH + BACK_PORCH_WIDTH then
                -- wait

            -- display
            elsif horizontal_counter >= SYNC_PULSE_WIDTH + BACK_PORCH_WIDTH and 
                  horizontal_counter < FRAME_WIDTH + SYNC_PULSE_WIDTH + BACK_PORCH_WIDTH then
                
                -- or get values from rom[vertical_counter - SYNC_PULSE_HEIGHT][horizontal_counter - SYNC_PULSE_WIDTH]
                vga_red <= "0000";
                vga_green <= "1111";
                vga_blue <= "0000";
                
            -- porch
            end if;
        
        -- porch
        end if;
    end process;

    -- sequential logic
    process (clk, rst) 
    begin
        if rst = '1' then
            horizontal_counter <= "000000000000";
            vertical_counter <= "000000000000";
        elsif rising_edge(clk) then
            
            horizontal_counter <= horizontal_counter + 1;
            
            if horizontal_counter = 799 and vertical_counter = 520 then
                horizontal_counter <= "000000000000";
                vertical_counter <= "000000000000";
            else
                if horizontal_counter = SYNC_WIDTH - 1 then
                    vertical_counter <= vertical_counter + 1;
                    horizontal_counter <= "000000000000";
                end if;
                
                if vertical_counter = SYNC_HEIGHT then
                    vertical_counter <= "000000000000";
                end if;
            end if;
            
        end if;
    end process;

END arch;

