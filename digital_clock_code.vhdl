-- Clock Divider (Divide input clock to 1 Hz)
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockDivider is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        slow_clk : out STD_LOGIC
    );
end entity ClockDivider;

architecture Behavioral of ClockDivider is
    signal counter : integer range 0 to 59999999 := 0; -- Changed to 59999999
begin
    process (clk, reset)
    begin
        if reset = '1' then
            counter <= 0;
        elsif rising_edge(clk) then
            if counter = 59999999 then -- Changed to 59999999
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    slow_clk <= '1' when counter = 59999999 else '0'; -- Changed to 59999999
end architecture Behavioral;

-- Testbench for ClockDivider
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ClockDivider_tb is
end entity ClockDivider_tb;

architecture sim of ClockDivider_tb is
    signal clk : std_logic := '0'; -- Initialize the clock signal
    constant ClockFrequency : integer := 100e6; -- 100 MHz
    constant ClockPeriod : time := 1 ns / ClockFrequency;

    signal reset : std_logic := '0'; -- Set/reset signal as needed
    signal slow_clk : std_logic;

begin
    -- Generate the clock signal
    clk_process: process
    begin
        clk <= not clk after ClockPeriod / 2; -- Toggle every half period
        wait for ClockPeriod; -- Wait for one full period
    end process;

    -- Instantiate your ClockDivider design
    uut: ClockDivider
        port map (
            clk => clk,
            reset => reset,
            slow_clk => slow_clk
        );

    -- Add your test stimulus here (if any)

end architecture sim;
