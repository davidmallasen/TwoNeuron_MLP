library IEEE;
use IEEE.std_logic_1164.all;

use work.fixed_float_types.all;
use work.fixed_pkg.all;
use work.types_and_constants.all;

entity tb_psum is
end tb_psum;

architecture test of tb_psum is

    signal data_in_arr : sfixed_array := (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(3.0, intbits-1, -fracbits), to_sfixed(4.0, intbits-1, -fracbits),
                                            to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits), to_sfixed(-3.0, intbits-1, -fracbits), to_sfixed(-4.0, intbits-1, -fracbits));
    signal weights_arr : sfixed_array := (to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits),
                                            to_sfixed(1.0, intbits-1, -fracbits), to_sfixed(2.0, intbits-1, -fracbits), to_sfixed(-1.0, intbits-1, -fracbits), to_sfixed(-2.0, intbits-1, -fracbits));

    signal clk : std_logic := '0';
    signal rst : std_logic;
    signal data_in : sfixed(intbits-1 downto -fracbits);
    signal weight : sfixed(intbits-1 downto -fracbits);
    signal bias : sfixed(intbits-1 downto -fracbits);
    signal step : integer range 0 to n;
    signal result : sfixed(intbits-1 downto -fracbits);

begin

    dut: entity work.psum
        port map(clk, rst, data_in, weight, bias, step, result);

    clk <= not clk after 5 ns;

    process
    begin
        rst <= '1';

        wait for 5 ns;

        rst <= '0';
        bias <= to_sfixed(1.0, intbits-1, -fracbits);

        wait for 5 ns;

        step <= 0;

        wait for 5 ns;

        for i in 1 to n loop
            data_in <= data_in_arr(i-1);
            weight <= weights_arr(i-1);
            wait for 5 ns;
            step <= i;
            wait for 5 ns;
        end loop;

        -- Result should be equal to the bias, as weights * data_in = 0

        wait for 15 ns;

        step <= 0;

        wait for 10 ns;
    end process;

end test;